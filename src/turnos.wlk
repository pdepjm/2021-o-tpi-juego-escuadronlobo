import jugadores.*
import tablero.*

object turno {
	
	method pasarTurno(){
		self.chequearGanador()
		// cursor.cambiarColor()
	}
	// asi rpite codigo, lo intente usando poli como antes, pero no me funciono. Entonces intente asi para ver q era
	method chequearGanador(){
		if(jugador2.perdio()){
			jugador1.ganar()
		}
		if(jugador1.perdio()){
			jugador2.ganar()
		}
	}
}
