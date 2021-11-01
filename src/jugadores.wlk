import wollok.game.*
import tablero.*
import personajes.*
import direcciones.*
import turnos.*
import rangos.*

class Jugador {
	var personajes = []
	var edificios = []
	var property oponente = null
	const rangoDeDespliegueDeUnidades = rangoIlimitado // TODO: que se puedan desplegar solo en las dos primeras columnas de su lado (o algo así)
	
	method seleccionarParaMover(){
		const personaje = cursor.personajeApuntado()
		if(self.esDeJugador(personaje)){
			cursor.seleccionarPersonaje()
			turnoManager.agregarMovido(cursor.personajeApuntado())
		}
		else{
			game.say(cursor.personajeApuntado(), "No soy de los tuyos")
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
		personaje.rango(rangoDeDespliegueDeUnidades)
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
	
	method perdio() = personajes == []
	
	
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
	override method perdio() = personajes == [] or edificios == []
	method cursorJugador() = "cursor.png"
	
}


object jugador2 inherits Jugador {
	var property position = game.at(-1,0)
	var property image = "pantallaGanadoraJ2.png"
	method siguiente() = jugador1
	method cursorJugador() = "cursor2.png"
	override method perdio() = personajes == [] 
	
}