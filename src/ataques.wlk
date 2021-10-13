import wollok.game.*
import tablero.*

object testear{
	method inicializar(){
		
	}
}

class Ataque{
	var atacante = null
	
	method mira() = "mira.png"
	
	
	// para redefinir en cada clase heredera
	method casillerosAtacables() = tablero.casillas() // son objetos CASILLA
	method realizarEfectoAtaque(_) {}
	method objetivosMaximos() = 1
	
	method marcarComoSeleccionado(nuevoAtacante){
		atacante = nuevoAtacante
//		tablero.pintarCasilleros(self.casillerosAtacables())
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
	
	method esAtacable(posicion) = self.casillerosAtacables().map({casillero => casillero.position()}).contains(posicion)
	
	// para testear
	method atacante() = atacante
	method atacante(nuevo) {atacante = nuevo}
}

object ningunAtaque{
	method marcarComoSeleccionado(_) {}
	method realizarAtaque(_) {}
	method mira() = "cursor.png" 
}

class ProyectilEnArco inherits Ataque {
	var rangoMaximo = 3
	var danio = 30
	
	override method realizarEfectoAtaque(posicion){
		game.say(atacante, "pium pium")
		game.uniqueCollider(cursor).recibirDanio(danio)
	}
	
	override method mira() {
		if (self.esAtacable(cursor.position())) return "mira.png"
		else return "cursor.png"
	}
	
	// TODO: repeticion de logica en estos dos (tamb estan en Personaje)
	override method casillerosAtacables() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla.position(), rangoMaximo + 1) })
	method distanciaX(otroCasillero) = (atacante.position().x() - otroCasillero.x()).abs()
	method distanciaY(otroCasillero) = (atacante.position().y() - otroCasillero.y()).abs()
	method distanciaXMenorA(casillero, distancia) = self.distanciaX(casillero) < distancia
	method distanciaYMenorA(casillero, distancia) = self.distanciaY(casillero) < distancia
	method distanciaMenorA(casillero, distancia) = self.distanciaXMenorA(casillero, distancia) && self.distanciaYMenorA(casillero, distancia)
}

class DisparoLineaRecta {
	var rango = 2
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
 * Los personajes van a tener ataques que sean nuevas instancias de los distintos ataques.
 * Esto permite que distintos personajes puedan tener ataques con el mismo comportamiento
 * pero distinto rango, daño base, etc. Por ejemplo podemos tener un personaje que pegue 
 * mucho con el cuchillo pero poco con un rifle, o un personaje francotirador que tenga mas
 * rango con el sniper, etc. 
 * El método atacar va a hacerle cosas al personaje (gastar municion o lo que sea, depende
 * del personaje) y además va a lanzar ese ataque desde la posición del personaje, mandando
 * al ataque elejido el mensaje lanzarAtaque(posición). El resto es responsabilidad del ataque.
 * 
 * 
 * 
 */