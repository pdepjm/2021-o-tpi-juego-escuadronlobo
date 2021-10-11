import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import teclado.*

object configuracion{
	method configuracionInicial(){
		game.addVisual(new Personaje(image = "soldadoNazi.png"))
		game.addVisual(cursor)		
	}
}
	
object menuPrincipal {
		var property position = game.at(0,0)
		var property image = "menuPrincipal.png"
		var property menuHabilitado = true	
		
		method mostrar(){
			game.addVisual(self)
		}
		
  		method iniciar(){
  			teclado.teclaInicio()
  		}
}


		
	
	
		
		
		
		

	



