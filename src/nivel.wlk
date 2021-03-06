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
	// Cambiar voluntad los rangos y potencias de las instancias de los ataques para balancear el juego
	//Unidades Jp1
	const soldadoJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "ally.png", position = game.at(0,7), vida = 100, ataques = [new Rifle(potencia = 50, rangoMaximo = 4)])
	const soldado2Jp1 = new Personaje(rangoMaximoMovimiento = 2, image = "ally.png", position = game.at(0,6), vida = 100, ataques = [new Rifle(potencia = 50, rangoMaximo = 4)])
	const avionJp1 = new Avion(rangoMaximoMovimiento = 6, image = "avionDerechajugador1.png", position = game.at(0,5), vida = 150, ataques = [new Bombardeo(potencia = 50)])
	const healerJp1 = new Personaje(rangoMaximoMovimiento = 2, image = "healer.png", vida = 100, ataques = [new GomeraCuradora(potencia = 75, rangoMaximo = 2)], position= game.at(0,4))
    const tanqueJp1 = new Tanque(rangoMaximoMovimiento = 1, image = "tanqueDerechajugador1.png", position = game.at(0,3), vida = 250, ataques = [new Rifle(potencia = 100, rangoMaximo = 2), new Rifle(potencia = 50, rangoMaximo = 4)])
    
    const edificio1 = new Edificio(position = game.at(3,7), image = "edificio1.png", vida = 300)
	const edificio2 = new Edificio(position = game.at(5,4), image = "edificio1.png", vida = 400)
	const edificio3 = new Edificio(position = game.at(3,1), image = "edificio1.png", vida = 300)
	
	// Unidades Jp2
    const soldadoJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "axis.png", position = game.at(13,7), vida = 100, ataques = [new Rifle(potencia = 50, rangoMaximo = 4)])
    const soldado2Jp2 = new Personaje(rangoMaximoMovimiento = 2, image = "axis.png", position = game.at(13,6), vida = 100, ataques = [new Rifle(potencia = 50, rangoMaximo = 4)])
	const avionJp2 = new Avion(rangoMaximoMovimiento = 6, image = "avionIzquierdajugador2.png", position = game.at(13,5), vida = 150, ataques = [new Bombardeo(potencia = 50)])
	const healerJp2 = new Personaje(rangoMaximoMovimiento = 2, image = "healer2.png", vida = 100, ataques = [new GomeraCuradora(potencia = 75, rangoMaximo = 2)], position= game.at(13,4))
    const tanqueJp2 = new Tanque(rangoMaximoMovimiento = 1, image = "tanqueIzquierdajugador2.png", position = game.at(13,3), vida = 250, ataques = [new Rifle(potencia = 100, rangoMaximo = 2),  new Rifle(potencia = 50, rangoMaximo = 4)])
	const demoledor = new Demoledor(rangoMaximoMovimiento = 1, image = "demoledorIzquierdajugador2.png", position = game.at(13,2), vida = 300, ataques = [new Demolicion(potencia = 150)])

	// Lista de las Unidades
	const unidades = [soldadoJp1, soldado2Jp1, avionJp1, healerJp1, tanqueJp1, edificio1, edificio2, edificio3, soldadoJp2, soldado2Jp2, healerJp2, avionJp2, tanqueJp2, demoledor] 

	//const property jugador1 = new Jugador(personajes = [soldadoNaziJp1]) 
    //const property jugador2 = new Jugador(personajes = [soldadoNaziJp2])
		
	method configuracionInicial(){
		teclado.teclasCursor()
		teclado.teclasTurno()
		tablero.configurarCasillas()
		
		jugador1.agregarPersonajes([soldadoJp1, soldado2Jp1, healerJp1, avionJp1, tanqueJp1])
		jugador2.agregarPersonajes([soldadoJp2, soldado2Jp2, healerJp2, avionJp2, tanqueJp2, demoledor])
		jugador1.agregarEdificios([edificio1,edificio2,edificio3])
		jugador1.oponente(jugador2)
		jugador2.oponente(jugador1)
		
		unidades.forEach({unidad => game.addVisual(unidad)})
		
		game.addVisual(marcadorMovimientos)
		game.addVisual(marcadorAtaques)
		
		game.addVisual(cursor)
	}
	
}

