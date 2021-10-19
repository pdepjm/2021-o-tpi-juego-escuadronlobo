import wollok.game.*
import tablero.*


class Jugador {
	var personajes = []
	var property oponente = null
	var property turno = null
	
	method seleccionar(){
		var personaje = cursor.personajeApuntado()
		
		if(personajes.contains(personaje)){ 
			cursor.seleccionar()
		}
	}
	
	method pasarTurnoA(jugador){
		self.turno(!turno)
		jugador.turno(turno)
		
	}
	
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
	
	// para testear
	method personajes() = personajes
}

object jugador1 inherits Jugador {
	var property position = game.at(0,0)
	var property image = "pantallaGanadoraJ1.png"
	override method turno() = true

}

object jugador2 inherits Jugador {
	var property position = game.at(0,0)
	var property image = "pantallaGanadoraJ2.png"
	override method turno() = false
	
}