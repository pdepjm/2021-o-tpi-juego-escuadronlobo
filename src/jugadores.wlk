import wollok.game.*

class Jugador {
	var personajes = []
	
	method agregarPersonaje(personaje) {
		personajes.add(personaje)
		personaje.jugador(self)
	}
	
	
	method agregarPersonajes(listaPersonajes){
		listaPersonajes.forEach({personaje => self.agregarPersonaje(personaje)})
	} 
	method esDeJugador(personaje) = personajes.contains(personaje)
	
	method matarPersonaje(personaje) = personajes.remove(personaje)
	
	method perdio() = personajes == []
	
	method ganar(){
		game.addVisual(self)
	}

}

object jugador1 inherits Jugador {
	var property position = game.at(0,0)
	var property image = "pantallaGanadoraJ1.png"

}

object jugador2 inherits Jugador {
	var property position = game.at(0,0)
	var property image = "pantallaGanadoraJ2.png"
	
}