class Pantalla {
	var property position = game.at(-1,0)
	var property image
	var property habilitado = true
	
	method continua() = true
	
	method mostrar(){
			game.addVisual(self)
	}
		
	method iniciar(){
  			teclado.teclaInicio(self)
  	}
}
	
object menuPrincipal inherits Pantalla (image = "menuPrincipal.png") {
		
		method siguiente() = controles	
		method animacion(){
			game.schedule(200,{=> self.image("menuPrincipal.png")})
			game.schedule(800,{=> self.image("menuPrincipalA.png")})
			game.onTick(1200,"parpadear",{
				game.schedule(200,{=> self.image("menuPrincipal.png")})
				game.schedule(800,{=> self.image("menuPrincipalA.png")})
			})
		}	
		method trancisionFinal(){
			game.removeTickEvent("parpadear") 
			game.schedule(200,{=> self.image("menuPrincipal2.png")})
			game.schedule(250,{=> self.image("menuPrincipal3.png")})
			game.schedule(300,{=> self.image("menuPrincipal4.png")})
			game.schedule(350,{=> self.image("menuPrincipal5.png")})
			game.schedule(400,{=> self.image("menuPrincipal6.png")})
			game.schedule(450,{=> self.image("menuPrincipal7.png")})
			game.schedule(500,{=> self.image("menuPrincipal8.png")})
			game.schedule(550,{=> self.image("menuPrincipal9.png")})
			game.schedule(600,{=> self.image("menuPrincipal10.png")})
			game.schedule(650,{=> self.image("menuPrincipal11.png")})
			game.schedule(700,{=> self.image("menuPrincipal12.png")})
			game.schedule(750,{=> self.image("menuPrincipal13.png")})
			game.schedule(800,{=> self.image("menuPrincipal14.png")})
			game.schedule(850,{=> self.image("menuPrincipal15.png")})
			game.schedule(900,{=> self.image("menuPrincipal16.png")})
			game.schedule(950,{=> self.image("menuPrincipal17.png")})
			
		}
		
  		
}


object controles inherits Pantalla (image = "controles16.png"){
		
		method siguiente() = instrucciones
		
		method transicionInicial(){
			self.mostrar()
			game.schedule(200,{=> self.image("controles15.png")})
			game.schedule(250,{=> self.image("controles14.png")})
			game.schedule(350,{=> self.image("controles13.png")})
			game.schedule(450,{=> self.image("controles12.png")})
			game.schedule(500,{=> self.image("controles11.png")})
			game.schedule(550,{=> self.image("controles10.png")})
			game.schedule(600,{=> self.image("controles9.png")})
			game.schedule(650,{=> self.image("controles8.png")})
			game.schedule(700,{=> self.image("controles7.png")})
			game.schedule(750,{=> self.image("controles6.png")})
			game.schedule(800,{=> self.image("controles5.png")})
			game.schedule(850,{=> self.image("controles4.png")})
			game.schedule(900,{=> self.image("controles3.png")})
			game.schedule(950,{=> self.image("controles2.png")})
			game.schedule(1000,{=> self.image("controles.png")})
		}
		
		
		method trancisionFinal(){
			game.schedule(200,{=> self.image("controles2.png")})
			game.schedule(250,{=> self.image("controles3.png")})
			game.schedule(300,{=> self.image("controles4.png")})
			game.schedule(350,{=> self.image("controles5.png")})
			game.schedule(400,{=> self.image("controles6.png")})
			game.schedule(450,{=> self.image("controles7.png")})
			game.schedule(500,{=> self.image("controles8.png")})
			game.schedule(550,{=> self.image("controles9.png")})
			game.schedule(600,{=> self.image("controles10.png")})
			game.schedule(650,{=> self.image("controles11.png")})
			game.schedule(700,{=> self.image("controles12.png")})
			game.schedule(750,{=> self.image("controles13.png")})
			game.schedule(800,{=> self.image("controles14.png")})
			game.schedule(850,{=> self.image("controles15.png")})
			game.schedule(900,{=> self.image("controles16.png")})
		}
}

