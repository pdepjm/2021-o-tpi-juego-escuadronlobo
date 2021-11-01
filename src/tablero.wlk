import wollok.game.*
import direcciones.*
import ataques.*
import turnos.*

object cursor{
	var property position = game.at(0,7)
	var seleccionado = null
	var ataqueSeleccionado = ningunAtaque
	//const ubicacionesOcupadas = #{}
	
	method image() = ataqueSeleccionado.mira()
	method seleccionado() = seleccionado
	method mover(direccion) {
		position = direccion.proximaPosicion(position)
		if (seleccionado != null) seleccionado.mover(direccion) 
	}
	method ubicacionOcupada() = game.colliders(self).size() > 0
	method personajeApuntado(){ return game.uniqueCollider(self)}

	method seleccionar(){
		if (ataqueSeleccionado == ningunAtaque){
			if (seleccionado == null) { 
				turnoManager.intentarAgarrarPersonaje()
			}
			else {
				self.intentarSoltarPersonaje()
			}
		}
	}
	
	method seleccionarPersonaje(){
		seleccionado = self.personajeApuntado()
		seleccionado.marcarComoPersonajeSeleccionado()
	}
	method intentarSoltarPersonaje(){
		if (seleccionado.puedeMoverseA(self.position())){
			self.borrarPersonajeSeleccionado()
			turnoManager.chequearFinDeTurno()			
		}
		else{
			game.say(seleccionado, "no me puedo mover ahí")
		}
	}
	method borrarPersonajeSeleccionado(){seleccionado = null}
	
	method seleccionarAtaque(n){
		if (seleccionado != null) {self.intentarSoltarPersonaje()}
		seleccionado = null
		ataqueSeleccionado = self.personajeApuntado().ataque(n)
		ataqueSeleccionado.marcarComoSeleccionado(self.personajeApuntado())
	}
	
	method atacar(){
		ataqueSeleccionado.realizarAtaque(self.position())
		self.borrarAtaqueSeleccionado()
	}
	
	method borrarAtaqueSeleccionado() { 
		ataqueSeleccionado = ningunAtaque
	}
	
	//method cambiarCursor() = 
	
	// para los tests
	method ataqueSeleccionado() = ataqueSeleccionado
	method ataqueSeleccionado(nuevo) {ataqueSeleccionado = nuevo}
}

object tablero{
	const tamanioVertical = 7
	const tamanioHorizontal = 8
	var casillasPintadas = []
	
	const casillas = []
	method casillas() = casillas
	
	method casilleroDe(personaje) = casillas.find({ casillero => casillero.ocupadoPor(personaje) })
		
	method casillero(x, y) = casillas.find({casillero => casillero.coordenadas().x() == x && casillero.coordenadas().y() == y})
	method casillero(position) = casillas.find({casillero => casillero.position() == position})
	method estaEnElTablero(position) = casillas.any({casillero => casillero.position() == position})
	
	method crearFila(n) { tamanioHorizontal.times({i => casillas.add(new Casillero(coordenadas = new Coordenadas(x = i, y = n)))}) }
	method crearCasillas() { tamanioVertical.times({i => self.crearFila(i)}) }
	
	method configurarCasillas() { 
		self.crearCasillas()
	}
	
	method pintarCasillerosEn(posiciones) {
		casillasPintadas = posiciones.map({ubicacion => self.casillero(ubicacion.x(), ubicacion.y())})
		casillasPintadas.forEach({casillero => casillero.pintar()})
	}
	
	method despintarCasillerosAtaque() {
		casillasPintadas.forEach({casilla => casilla.despintar()})
	}
	
	method posicionesCasillas() = casillas.map({casilla => casilla.position()})
	
	//casilleros que estan en la misma fila o columna que el casillero pasado como parametro, y no tienen ningun objeto en el medio de los dos.
	method casillasAlcanzablesEnUnaLineaRecta(casilla) = casillas.filter({otroCasillero => casilla.puedeSerAlcanzadaEnUnaLineaRecta(otroCasillero)}) // NO ANDA
	
