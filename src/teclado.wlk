import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import nivel.*
import turnos.*

object teclado{
	
	method teclaInicio() {keyboard.enter().onPressDo {
		if(menuPrincipal.menuHabilitado()) { 
				menuPrincipal.menuHabilitado(false)
				game.removeVisual(menuPrincipal)
				configuracion.configuracionInicial()
		}}
	}
	
	method teclasCursor(){
		keyboard.enter().onPressDo({ cursor.seleccionar() })
		keyboard.left().onPressDo({ cursor.mover(izquierda) })
		keyboard.right().onPressDo({ cursor.mover(derecha) })
		keyboard.up().onPressDo({ cursor.mover(arriba) })
		keyboard.down().onPressDo({ cursor.mover(abajo) })
		keyboard.num(1).onPressDo({ cursor.seleccionarAtaque(1) })
		keyboard.k().onPressDo({cursor.atacar()})
		
	}
	method teclasTurno(){
			keyboard.t().onPressDo({turno.pasarTurno()})
		}
}


