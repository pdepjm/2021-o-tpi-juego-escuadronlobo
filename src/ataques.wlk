import wollok.game.*
import tablero.*
import jugadores.*
import turnos.*
import rangos.*

object testear{
	method inicializar(){
		
	}
}

// Los ataques obtienen su rango por composición y su efecto por herencia
class Ataque{
	var atacante = null
	var potencia
	var rango = rangoIlimitado
	
	method miraCuandoEstaEnElRango() = "mira.png"
	
	method mira() {
		if (self.esAtacable(cursor.position())) return self.miraCuandoEstaEnElRango()
		else return "prohibido.png"
	}
	
	// para redefinir en cada clase heredera
	method actualizarRango() {}
	method realizarEfectoAtaque(_) {}
	
	method marcarComoSeleccionado(nuevoAtacante){
		atacante = nuevoAtacante
		self.actualizarRango()
	}
	method realizarAtaque(posicion){
		if (self.esAtacable(posicion)){
			self.realizarEfectoAtaque(posicion)
			turnoManager.registrarAtaque(atacante)
			self.borrarAtacanteSeleccionado()
			cursor.borrarAtaqueSeleccionado()
			rango = rangoIlimitado
			}
		else (game.say(cursor, "no se puede atacar esta ubicación"))
	}
	method borrarAtacanteSeleccionado(){
		atacante = null
	}
	
	method cancelarAtaque(){
		self.borrarAtacanteSeleccionado()
		cursor.borrarAtaqueSeleccionado()
	}
	
	method esAtacable(posicion) = rango.estaEnElRango(posicion)
	
	// para testear
	method atacante() = atacante
	method atacante(nuevo) {atacante = nuevo}
	method potencia() = potencia
}


object ningunAtaque{
	method marcarComoSeleccionado(_) {}
	method realizarAtaque(_) {}
	method mira(){ // TODO: cambiar esto por algo más lindo? modoAtaque y modoMover del cursor con composición?
		if (cursor.seleccionado() == null){
		return turnoManager.jugadorActual().cursorJugador()
		}
		if (cursor.seleccionado().puedeMoverseA(cursor.position())){
		return turnoManager.jugadorActual().cursorJugador()
		}
		else return "prohibido.png"
	}
	method cancelarAtaque(){}
}

class PegaEnUnaCasilla inherits Ataque{
	override method realizarEfectoAtaque(posicion){
		if (cursor.ubicacionOcupada()) {
			game.say(atacante, "pum pum")
			cursor.personajeApuntado().recibirDanio(potencia)
		}
		else{
			game.say(atacante, "le erré :(")
		}
	}
}

class CuraEnUnaCasilla inherits Ataque{
	override method realizarEfectoAtaque(posicion){
		if (cursor.ubicacionOcupada()) {
			game.say(atacante, "te curo amigo")
			cursor.personajeApuntado().curar(potencia)
		}
		else{
			game.say(atacante, "no curé a nadie :(")
		}
	}
}

class GomeraDePiedras inherits PegaEnUnaCasilla{
	const rangoMaximo
	override method actualizarRango() { rango = new RangoCuadrado(posicionBase = atacante.position(), rangoMaximo = rangoMaximo) }
}

class GomeraCuradora inherits CuraEnUnaCasilla{
	const rangoMaximo
	override method actualizarRango() { rango = new RangoCuadrado(posicionBase = atacante.position(), rangoMaximo = rangoMaximo) }
}

class Rifle inherits PegaEnUnaCasilla{
	const rangoMaximo
	override method actualizarRango() { rango = new RangoLineaRecta(posicionBase = atacante.position(), rangoMaximo = rangoMaximo) }
}

class Demolicion inherits PegaEnUnaCasilla{
	override method actualizarRango() { rango = new RangoLineaRectaEdificios(posicionBase = atacante.position(), rangoMaximo = 1) }
}


class Bombardeo inherits Ataque{
		
	override method realizarEfectoAtaque(posicion){
		const casillerosAtacados = tablero.casillerosEntre(tablero.casillero(posicion), tablero.casilleroDe(atacante))
		atacante.volarA(posicion)
		casillerosAtacados.forEach({atacado => self.pasarArribaDe(atacado)})
	}
	
	method pasarArribaDe(casillero){
		if (casillero.estaOcupado()){
			const ocupanteCasillero = casillero.ocupante()
			if (!ocupanteCasillero.esAliado(atacante)){
			ocupanteCasillero.recibirDanio(potencia)
			}
		}
	}
	
	override method actualizarRango() { rango = new RangoLineaRectaDesocupados(posicionBase = atacante.position())}}

class AtaqueMele{ // clase abstracta
	
}

class Mina{ // una mina que se deposita en un casillero y se activa cuando la pisan
	
}

class DisparoMultiple{
	
}

class Granada inherits Ataque {
	var radioExplosion = 3 // debe ser un numero impar para que pueda tener un centro
	method disminucionPotencia(distancia) = distancia * 1 //disminución de la potencia por cada unidad de distancia que nos alejamos del centro 
	 
}

class GranadaInversa inherits Granada { // una granada que pega más cuanto más nos alejemos del centro de la explosión

}

class GranadaCuracion inherits Granada {
	
	
}

/*Uso:
 * Los personajes van a poder hacer un ataque, con algo así como personaje.atacar(ataque). 
 * Los personajes van a tener ataques que sean nuevas instancias de los distintos ataques. * 
 * Esto permite que distintos personajes puedan tener ataques con el mismo comportamiento
 * pero distinto rango, daño base, etc. Por ejemplo podemos tener un personaje que pegue 
 * mucho con el cuchillo pero poco con un rifle, o un personaje francotirador que tenga mas
 * rango con el sniper, etc. 
 * El método atacar va a hacerle cosas al personaje (gastar municion o lo que sea, depende
 * del personaje) y además va a lanzar ese ataque desde la posición del personaje, mandando
 * al ataque elejido el mensaje lanzarAtaque(posición). El resto es responsabilidad del ataque.
 * 
 * SI QUEREMOS SE PUEDEN COMPARTIR ATAQUES ENTRE JUGADORES, YA QUE EL JUGADOR SOLO SE GUARDA 
 * ANTES DE REALIZAR EL ATAQUE Y SE BORRA CUANDO EL MISMO SE COMPLETA.
 * 
 */