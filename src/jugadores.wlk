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
	
	
	method rangoDeDespliegueDeUnidades() = rangoIlimitado
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
			if(cursor.personajeApuntado().tieneAtaque(n)){cursor.seleccionarAtaque(n)}
			else{game.say(cursor.personajeApuntado(), "No tengo ataque " + n.toString())}
		}
		else{
			game.say(cursor.personajeApuntado(), "Que haces bro")
		}
	}
	
	method agregarPersonaje(personaje) {
		personajes.add(personaje)
		personaje.jugador(self)
		personaje.rango(self.rangoDeDespliegueDeUnidades())
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
	var property position = game.at(-1,0)
	var property image = "pantallaGanadoraJ1.png"	
	
	
	method siguiente() = jugador2
	override method perdio() = super() or edificios.isEmpty()
	method cursorJugador() = "cursor.png"

	override method rangoDeDespliegueDeUnidades() = new RangoColumnas(columnas = [1,2])
	
	method destruirEdificio(edificio){
		edificios.remove(edificio)
		if (self.perdio()) oponente.ganar()
	}
	
	method agregarEdificio(edificio){
		edificios.add(edificio)
		edificio.jugador(self)
	} 
	
	method agregarEdificios(listaEdificios){
		listaEdificios.forEach({edificio => self.agregarEdificio(edificio)})
	}
	
}


object jugador2 inherits Jugador {
	var property position = game.at(-1,0)
	var property image = "pantallaGanadoraJ2.png"
	method siguiente() = jugador1
	method cursorJugador() = "cursor2.png"
	override method rangoDeDespliegueDeUnidades() = new RangoColumnas(columnas = [7,8])		

}