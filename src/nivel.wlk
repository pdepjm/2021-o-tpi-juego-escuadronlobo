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
		
		method trancision(){
			game.schedule(200,{=> self.image("menuPrincipal2.png")})
			game.schedule(300,{=> self.image("menuPrincipal3.png")})
			game.schedule(400,{=> self.image("menuPrincipal4.png")})
			game.schedule(500,{=> self.image("menuPrincipal5.png")})
			game.schedule(600,{=> self.image("menuPrincipal6.png")})
			game.schedule(700,{=> self.image("menuPrincipal7.png")})
			game.schedule(800,{=> self.image("menuPrincipal8.png")})
			game.schedule(900,{=> self.image("menuPrincipal9.png")})
			game.schedule(1000,{=> self.image("menuPrincipal10.png")})
			game.schedule(1100,{=> self.image("menuPrincipal11.png")})
			game.schedule(1200,{=> self.image("menuPrincipal12.png")})
			game.schedule(1300,{=> self.image("menuPrincipal13.png")})
			game.schedule(1400,{=> self.image("menuPrincipal14.png")})
			game.schedule(1500,{=> self.image("menuPrincipal15.png")})
			game.schedule(1600,{=> self.image("menuPrincipal16.png")})
			game.schedule(1700,{=> self.image("menuPrincipal17.png")})
			
		}
		
  		method iniciar(){
  			teclado.teclaInicio()
  		}
}



		
		
		
		

	



