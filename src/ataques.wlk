import wollok.game.*
import tablero.*

object testear{
	method inicializar(){
		
	}
}

class Ataque{
	var atacante = null
	
	method miraCuandoEstaEnElRango() = "mira.png"
	
	method mira() {
		if (self.esAtacable(cursor.position())) return self.miraCuandoEstaEnElRango()
		else return "prohibido.png"
	}
	
	// para redefinir en cada clase heredera
	method posicionesAtacables() = tablero.casillas().map({casilla => casilla.position()}) // son objetos POSITION
	method realizarEfectoAtaque(_) {}
	method objetivosMaximos() = 1
	
	method marcarComoSeleccionado(nuevoAtacante){
		game.say(cursor, "ataque seleccionado")
		
		atacante = nuevoAtacante
//		tablero.pintarCasillerosEn(self.posicionesAtacables())
	}
	
	method realizarAtaque(posicion){
		if (self.esAtacable(posicion)){
			self.realizarEfectoAtaque(posicion)
			self.borrarAtacanteSeleccionado()
			cursor.borrarAtaqueSeleccionado()
			tablero.despintarCasillerosAtaque()
			}
		else (game.say(cursor, "no se puede atacar esta ubicación"))
	}
	
	method borrarAtacanteSeleccionado(){
		atacante = null
	}
	
	method esAtacable(posicion) = self.posicionesAtacables().contains(posicion)
	
	// para testear
	method atacante() = atacante
	method atacante(nuevo) {atacante = nuevo}
}

object ningunAtaque{
	method marcarComoSeleccionado(_) {}
	method realizarAtaque(_) {}
	method mira() = "cursor.png" 
}

class ProyectilEnArco inherits Ataque { // clase abstracta
	var rangoMaximo = 3
	
	// TODO: esto no es responsabilidad del ataque, ponerlo en otro lado?
	override method posicionesAtacables() = tablero.posicionesCasillas().filter({ posicion => self.distanciaMenorA(posicion, rangoMaximo + 1) })
	method distanciaX(posicion) = (atacante.position().x() - posicion.x()).abs()
	method distanciaY(posicion) = (atacante.position().y() - posicion.y()).abs()
	method distanciaXMenorA(posicion, distancia) = self.distanciaX(posicion) < distancia
	method distanciaYMenorA(posicion, distancia) = self.distanciaY(posicion) < distancia
	method distanciaMenorA(posicion, distancia) = self.distanciaXMenorA(posicion, distancia) && self.distanciaYMenorA(posicion, distancia)
}

class GomeraDePiedras inherits ProyectilEnArco{
	var danio = 30
		
	override method realizarEfectoAtaque(posicion){
		game.say(atacante, "pium pium")
		game.uniqueCollider(cursor).recibirDanio(danio)
	}
	//para testear
	method danio() = danio
}

class GomeraCuradora inherits ProyectilEnArco{
	var curacion = 30
	
	override method realizarEfectoAtaque(posicion){
		game.say(atacante, "te curo amigo")
		game.uniqueCollider(cursor).curar(curacion)
	}
	// para testear
	method curacion() = curacion
}

class DisparoLineaRecta inherits Ataque {
	var rango = 2
	var danio = 50
	var posicionesAtacables = []
	var ultimaPosicionAtacante = null
	
	override method realizarEfectoAtaque(posicion){
		game.say(atacante, "disparo")
		game.uniqueCollider(cursor).recibirDanio(danio)
	}
	
	// dejo las posiciones atacables guardadas en una variable para mejorar el rendimiento (si no se trababa)
	override method posicionesAtacables(){
		if (atacante.position() != ultimaPosicionAtacante){ // si cambio la posicion, actualiza las posiciones atacables
			ultimaPosicionAtacante = atacante.position()	
			posicionesAtacables = tablero.casillasEnLaMismaFilaOColumna(tablero.casilleroDe(atacante)).map({casillero => casillero.position()}) // en un futuro va a ser casillasAlcanzablesEnUnaLineaRecta
			}
		return posicionesAtacables
	}
}

class AtaqueMele{ // clase abstracta
	
}

class AtaqueCuchillo inherits AtaqueMele {
	var rango = 1
	var danioBase = 1
	
	method lanzarAtaque(ubicacion) {
//		cursor.seleccionarAtaque(self)
	}
	method hacerDanio(ubicacion){
		game.colliders(self).forEach({personaje => personaje.hacerDanio(danioBase)})
	}
}

class Mina{ // una mina que se deposita en un casillero y se activa cuando la pisan
	
}

class DisparoMultiple{
	
}

class Granada inherits ProyectilEnArco {
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