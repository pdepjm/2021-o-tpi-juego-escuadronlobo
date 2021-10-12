import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import teclado.*
import personajes.*
import ataques.*

object configuracion{
	method configuracionInicial(){
		const soldadoNaziJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "soldadoNazi.png", vida = 100, ataques = [new ProyectilEnArco()])
    	const soldadoNaziJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "soldadoNazi.png", position = game.at(16,8), vida = 100, ataques = [new ProyectilEnArco()])
    	game.addVisual(soldadoNaziJp1)
    	game.addVisual(soldadoNaziJp2)
    	game.addVisual(cursor)
		tablero.configurarCasillas()
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


		
	
	
		
		
		
		

	



