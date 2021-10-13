import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import nivel.*

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
	}
	method teclasAtaques(){
		9.times({i => keyboard.num(i).onPressDo({ cursor.seleccionarAtaque(i) })})
		keyboard.k().onPressDo({cursor.atacar()})
	}
}

