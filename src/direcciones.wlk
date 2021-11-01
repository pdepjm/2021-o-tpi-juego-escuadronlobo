import tablero.*

object izquierda {
	method proximaPosicion(posicionActual) = if (configuracionBoard.estaEnElBoard(posicionActual.left(1))) posicionActual.left(1) else posicionActual 

	method orientar(personaje) = personaje.mirarIzquierda()
}

object derecha {
	method proximaPosicion(posicionActual) = if (configuracionBoard.estaEnElBoard(posicionActual.right(1))) posicionActual.right(1) else posicionActual 

	method orientar(personaje) = personaje.mirarDerecha()

}

object arriba {
	method proximaPosicion(posicionActual) = if (configuracionBoard.estaEnElBoard(posicionActual.up(1))) posicionActual.up(1) else posicionActual 

	method orientar(personaje) = personaje.mirarArriba()
}

object abajo {
	method proximaPosicion(posicionActual) = if (configuracionBoard.estaEnElBoard(posicionActual.down(1))) posicionActual.down(1) else posicionActual 

	method orientar(personaje) = personaje.mirarAbajo()
}