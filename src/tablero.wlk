import wollok.game.*
import direcciones.*

object soldadoNazi {
	var posicion = game.at(0, 0)
	method position() = posicion
	method image() = "soldadoNazi.png"

	method ocupaEspacio() = true

	method mover(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	
	method morir(){
		game.removeVisual(self)
		efectos.explosion(posicion)
	}
}

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
	
	method ubicacionOcupada(){ game.colliders(self).any({visual => visual.esUnidad()}) }

	method seleccionar(){
		if (seleccionado == null) { seleccionado = game.uniqueCollider(self) } // uniqueCollider: Returns the unique object that is in same position of given object.
		else seleccionado = null
	}
	
}

object soldadoNoNazi {
	var posicionTableroX = 2
	var posicionTableroY = 2
	const rangoMaximoMovimiento = 2
	method position() = game.at(posicionTableroX + 1, posicionTableroY)
	method image() = "soldadoNazi.png"

	method ocupaEspacio() = true
	method casilleroActual() = tablero.casillero(posicionTableroX, posicionTableroY)
	
	method distanciaX(otroCasillero) = (posicionTableroX - otroCasillero.x()).abs()
	method distanciaY(otroCasillero) = (posicionTableroY - otroCasillero.y()).abs()
	method distanciaXMenorA(casillero, distancia) = self.distanciaX(casillero) < distancia
	method distanciaYMenorA(casillero, distancia) = self.distanciaY(casillero) < distancia
	method distanciaMenorA(casillero, distancia) = self.distanciaXMenorA(casillero, distancia) && self.distanciaYMenorA(casillero, distancia)
	

//	method rangoMovimiento() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla, rangoMaximoMovimiento + 1) })
}

object tablero{
	const tamanioVertical = 8
	const tamanioHorizontal = 8
	
	const casillas = []
	method casillas() = casillas
	
	method casillero(x, y) = casillas.find({casillero => casillero.x() == x && casillero.y() == y})
	
	method crearFila(n) { tamanioVertical.times({i => casillas.add(new Casillero(x = i, y = n))}) }
	method crearCasillas() { tamanioHorizontal.times({i => self.crearFila(i)}) }
	
	method configurarCasillas() { 
		self.crearCasillas()
	}
}

// TODO: clase "ubicable" o algo así que tenga coordenadas, distancia, y esas cosas (para que el resto herede y no haya repeticion de lógica)
class Casillero{
	const x
	const y
	var habilitado = true
	
	method x() = x
	method y() = y
	method habilitado() = habilitado
	method deshabilitar() {habilitado = false}
	method habilitar() {habilitado = true}
	method distanciaX(otroCasillero) = (x - otroCasillero.x()).abs()
	method distanciaY(otroCasillero) = (y - otroCasillero.y()).abs()
}

object efectos{
	method explosion(ubicacion){
		// animacion explosion
	}
}