import wollok.game.*
import tablero.*
import ataques.*
import jugadores.*
import nivel.*
import turnos.*
import rangos.*

class Unidad { // clase abstracta para personajes y edificios
	var position
	var property image
	var property vida
	var property jugador = null
	
	method position() = position

	method ocupaEspacio() = true
	
	method morir(){
		jugador.matarPersonaje(self)
		game.removeVisual(self)
	}
	
	method recibirDanio (cantidad) {
		vida = (vida - cantidad).max(0)
		game.say(self, "Daño = " + cantidad.toString() + "\n Vida = " + vida.toString())
		self.chequearEstado()
	}
	
	method chequearEstado(){
		if(vida == 0) self.morir()
	}
	
	method esAliado(unidad) = jugador == unidad.jugador()
}


class Personaje inherits Unidad {
	const rangoMaximoMovimiento // De Prueba: rangoMaximoMomiento = 2
	const ataques = []
	var property rango = null
	
	method mover(direccion){
		position = direccion.proximaPosicion(position)
	}
	
	method marcarComoPersonajeSeleccionado(){
		self.actualizarRango()
	}
	method puedeMoverseA(posicion){
		return rango.estaEnElRango(posicion) and (game.colliders(self).copyWithout(cursor).isEmpty())
	}
	method actualizarRango(){
		if (tablero.estaEnElTablero(self.position())){
			rango = new RangoCuadrado(posicionBase = self.position(), rangoMaximo = rangoMaximoMovimiento) 		
		}
	}
	
	method ataque(numero) = ataques.get(numero - 1)
	
	method curar(cantidad) {
		vida = (vida + cantidad).min(100)
		game.say(self, "Curado = " + cantidad.toString() + "\nVida = " + vida.toString())
	}
	
	method tieneAtaque(n) = n <= ataques.size()
	method esEdificio() = false
}

class VehiculoDeGuerra inherits Personaje{

	override method mover(direccion) {
		super(direccion)
		image = self.tipo() + direccion.toString() + jugador.toString() + ".png"
	}
	
	method tipo() // Método Abstracto
}

class Tanque inherits VehiculoDeGuerra {
	
	override method tipo () = "tanque"
}


class Avion inherits VehiculoDeGuerra {
	
	override method tipo () = "avion"
	
	method volarA(posicion) { position = posicion }
}


class Edificio inherits Unidad {
	override method morir(){
		jugador.destruirEdificio(self)
		game.removeVisual(self)
	}
	method curar(_){
		game.say(self, "No me puedo curar")
	}
	
	method esEdificio() = true
}

class Demoledor inherits VehiculoDeGuerra{
    override method tipo() = "demoledor"
}