import wollok.game.*
import tablero.*
import texto.*
import direcciones.*
import visuales.*
import teclado.*
import personajes.*
import ataques.*
import jugadores.*

object configuracion{
	const soldadoNaziJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "soldadoNazi.png", vida = 100, ataques = [new ProyectilEnArco()])
	const healerJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "healer.png", vida = 60, ataques = [new GomeraCuradora()], position= game.at(0,7))
    const soldadoNaziJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "soldadoNazi.png", position = game.at(16,8), vida = 100, ataques = [new ProyectilEnArco()])
	const healerJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "healer.png", vida = 60, ataques = [new GomeraCuradora()], position= game.at(16,7))
	//const property jugador1 = new Jugador(personajes = [soldadoNaziJp1]) 
    //const property jugador2 = new Jugador(personajes = [soldadoNaziJp2])
		
	method configuracionInicial(){
		tablero.configurarCasillas()
		
		jugador1.agregarPersonajes([soldadoNaziJp1, healerJp1])
		jugador2.agregarPersonajes([soldadoNaziJp2, healerJp2])
		jugador1.oponente(jugador2)
		jugador2.oponente(jugador1)
		
		game.addVisual(soldadoNaziJp1)
		game.addVisual(soldadoNaziJp2)
		game.addVisual(healerJp1)
		game.addVisual(healerJp2)
		game.addVisual(cursor)
	}
	
}
	
object menuPrincipal {
		var property position = game.at(-1,-1)
		var property image = "menuPrincipal.png"
		var property menuHabilitado = true	
		
		method mostrar(){
			game.addVisual(self)
		}
		
  		method iniciar(){
  			teclado.teclaInicio()
  		}
}



		
		
		
		

	



