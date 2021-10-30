import wollok.game.*
import tablero.*
import ataques.*
import jugadores.*
import nivel.*

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
		game.say(self, "Daño Recibido = " + cantidad.toString() + "\n Vida Restante = " + vida.toString())
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
	
	method mover(direccion){
		position = direccion.proximaPosicion(position)
	}
	
	method rangoMovimiento() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla.position(), rangoMaximoMovimiento + 1) })
	
	method distanciaMenorA(casillero, distancia) = distancia < self.position().distance(casillero)
	
	method ataque(numero) = ataques.get(numero - 1)
	
	method curar(cantidad) {
		vida = (vida + cantidad).min(100)
		game.say(self, "Vida Recibida = " + cantidad.toString() + "\n Vida Restante = " + vida.toString())
	}
	
}

class Avion inherits Personaje{
	method volarA(posicion) { position = posicion }
}

class Edificio inherits Unidad {
	override method morir(){
		jugador.destruirEdificio(self)
		game.removeVisual(self)
	}
}
