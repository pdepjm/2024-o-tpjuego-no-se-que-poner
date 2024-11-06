import elementos.*
import personajes.fireboy
import personajes.watergirl

object mapa
{
	method crearBloques(y, xi, xf, fabrica) 
    //method que crea bloques de un tipo en una misma fila o valor de y de un punto x inicial a uno x final
	{
		(xi..xf).forEach({ x =>
			const nuevoBloque = fabrica.crearBloque(game.at(x, y))
		 	game.addVisual(nuevoBloque)
		})
	} 

    method agregarElementos() 
    {
        game.addVisual(botonAbajo)
        game.addVisual(botonArriba)
        game.addVisual(palanca)
        game.addVisual(elevadorPorBoton)
        game.addVisual(elevadorPorPalanca)
        game.addVisual(puertaAgua)
        game.addVisual(puertaFuego)
        game.addVisual(cubo)
    }

    method crearBloquesDeTierra() 
    {
      	self.crearBloques(1, 0, 2, fabricaBloqueTierra)
		self.crearBloques(1, 13, 14, fabricaBloqueTierra)
		self.crearBloques(2, 6, 11, fabricaBloqueTierra)
		self.crearBloques(3, 0, 4, fabricaBloqueTierra)
		self.crearBloques(6, 2, 14, fabricaBloqueTierra)
		self.crearBloques(9, 0, 12,  fabricaBloqueTierra)
		self.crearBloques(12, 0, 1, fabricaBloqueTierra)
		self.crearBloques(13, 3, 14, fabricaBloqueTierra)
    }

    method crearBloquesEspeciales() 
    {
        self.crearBloques(0, 5, 6, fabricaBloqueFuego)
		self.crearBloques(0, 9, 10, fabricaBloqueAgua)
		self.crearBloques(3, 8, 9, fabricaBloqueAcido)
        self.crearBloques(5, 7, 10, fabricaBloquePinchos)

    }

	method inciar() 
	{
        game.title("Fireboy and Watergirl")
	    game.height(16)
	    game.width(15)
	    game.cellSize(50)
	    game.boardGround("bg.png")
        self.crearBloquesDeTierra()
		self.crearBloquesEspeciales()
        self.agregarElementos()
	}

}
object fabricaBloqueTierra {
    method crearBloque(posicion) = new BloqueTierra(position = posicion)
}

object fabricaBloqueAgua {
    method crearBloque(posicion) = new BloqueAgua(position = posicion)
}

object fabricaBloqueFuego {
    method crearBloque(posicion) = new BloqueFuego(position = posicion)
}

object fabricaBloqueAcido {
    method crearBloque(posicion) = new BloqueAcido(position = posicion)
}

object fabricaBloquePinchos
{
    method crearBloque(posicion) = new BloquePinchos( position = posicion)
}

class Bloque
{
    const property position
    method puedeSerPresionado() = false
    method puedeSerAtravesado() = true
    method puedeSerMovido() = false

}

class BloqueTierra inherits Bloque
{
	method image() = "bloqueTierra2.png"
    override method puedeSerAtravesado() = false
} 

class BloqueFuego inherits Bloque
{
	method image() = "bloqueDeFuego.png"

    method tratarColision(personaje) 
    {
        personaje.tocarFuego()
    }
}

class BloqueAgua inherits Bloque
{
	method image() = "bloqueDeAgua.png"

    method tratarColision(personaje) 
    {
        personaje.tocarAgua()
    }
}

class BloqueAcido inherits Bloque
{
	method image() = "acido46.png"

    method tratarColision(personaje) 
    {
        personaje.morir()
    }
}

class BloquePinchos inherits Bloque
{
    method image() = "bloquePinchos.png"

    method tratarColision(personaje)
    {
        personaje.morir()
    }
}

object juego
{
    var cartelActual = cartelGanador
    var unCartelActivo = false
    const elementos = [elevadorPorBoton, elevadorPorPalanca, fireboy, watergirl, cubo]
    method ganaste()
    {
        game.addVisual(cartelGanador)
        cartelActual = cartelGanador
        unCartelActivo = true
    }

    method perdiste()
    {
        game.addVisual(cartelPerdedor)
        cartelActual = cartelPerdedor
        unCartelActivo = true
    }

    method reiniciar()
    {
        if(unCartelActivo)
        {
            elementos.forEach({e => e.reiniciar()})
            unCartelActivo = false
            game.removeVisual(cartelActual)
        }
    }

    method condicionesGanadoras() = puertaFuego.estaAbierta() && puertaAgua.estaAbierta() && !unCartelActivo
    method condicionesPerdedoras() = fireboy.estaMuerto() && watergirl.estaMuerto() && !unCartelActivo
}

object cartelGanador
{
    method image() = "ganaste2.jpg"
    var property position = game.at(3,4)
}

object cartelPerdedor
{
    method image() = "perdiste3.jpg"
    var property position = game.at(3,4)
}
