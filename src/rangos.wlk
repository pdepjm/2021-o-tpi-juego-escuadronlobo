import tablero.*

class Rango{
	method posiciones()
	
	method estaEnElRango(posicion) = self.posiciones().contains(posicion) // ANDA
}

class RangoCuadrado inherits Rango{ // ANDA
	const posicionBase
	const rangoMaximo
	
	override method posiciones() = tablero.posicionesCasillas().filter({ posicion => self.distanciaMenorA(posicion, rangoMaximo + 1) })
	method distanciaX(posicion) = (posicionBase.x() - posicion.x()).abs()
	method distanciaY(posicion) = (posicionBase.y() - posicion.y()).abs()
	method distanciaXMenorA(posicion, distancia) = self.distanciaX(posicion) < distancia
	method distanciaYMenorA(posicion, distancia) = self.distanciaY(posicion) < distancia
	method distanciaMenorA(posicion, distancia) = self.distanciaXMenorA(posicion, distancia) && self.distanciaYMenorA(posicion, distancia)
}

class RangoLineaRecta inherits RangoCuadrado{ // ANDA
	override method posiciones() = tablero.casillasEnLaMismaFilaOColumna(tablero.casillero(posicionBase)).map({casillero => casillero.position()}).filter({ posicion => self.distanciaMenorA(posicion, rangoMaximo + 1) })
}

object rangoIlimitado inherits Rango{
	override method posiciones() = tablero.posicionesCasillas()
}

class RangoRedondo inherits Rango{ // NO SE SI ANDA, PROBAR MAS ADELANTE
	const rangoMaximo
	const posicionBase
	
	override method posiciones() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla.position(), rangoMaximo + 1) }).map({casillero => casillero.position()})
	method distanciaMenorA(casillero, distancia) = distancia < posicionBase.distance(casillero)
}