	method casillasEnLaMismaFilaOColumna(casillero)= casillas.filter({otraCasilla => otraCasilla.mismaFilaOColumna(casillero)}) // ANDA
	
	method casillerosEntre(casilla, otraCasilla) = casillas.filter({casillero => casillero.estaEntre(casilla, otraCasilla)})
}

class CirculoVerde {
	var property image = "CirculoVerde.png"
	var property position
	method mostrar() = game.addVisual(self)  
} 

class Casillero{
	const coordenadas = new Coordenadas()
	var habilitado = true
	var circuloVerde = null
	
	method coordenadas() = coordenadas
	
	method position() = game.at(coordenadas.x() + 2, coordenadas.y())
	
	method habilitado() = habilitado
	method deshabilitar() {habilitado = false}
	method habilitar() {habilitado = true}
	
	method pintar(){
		circuloVerde = new CirculoVerde(position = self.position())
		circuloVerde.mostrar()
	}
	
	method despintar(){
		game.removeVisual(circuloVerde)
	}
	
	method estaOcupado() =  game.getObjectsIn(self.position()).copyWithout(cursor).size() >= 1
		
	method ocupante(){
		if (not self.estaOcupado()) {throw new DomainException(message = "no hay un ocupante en el casillero")} // tira un error si el casillero no esta ocupado
		return (game.getObjectsIn(self.position()).copyWithout(cursor).uniqueElement())
	}
	method ocupadoPor(ocupante){
		if (self.estaOcupado()) {return self.ocupante() == ocupante}
		else return false
	}
	
	method mismaFila(otraCasilla) = self.coordenadas().y() == otraCasilla.coordenadas().y()
	method mismaColumna(otraCasilla) = self.coordenadas().x() == otraCasilla.coordenadas().x()
	method estaEntreDosEnLaMismaColumna(casilla, otraCasilla) = self.mismaColumna(casilla) and self.mismaColumna(otraCasilla) and self.coordenadas().coordYEntre(casilla.coordenadas(), otraCasilla.coordenadas())
	method estaEntreDosEnLaMismaFila(casilla, otraCasilla) = self.mismaFila(casilla) and self.mismaFila(otraCasilla) and self.coordenadas().coordXEntre(casilla.coordenadas(), otraCasilla.coordenadas())
	method estaEntre(casilla, otraCasilla) = self.estaEntreDosEnLaMismaColumna(casilla, otraCasilla) or self.estaEntreDosEnLaMismaFila(casilla, otraCasilla)
	method mismaFilaOColumna(otraCasilla) = self.mismaFila(otraCasilla) or self.mismaColumna(otraCasilla)
	
	// NO ANDA
	method puedeSerAlcanzadaEnUnaLineaRecta(otraCasilla) = self.mismaFilaOColumna(otraCasilla) and tablero.casillerosEntre(self, otraCasilla).all({casilla => !casilla.estaOcupado()})
}

class Coordenadas{
	var property x = 0
	var property y = 0
	
	method coordXEntre(coordenadas1, coordenadas2) = x.between(coordenadas1.x(), coordenadas2.x()) or x.between(coordenadas2.x(), coordenadas1.x())
	method coordYEntre(coordenadas1, coordenadas2) = y.between(coordenadas1.y(), coordenadas2.y()) or y.between(coordenadas2.y(), coordenadas1.y())
	
	// hace que se pueda mostrar en consola	
	override method toString(){
		return "(" + x.toString() + "," + y.toString() + ")"
	}
}

object efectos{
	method explosion(ubicacion){
		// animacion explosion
	}
}

object configuracionBoard {
	const property anchoBoard = 15
	const property altoBoard = 9
	const property tamanioCeldaBoard = 90
	
	method configurarBoard() {
		game.cellSize(tamanioCeldaBoard)
		game.height(altoBoard)
		game.width(anchoBoard)
	}
	
	method estaEnElBoard(ubicacion) = (ubicacion.x().between(0, anchoBoard-2)) && (ubicacion.y().between(0, altoBoard-2)) 
	// hacemos que no sea accesible la fila de arriba del board porque el cursor queda cortado e igual ahi iria solamente el marcador con los puntos
}