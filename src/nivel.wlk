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
	const soldadoJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "ally.png", position = game.at(0,7), vida = 100, ataques = [new DisparoLineaRecta()])	
	const healerJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "healer.png", vida = 60, ataques = [new GomeraCuradora()], position= game.at(0,6))
    const soldadoJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "axis.png", position = game.at(13,7), vida = 100, ataques = [new GomeraDePiedras()])
	const healerJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "healer2.png", vida = 60, ataques = [new GomeraCuradora()], position= game.at(13,6))
	const edificio1 = new Edificio(position = game.at(3,7), image = "edificio1.png", vida = 600)
	const edificio2 = new Edificio(position = game.at(5,4), image = "edificio1.png", vida = 600)
	const edificio3 = new Edificio(position = game.at(3,1), image = "edificio1.png", vida = 600)
	//const property jugador1 = new Jugador(personajes = [soldadoNaziJp1]) 
    //const property jugador2 = new Jugador(personajes = [soldadoNaziJp2])
		
	method configuracionInicial(){
		tablero.configurarCasillas()
		
		jugador1.agregarPersonajes([soldadoJp1, healerJp1])
		jugador2.agregarPersonajes([soldadoJp2, healerJp2])
		jugador1.agregarEdificios([edificio1,edificio2,edificio3])
		jugador1.oponente(jugador2)
		jugador2.oponente(jugador1)
		
		game.addVisual(soldadoJp1)
		game.addVisual(soldadoJp2)
		game.addVisual(healerJp1)
		game.addVisual(healerJp2)
		game.addVisual(edificio1)
		game.addVisual(edificio2)
		game.addVisual(edificio3)
		game.addVisual(cursor)
	}
	
}
	
object menuPrincipal {
		var property position = game.at(-1,0)
		var property image = "menuPrincipal.png"
		var property menuHabilitado = true	
		
		method mostrar(){
			game.addVisual(self)
		}
		
  		method iniciar(){
  			teclado.teclaInicio()
  		}
}



		
		
		
		

	



