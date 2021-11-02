import tablero.*

class Rango{
	method posiciones()
	
	method estaEnElRango(posicion) = self.posiciones().contains(posicion)
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
	override method posiciones() = if (tablero.estaEnElTablero(posicionBase)) tablero.casillasEnLaMismaFilaOColumna(tablero.casillero(posicionBase)).map({c => c.position()}).filter({ p => self.distanciaMenorA(p, rangoMaximo + 1) }) else []
}

object rangoIlimitado inherits Rango{
	override method posiciones() = tablero.posicionesCasillas()
}

class RangoLineaRectaEdificios inherits RangoLineaRecta{
	override method posiciones() = if (tablero.estaEnElTablero(posicionBase)) tablero.casillasEnLaMismaFilaOColumna(tablero.casillero(posicionBase)).filter({c => c.tieneUnEdificio()}).map({c => c.position()}).filter({ p => self.distanciaMenorA(p, rangoMaximo + 1) }) else []
}

class RangoRedondo inherits Rango{ // NO SE SI ANDA, PROBAR MAS ADELANTE
	const rangoMaximo
	const posicionBase
	
	override method posiciones() = tablero.casillas().filter({ casilla => self.distanciaMenorA(casilla.position(), rangoMaximo + 1) }).map({casillero => casillero.position()})
	method distanciaMenorA(casillero, distancia) = distancia < posicionBase.distance(casillero)
}

class RangoLineaRectaDesocupados inherits Rango{
	const posicionBase
	override method posiciones() = if (tablero.estaEnElTablero(posicionBase)) tablero.casillasEnLaMismaFilaOColumna(tablero.casillero(posicionBase)).filter({casillero => not casillero.estaOcupado()}).map({casillero => casillero.position()}) else []
}

class RangoColumnas inherits Rango{
	const columnas
	override method posiciones() = columnas.map({n => tablero.columna(n)}).flatten().map({casillero => casillero.position()})
}
