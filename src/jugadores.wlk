import wollok.game.*

class Jugador {
	var personajes = []
	var property oponente = null
	
	method agregarPersonaje(personaje) {
		personajes.add(personaje)
		personaje.jugador(self)
	}
	
	method agregarPersonajes(listaPersonajes){
		listaPersonajes.forEach({personaje => self.agregarPersonaje(personaje)})
	} 
	method esDeJugador(personaje) = personajes.contains(personaje)
	
	method matarPersonaje(personaje) {
		personajes.remove(personaje)
		if (self.perdio()) oponente.ganar()
	}
	
	method perdio() = personajes == []
	
	method ganar(){
		game.addVisual(self)
	}
	
	// para testear
	method personajes() = personajes
}

object jugador1 inherits Jugador {
	var property position = game.at(0,0)
	var property image = "pantallaGanadoraJ1.png"

}

object jugador2 inherits Jugador {
	var property position = game.at(0,0)
	var property image = "pantallaGanadoraJ2.png"
	
}