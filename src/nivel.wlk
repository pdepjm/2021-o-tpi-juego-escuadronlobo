import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import teclado.*
import personajes.*

object configuracion{
	method configuracionInicial(){
		game.addVisual(new Personaje(rangoMaximoMovimiento = 2, image = "soldadoNazi.png", vida = 100))
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


		
	
	
		
		
		
		

	



