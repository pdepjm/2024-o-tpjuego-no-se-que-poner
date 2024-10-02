import elementos.*

object mapa
{
	method crearBloques(y, xi, xf, tipo) 
	{
		(xi..xf).forEach({ x =>
			const nuevoBloque = new Bloque()
			nuevoBloque.position(game.at(x, y))
			nuevoBloque.image(tipo)
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
      	self.crearBloques(1, 0, 2, "bloqueTierra2.png")
		self.crearBloques(1, 13, 15, "bloqueTierra2.png")
		self.crearBloques(2, 6, 11, "bloqueTierra2.png")
		self.crearBloques(3, 0, 4, "bloqueTierra2.png")
		self.crearBloques(6, 2, 15, "bloqueTierra2.png")
		self.crearBloques(9, 0, 12, "bloqueTierra2.png")
		self.crearBloques(12, 0, 1, "bloqueTierra2.png")
		self.crearBloques(13, 3, 15, "bloqueTierra2.png")
    }

    method crearBloquesEspeciales() 
    {
        self.crearBloques(0, 5, 6, "bloqueDeFuego.png")
		self.crearBloques(0, 9, 10, "bloqueDeAgua.png")
		self.crearBloques(3, 8, 9, "acido46.png")
    }

	method inciar() 
	{
        self.crearBloquesDeTierra()
		self.crearBloquesEspeciales()
        self.agregarElementos()
	}
}

class Bloque
{
	var property position = game.at(0,0)
	var property image = ""

    method tratarColision(personaje) 
    {
    }
}
