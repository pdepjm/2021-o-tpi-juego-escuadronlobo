import wollok.game.*
import direcciones.*
import ataques.*

object cursor{
	var position = game.at(0,0)
	var seleccionado = null
	var ataqueSeleccionado = ningunAtaque
	//const ubicacionesOcupadas = #{}

	method position() = position
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
	
	method personajeApuntado() = game.uniqueCollider(self)
	
	method seleccionarAtaque(n){
		ataqueSeleccionado = self.personajeApuntado().ataque(n)
		ataqueSeleccionado.marcarComoSeleccionado(self.personajeApuntado())
	}
	
	method seleccionarObjetivoAtaque(){
		ataqueSeleccionado.agregarObjetivo(self.position())
	}
	
	method borrarAtaqueSeleccionado() { 
		ataqueSeleccionado = ningunAtaque
	}
	
	// para los tests
	method ataqueSeleccionado() = ataqueSeleccionado
	method ataqueSeleccionado(nuevo) {ataqueSeleccionado = nuevo}
}

object tablero{
	const tamanioVertical = 8
	const tamanioHorizontal = 8
	
	const casillas = []
	method casillas() = casillas
	
	method casilleroDe(personaje) = casillas.find({ casillero => casillero.ocupante(personaje) })
		
	method casillero(x, y) = casillas.find({casillero => casillero.coordenadas().x() == x && casillero.coordenadas().y() == y})
	
	method crearFila(n) { tamanioVertical.times({i => casillas.add(new Casillero(coordenadas = new Coordenadas(x = i, y = n)))}) }
	method crearCasillas() { tamanioHorizontal.times({i => self.crearFila(i)}) }
	
	method configurarCasillas() { 
		self.crearCasillas()
	}
	
	method pintarCasillerosAtaque(casillerosAtacables) {
		casillerosAtacables.forEach({casillero => casillero.pintar()})
	}
}

object recuadroVerde {
	var property image = "recuadroVerde.png"
	var property position 
	method mostrar() = game.addVisual(self)  
} 

class Casillero{
	const coordenadas = new Coordenadas()
	var habilitado = true
	
	method coordenadas() = coordenadas
	
	method position() = game.at(coordenadas.x() + 1, coordenadas.y())
	
	method ocupantes() = game.colliders(self)
	
	method ocupante(personaje) = self.ocupantes().contains(personaje)
	
	method habilitado() = habilitado
	method deshabilitar() {habilitado = false}
	method habilitar() {habilitado = true}
	
	method pintar(){
		recuadroVerde.position(self.position())
		return recuadroVerde.mostrar()
	}
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
}