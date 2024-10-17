import elementos.*

object mapa
{
	method crearBloques(y, xi, xf, fabrica) 
    //method que crea bloques de un tipo en una misma fila o valor de y de un punto x inicial a uno x final
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

class BloqueTierra
{
    var property position = game.at(0,0)
	method image() = "bloqueTierra2.png"

    method tipo() = "BloqueTierra" 
    method tratarColision(personaje) 
    {
    }
} 

class BloqueFuego
{
    var property position = game.at(0,0)
	method image() = "bloqueDeFuego.png"
    method tipo() = "BloqueFuego" 

    method tratarColision(personaje) 
    {
        personaje.tocarFuego()
    }
}

class BloqueAgua
{
    var property position = game.at(0,0)
	method image() = "bloqueDeAgua.png"
    method tipo() = "BloqueAgua" 

    method tratarColision(personaje) 
    {
        personaje.tocarAgua()
    }
   
}

class BloqueAcido
{
    var property position = game.at(0,0)
	method image() = "acido46.png"
    method tipo() = "BloqueAcido" 

    method tratarColision(personaje) 
    {
        personaje.morir()
    }
}

