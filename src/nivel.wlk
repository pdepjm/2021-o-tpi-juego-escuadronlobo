import wollok.game.*
import tablero.*
import texto.*
import direcciones.*

object configuracion{
	method configuracionInicial(){
		game.addVisual(soldadoNazi)
		game.addVisual(texto)
		game.addVisual(cursor)
	}

	method configurarTeclas(){
		keyboard.enter().onPressDo({ cursor.seleccionar() })
		keyboard.left().onPressDo({ cursor.mover(izquierda) })
		keyboard.right().onPressDo({ cursor.mover(derecha) })
		keyboard.up().onPressDo({ cursor.mover(arriba) })
		keyboard.down().onPressDo({ cursor.mover(abajo) })
	}
}