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

	method inciar() 
	{
		self.crearBloques(1, 0, 2, "bloque.png")
		self.crearBloques(1, 13, 15, "bloque.png")
		self.crearBloques(2, 6, 10, "bloque.png")
		self.crearBloques(3, 0, 4, "bloque.png")
		self.crearBloques(6, 2, 15, "bloque.png")
		self.crearBloques(9, 0, 12, "bloque.png")
		self.crearBloques(12, 0, 2, "bloque.png")
		self.crearBloques(13, 4, 15, "bloque.png")

		self.crearBloques(0, 5, 6, "bloqueFuego.png")
		self.crearBloques(0, 9, 10, "bloqueAgua.png")
		self.crearBloques(2, 8, 8, "bloqueConAcido6.png")
		self.crearBloques(6, 4, 4, "bloqueBoton.png")

	}
}

class Bloque
{
	var property position = game.at(0,0)
	var property image = ""
}
