import jugadores.*
import tablero.*

object turnoManager {
	var property jugadorActual = jugador1
		
	method pasarTurno(){
		self.jugadorActual(jugadorActual.siguiente()) 
		self.chequearGanador()
		// cursor.cambiarColor()
	}
	// asi repite codigo, lo intente usando poli como antes, pero no me funciono. Entonces intente asi para ver q era
	method chequearGanador(){
		if(jugador2.perdio()){
			jugador1.ganar()
		}
		if(jugador1.perdio()){
			jugador2.ganar()
		}
	}
}
