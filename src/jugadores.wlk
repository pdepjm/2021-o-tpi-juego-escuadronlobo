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
}

object jugador1 inherits Jugador {
	
}
object jugador2 inherits Jugador {
	
}