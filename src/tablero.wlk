import wollok.game.*
import direcciones.*
import ataques.*

object cursor{
	var property position = game.at(0,0)
	var seleccionado = null
	var ataqueSeleccionado = ningunAtaque
	//const ubicacionesOcupadas = #{}

	// method position() = position
	method image() = ataqueSeleccionado.mira()
	method mover(direccion) {
		position = direccion.proximaPosicion(position)
		if (seleccionado != null) seleccionado.mover(direccion) 
	}
	
	method ubicacionOcupada(){ game.colliders(self).any({visual => visual.ocupaEspacio()}) }

	method seleccionar(){
		if (seleccionado == null) { seleccionado = self.personajeApuntado() } // uniqueCollider: Returns the unique object that is in same position of given object.
		else seleccionado = null
	}
	
	method personajeApuntado(){ return game.uniqueCollider(self)}
	
	method seleccionarAtaque(n){
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
	
	method casilleroDe(personaje) = casillas.find({ casillero => casillero.ocupante(personaje) })
		
	method casillero(x, y) = casillas.find({casillero => casillero.coordenadas().x() == x && casillero.coordenadas().y() == y})
	
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
	
	method casillasAlzanzablesEnUnaLineaRecta(casillero) = casillas.filter({casilla => casilla.puedeSerAlzanzadaEnUnaLineaRecta(casilla)}) 
	//casilleros que estan en la misma fila o columna que el casillero pasado como parametro, y no tienen ningun objeto en el medio de los dos. 
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
	
	method position() = game.at(coordenadas.x() + 4, coordenadas.y() + 1)
	
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
	
	// PROBAR
	method mismaFila(otraCasilla) = self.coordenadas().x() == otraCasilla.coordenadas().x()
	method mismaColumna(otraCasilla) = self.coordenadas().y() == otraCasilla.coordenadas().y()
	method estaEntreDosEnLaMismaColumna(casilla, otraCasilla) = self.mismaColumna(casilla) and self.mismaColumna(otraCasilla) and self.coordenadas().x().between(casilla.coordenadas().y(), otraCasilla.coordenadas().y())
	method estaEntreDosEnLaMismaFila(casilla, otraCasilla) = self.mismaFila(casilla) and self.mismaFila(otraCasilla) and self.coordenadas().x().between(casilla.coordenadas().x(), otraCasilla.coordenadas().x())
	method puedeSerAlzanzadaEnUnaLineaRecta(otraCasilla) = tablero.casillerosEntre(self, otraCasilla).all({casilla => casilla.noTieneOcupantes()})
	method estaEntre(casilla, otraCasilla) = self.estaEntreDosEnLaMismaFila(casilla, otraCasilla) or (self.estaEntreDosEnLaMismaColumna(casilla, otraCasilla))	
//	method noTieneOcupantes() = self.ocupantes().size() == 0 // con ocupantes ya no se puede hacer porque ya no anda
}

class Coordenadas{
	var property x = 0
	var property y = 0
}

object efectos{
	method explosion(ubicacion){
		// animacion explosion
	}
}

object configuracionBoard {
	const property anchoBoard = 17
	const property altoBoard = 11
	const property tamanioCeldaBoard = 70
	
	method configurarBoard() {
		game.cellSize(tamanioCeldaBoard)
		game.height(altoBoard)
		game.width(anchoBoard)
	}
	
	method estaEnElBoard(ubicacion) = (ubicacion.x().between(0, anchoBoard-1)) && (ubicacion.y().between(0, altoBoard-2)) 
	// hacemos que no sea accesible la fila de arriba del board porque el cursor queda cortado e igual ahi iria solamente el marcador con los puntos
}