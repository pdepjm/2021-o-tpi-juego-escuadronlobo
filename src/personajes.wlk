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
		game.say(self, "Vida Recibida = " + cantidad.toString() + "\n Vida Restante = " + vida.toString())
	}
	
}

class Tanque inherits Personaje {
	override method mover(direccion){
		position = direccion.proximaPosicion(position)
		direccion.orientar(self)
	}
	
	method mirarDerecha() {
		self.image(jugador.tanqueDerecha())
	}
	method mirarIzquierda() {
		self.image(jugador.tanqueIzquierda())
	}
	method mirarAbajo() {
		self.image(jugador.tanqueAbajo())
	}
	method mirarArriba() {
		self.image(jugador.tanqueArriba())
	}
}


class Avion inherits Personaje{
	method volarA(posicion) { position = posicion }
	
	override method mover(direccion){
		position = direccion.proximaPosicion(position)
		direccion.orientar(self)
	}
	
	method mirarDerecha() {
		self.image(jugador.avionDerecha())
	}
	method mirarIzquierda() {
		self.image(jugador.avionIzquierda())
	}
	method mirarAbajo() {
		self.image(jugador.avionAbajo())
	}
	method mirarArriba() {
		self.image(jugador.avionArriba())
	}
	
	
}


class Edificio inherits Unidad {
	override method morir(){
		jugador.destruirEdificio(self)
		game.removeVisual(self)
	}
	method curar(_){
		game.say(self, "No me puedo curar")
	}
}
