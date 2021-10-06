import wollok.game.*
import tablero.*
import texto.*
import direcciones.*

object configuracion{
	method configuracionInicial(){
		game.removeVisual(menuPrincipal)
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
	
	object menuPrincipal {
		var property position = game.at(-2,0)
		var property image = "menuPrincipal.png"
		var property menuHabilitado = true
		
		
  		method iniciar(){
  			if(menuHabilitado){
  				menuHabilitado = false
  				game.addVisual(self)
  				keyboard.enter().onPressDo({ configuracion.configuracionInicial() })
  			}
		}
}
	
		
	
	
		
		
		
		

	



