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
	var posicion = game.at(1, 0)
	method position() = posicion
	method image() = "soldadoNazi.png"

	method ocupaEspacio() = true

	method mover(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
}

object efectos{
	method explosion(ubicacion){
		// animacion explosion
	}
}