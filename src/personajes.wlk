import wollok.game.*
import tablero.*
import ataques.*
import jugadores.*
import nivel.*

class Personaje {
	const rangoMaximoMovimiento // De Prueba: rangoMaximoMomiento = 2
	var position
	var property image
	var property vida
	const ataques = []
	var property jugador = null
	
	
	method mover(direccion){
		position = direccion.proximaPosicion(position)
	}
	
	method position() = position

	method ocupaEspacio() = true
	
	method rangoMovimiento() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla.position(), rangoMaximoMovimiento + 1) })
	
	method distanciaMenorA(casillero, distancia) = distancia < self.position().distance(casillero)
	
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
	
	method ataque(numero) = ataques.get(numero - 1)
	
	method curar(cantidad) {
		vida = (vida + cantidad).min(100)
		game.say(self, "Vida Recibida = " + cantidad.toString() + "\n Vida Restante = " + vida.toString())
	}
	
}
// Personajes: imagenes.