object instrucciones inherits Pantalla (image = "instrucciones14.png"){
	
	method siguiente() = explicacionTropas
	
	method transicionInicial(){
			self.mostrar()
			game.schedule(200,{=> self.image("instrucciones13.png")})
			game.schedule(250,{=> self.image("instrucciones12.png")})
			game.schedule(300,{=> self.image("instrucciones11.png")})
			game.schedule(350,{=> self.image("instrucciones10.png")})
			game.schedule(400,{=> self.image("instrucciones9.png")})
			game.schedule(450,{=> self.image("instrucciones8.png")})
			game.schedule(500,{=> self.image("instrucciones7.png")})
			game.schedule(550,{=> self.image("instrucciones6.png")})
			game.schedule(600,{=> self.image("instrucciones5.png")})
			game.schedule(650,{=> self.image("instrucciones4.png")})
			game.schedule(700,{=> self.image("instrucciones3.png")})
			game.schedule(750,{=> self.image("instrucciones2.png")})
		}
		
		
		method trancisionFinal(){
			game.schedule(200,{=> self.image("instrucciones2.png")})
			game.schedule(250,{=> self.image("instrucciones3.png")})
			game.schedule(300,{=> self.image("instrucciones4.png")})
			game.schedule(350,{=> self.image("instrucciones5.png")})
			game.schedule(400,{=> self.image("instrucciones6.png")})
			game.schedule(450,{=> self.image("instrucciones7.png")})
			game.schedule(500,{=> self.image("instrucciones8.png")})
			game.schedule(550,{=> self.image("instrucciones9.png")})
			game.schedule(600,{=> self.image("instrucciones10.png")})
			game.schedule(650,{=> self.image("instrucciones11.png")})
			game.schedule(700,{=> self.image("instrucciones12.png")})
			game.schedule(750,{=> self.image("instrucciones13.png")})
			game.schedule(800,{=> self.image("instrucciones14.png")})	
		}
	
}


object explicacionTropas inherits Pantalla (image = "explicacionTropas13.png") {
	override method continua() = false 
	
	method transicionInicial(){
			self.mostrar()
			game.schedule(200,{=> self.image("explicacionTropas12.png")})
			game.schedule(250,{=> self.image("explicacionTropas11.png")})
			game.schedule(300,{=> self.image("explicacionTropas10.png")})
			game.schedule(350,{=> self.image("explicacionTropas9.png")})
			game.schedule(400,{=> self.image("explicacionTropas8.png")})
			game.schedule(450,{=> self.image("explicacionTropas7.png")})
			game.schedule(500,{=> self.image("explicacionTropas6.png")})
			game.schedule(550,{=> self.image("explicacionTropas5.png")})
			game.schedule(600,{=> self.image("explicacionTropas4.png")})
			game.schedule(650,{=> self.image("explicacionTropas3.png")})
			game.schedule(700,{=> self.image("explicacionTropas2.png")})
			game.schedule(750,{=> self.image("explicacionTropas.png")})	
	}
	
	method trancisionFinal(){
			game.schedule(200,{=> self.image("explicacionTropas.png")})
			game.schedule(250,{=> self.image("explicacionTropas2.png")})
			game.schedule(300,{=> self.image("explicacionTropas3.png")})
			game.schedule(350,{=> self.image("explicacionTropas4.png")})
			game.schedule(400,{=> self.image("explicacionTropas5.png")})
			game.schedule(450,{=> self.image("explicacionTropas6.png")})
			game.schedule(500,{=> self.image("explicacionTropas7.png")})
			game.schedule(550,{=> self.image("explicacionTropas8.png")})
			game.schedule(600,{=> self.image("explicacionTropas9.png")})
			game.schedule(650,{=> self.image("explicacionTropas10.png")})
			game.schedule(700,{=> self.image("explicacionTropas11.png")})
			game.schedule(750,{=> self.image("explicacionTropas12.png")})
			game.schedule(800,{=> self.image("explicacionTropas13.png")})	
			game.schedule(900,{=> configuracion.configuracionInicial()})
	}
}
		
		
		
		

	



