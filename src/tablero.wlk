import wollok.game.*
import direcciones.*

object cursor{
	var posicion = game.at(0,0)
	var seleccionado = null
	const ubicacionesOcupadas = #{}

	method position() = posicion
	method image() = "cursor.png"
	method mover(direccion) {
		posicion = direccion.proximaPosicion(posicion)
		if (seleccionado != null) seleccionado.mover(direccion)
	}
	
	method ubicacionOcupada(){ game.colliders(self).any({visual => visual.ocupaEspacio()}) }

	method seleccionar(){
		if (seleccionado == null) { seleccionado = game.uniqueCollider(self) } // uniqueCollider: Returns the unique object that is in same position of given object.
		else seleccionado = null
	}
}

class Personaje {
	const rangoMaximoMovimiento = 2
	var position = game.at(0,0)
	var image = "soldadoNazi.png"
	
	method mover(direccion){
		position = direccion.proximaPosicion(position)
	}
	
	method position() = position
	method image() = image

	method ocupaEspacio() = true
	
	method rangoMovimiento() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla, rangoMaximoMovimiento + 1) })
	
	method distanciaMenorA(casillero, distancia) = distancia < self.position().distance(casillero)
	
	method morir(){
		game.removeVisual(self)
		efectos.explosion(tablero.casilleroDe(self))
	}
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
	const property anchoBoard = 11
	const property altoBoard = 11
	const property tamanioCeldaBoard = 400
	
	method configurarBoard() {
		game.cellSize(tamanioCeldaBoard)
		game.height(altoBoard)
		game.width(anchoBoard)
	}
	
	method estaEnElBoard(ubicacion) = (ubicacion.x().between(0, anchoBoard)) && (ubicacion.y().between(0, altoBoard))
}