import jugadores.*
import tablero.*
import ataques.*
import wollok.game.*

object turnoManager {
	var turno = new Turno(jugador = jugador1)
	
	method pasarTurno(){
		turno = new Turno(jugador = turno.jugador().siguiente())
		self.chequearGanador()
	}
	method jugadorActual() = turno.jugador()
	
	method atacarConJugadorActual(n){ // n es el numero de ataque del personaje
		if (turno.maximoDeAtaquesAlcanzado()){
			game.say(cursor, "Ya llegue al máximo de ataques")	
		}
		else{
			if (self.puedeAtacar(cursor.personajeApuntado())){ 
				self.jugadorActual().realizarAtaque(n)
				turno.agregarAtacante(cursor.personajeApuntado())
				self.chequearFinDeTurno()
			}
			else{
				game.say(cursor.personajeApuntado(), "Ya ataque")
			}
		}
	}
	
	method intentarAgarrarPersonaje(){
		if (turno.maximoDeMovidasAlcanzado()){
			game.say(cursor, "Ya llegue al máximo de movimientos")	
		}
		else{
			if (self.puedeMover(cursor.personajeApuntado())){ 
				self.jugadorActual().seleccionarParaMover()
			}
			else{
				game.say(cursor.personajeApuntado(), "Estoy cansado")
			}
		}
	}
	method agregarMovido(personaje) {turno.agregarMovido(personaje)}
	
	method chequearFinDeTurno(){
		if (turno.noSePuedeHacerMasNadaEsteTurno()){
			self.pasarTurno()
		}
	}

	method puedeMover(personaje) = turno.noMovio(personaje)
	method puedeAtacar(personaje) = turno.noAtaco(personaje)
	method movidasRestantes() = turno.movidasRestantes()
	method ataquesRestantes() = turno.ataquesRestantes()
	
	// asi repite codigo, lo intente usando poli como antes, pero no me funciono. Entonces intente asi para ver q era
	method chequearGanador(){
		if(jugador2.perdio()){
			jugador1.ganar()
		}
		if(jugador1.perdio()){
			jugador2.ganar()
		}
	}
	// para testear
	method turno(nuevoTurno) { turno = nuevoTurno }
}

class Turno{
	const jugador
	const personajesMovidos = []
	const personajesQueAtacaron = []
	const ataquesMaximos = 2 // para que ande debería ser menor a la cantidad de unidades que pueden atacar de ese jugador (personajes + edificios que atacan), si no se va a quedar esperando y va a haber que pasar el turno manualmente
	const movimientosMaximos = 3 // puede ser igual o mayor a la cantidad de personajes, no pasa como con los ataques
	method jugador() = jugador
	method movidasRealizadas() = personajesMovidos.size()
	method ataquesRealizados() = personajesQueAtacaron.size()
	method agregarAtacante(atacante) = personajesQueAtacaron.add(atacante)
	method agregarMovido(movido) = personajesMovidos.add(movido)
	method noAtaco(atacante) = not personajesQueAtacaron.contains(atacante)
	method noMovio(movido) = not personajesMovidos.contains(movido)
	method movioTodosLosQueTiene() = (personajesMovidos.asSet() == jugador.personajes().asSet())
	method maximoDeAtaquesAlcanzado() = self.ataquesRealizados() >= ataquesMaximos
	method maximoDeMovidasAlcanzado() = self.movidasRealizadas() >= movimientosMaximos or self.movioTodosLosQueTiene()
	method noSePuedeHacerMasNadaEsteTurno() = self.maximoDeAtaquesAlcanzado() and self.maximoDeMovidasAlcanzado()
	
//	method terminarTurno(){ // si los personajes también contaran las acciones que hicieron
//		personajesMovidos.forEach({personaje => personaje.resetearMovimientosTurno()})
//		personajesQueAtacaron.forEach({personaje => personaje.resetearAtaquesTurno()})
//	}
	
	// PARA MOSTRAR EN EL TABLERO
	method movidasRestantes() = movimientosMaximos.min(jugador.personajes().size()) - self.movidasRealizadas()
	method ataquesRestantes() = ataquesMaximos.min(jugador.personajes().size()) - self.ataquesRealizados()
}
