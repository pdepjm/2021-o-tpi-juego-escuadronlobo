import wollok.game.*
import tablero.*
import ataques.*

class Personaje {
	const rangoMaximoMovimiento // De Prueba: rangoMaximoMomiento = 2
	var position = game.at(0,8)
	var image
	var vida
	const ataques = []
	
	method mover(direccion){
		position = direccion.proximaPosicion(position)
	}
	
	method vida() = vida
	method position() = position
	method image() = image

	method ocupaEspacio() = true
	
	method rangoMovimiento() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla, rangoMaximoMovimiento + 1) })
	
	method distanciaMenorA(casillero, distancia) = distancia < self.position().distance(casillero)
	
	method morir(){
		game.removeVisual(self)
		efectos.explosion(tablero.casilleroDe(self))
	}
	
	method recibirDanio (cantidad) {
		vida = (vida - cantidad).max(0)
		game.say(self, "Daño Recibido = " + cantidad.toString() + "\n Vida Restante = " + vida.toString())
	}
	
	method ataque(numero) = ataques.get(numero - 1)
	
	method curar(cantidad) {
		vida = vida + cantidad
	}
	
}
// Personajes: imagenes.