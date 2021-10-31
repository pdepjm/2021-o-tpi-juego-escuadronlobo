import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import nivel.*
import turnos.*
import jugadores.*

object teclado{
	
	method teclaInicio(pantalla) {keyboard.enter().onPressDo {
		if(pantalla.habilitado()) { 
				pantalla.habilitado(false)
				pantalla.trancisionFinal()
				game.schedule(1200,{
					game.removeVisual(pantalla)
					if(pantalla.continua()){
					pantalla.siguiente().transicionInicial()
					pantalla.siguiente().iniciar()
					}
				})
				
		}}
	}
	
	method teclasCursor(){
		keyboard.enter().onPressDo({turnoManager.jugadorActual().seleccionar()})
		keyboard.left().onPressDo({ cursor.mover(izquierda) })
		keyboard.right().onPressDo({ cursor.mover(derecha) })
		keyboard.up().onPressDo({ cursor.mover(arriba) })
		keyboard.down().onPressDo({ cursor.mover(abajo) })
		keyboard.num(1).onPressDo({ turnoManager.jugadorActual().realizarAtaque(1) })
		keyboard.k().onPressDo({cursor.atacar()})
	
	}
	
	method teclasTurno(){
			keyboard.t().onPressDo({turnoManager.pasarTurno()})
	}
}


