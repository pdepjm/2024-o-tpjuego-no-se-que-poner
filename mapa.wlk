import elementos.*

object mapa
{
	method crearBloques(y, xi, xf, fabrica) 
	{
		(xi..xf).forEach({ x =>
			const nuevoBloque = fabrica.crearBloque()
			nuevoBloque.position(game.at(x, y))
		 	game.addVisual(nuevoBloque)
		})
	}

    method agregarElementos() 
    {
        game.addVisual(boton)
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
		self.crearBloques(1, 13, 15, fabricaBloqueTierra)
		self.crearBloques(2, 6, 11, fabricaBloqueTierra)
		self.crearBloques(3, 0, 4, fabricaBloqueTierra)
		self.crearBloques(6, 2, 15, fabricaBloqueTierra)
		self.crearBloques(9, 0, 12,  fabricaBloqueTierra)
		self.crearBloques(12, 0, 1, fabricaBloqueTierra)
		self.crearBloques(13, 3, 15, fabricaBloqueTierra)
    }

    method crearBloquesEspeciales() 
    {
        self.crearBloques(0, 5, 6, fabricaBloqueFuego)
		self.crearBloques(0, 9, 10, fabricaBloqueAgua)
		self.crearBloques(3, 8, 9, fabricaBloqueAcido)
    }

	method inciar() 
	{
        self.crearBloquesDeTierra()
		self.crearBloquesEspeciales()
        self.agregarElementos()
	}
}
object fabricaBloqueTierra {
    method crearBloque() = new BloqueTierra()
}

object fabricaBloqueAgua {
    method crearBloque() = new BloqueAgua()
}

object fabricaBloqueFuego {
    method crearBloque() = new BloqueFuego()
}

object fabricaBloqueAcido {
    method crearBloque() = new BloqueAcido()
}

class Bloque
{
	var property position = game.at(0,0)
}

class BloqueTierra
{
    var property position = game.at(0,0)
	method image() = "bloqueTierra2.png"

    method tratarColision(personaje) 
    {
        if(personaje.posicionAnt().y() < position.y()) personaje.retroceder()
        else if(personaje.posicionAnt().y() > position.y()) personaje.quedarse(position.y())
    }
} 

class BloqueFuego
{
    var property position = game.at(0,0)
	method image() = "bloqueDeFuego.png"

    method tratarColision(personaje) 
    {
    }
}

class BloqueAgua
{
    var property position = game.at(0,0)
	method image() = "bloqueDeAgua.png"

    method tratarColision(personaje) 
    {
    }
}

class BloqueAcido
{
    var property position = game.at(0,0)
	method image() = "acido46.png"

    method tratarColision(personaje) 
    {
    }
}