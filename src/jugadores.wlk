import wollok.game.*
import tablero.*


class Jugador {
	var personajes = []
	var edificios = []
	var property oponente = null
	
	method seleccionar(){	
		if(self.esDeJugador(cursor.personajeApuntado())){ 
			cursor.seleccionar()
		}
	}
	method realizarAtaque(n){
		if(self.esDeJugador(cursor.personajeApuntado())){ 
			cursor.seleccionarAtaque(n)
		}
		else{
			game.say(cursor.personajeApuntado(), "Que haces bro")
		}
	}
	
	method agregarPersonaje(personaje) {
		personajes.add(personaje)
		personaje.jugador(self)
	}
	
	method agregarPersonajes(listaPersonajes){
		listaPersonajes.forEach({personaje => self.agregarPersonaje(personaje)})
	}
	
	method agregarEdificio(edificio){
		edificios.add(edificio)
		edificio.jugador(self)
	} 
	
	method agregarEdificios(listaEdificios){
		listaEdificios.forEach({edificio => self.agregarEdificio(edificio)})
	}
	method esDeJugador(personaje) = personajes.contains(personaje)
	
	method matarPersonaje(personaje) {
		personajes.remove(personaje)
		if (self.perdio()) oponente.ganar()
	}
	
	method destruirEdificio(edificio){
		edificios.remove(edificio)
		if (self.perdio()) oponente.ganar()
	}
	
	method perdio() = personajes == [] or edificios == []
	
	
	method ganar(){
		game.addVisual(self)
	}
	
	// para testear
	method personajes() = personajes
}

object jugador1 inherits Jugador {
	var property position = game.at(-1,0)
	var property image = "pantallaGanadoraJ1.png"
	method siguiente() = jugador2

}

object jugador2 inherits Jugador {
	var property position = game.at(-1,0)
	var property image = "pantallaGanadoraJ2.png"
	method siguiente() = jugador1
	
}