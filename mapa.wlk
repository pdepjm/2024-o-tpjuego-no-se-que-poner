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

        //de aca pa abajo son los limites despues lo vamos a hacer mas lindo pero por ahora funciona
        self.crearBloques(-1, 0, 14, fabricaBloqueTierra)
        self.crearBloques(0, -1, -1, fabricaBloqueTierra)
        self.crearBloques(1, -1, -1, fabricaBloqueTierra)
        self.crearBloques(2, -1, -1, fabricaBloqueTierra)
        self.crearBloques(3, -1, -1, fabricaBloqueTierra)
        self.crearBloques(4, -1, -1, fabricaBloqueTierra)
        self.crearBloques(5, -1, -1, fabricaBloqueTierra)
        self.crearBloques(6, -1, -1, fabricaBloqueTierra)
        self.crearBloques(7, -1, -1, fabricaBloqueTierra)
        self.crearBloques(8, -1, -1, fabricaBloqueTierra)
        self.crearBloques(9, -1, -1, fabricaBloqueTierra)
        self.crearBloques(10, -1, -1, fabricaBloqueTierra)
        self.crearBloques(11, -1, -1, fabricaBloqueTierra)
        self.crearBloques(12, -1, -1, fabricaBloqueTierra)
        self.crearBloques(13, -1, -1, fabricaBloqueTierra)
        self.crearBloques(14, -1,-1, fabricaBloqueTierra) 
        self.crearBloques(0,15,15,fabricaBloqueTierra)
        self.crearBloques(1,15,15,fabricaBloqueTierra)
        self.crearBloques(2,15,15,fabricaBloqueTierra)
        self.crearBloques(3,15,15,fabricaBloqueTierra)
        self.crearBloques(4,15,15,fabricaBloqueTierra)
        self.crearBloques(5,15,15,fabricaBloqueTierra)
        self.crearBloques(6,15,15,fabricaBloqueTierra)
        self.crearBloques(7,15,15,fabricaBloqueTierra)
        self.crearBloques(8,15,15,fabricaBloqueTierra)
        self.crearBloques(9,15,15,fabricaBloqueTierra)
        self.crearBloques(10,15,15,fabricaBloqueTierra)
        self.crearBloques(11,15,15,fabricaBloqueTierra)
        self.crearBloques(12,15,15,fabricaBloqueTierra)
        self.crearBloques(13,15,15,fabricaBloqueTierra)
        self.crearBloques(14,15,15,fabricaBloqueTierra)


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
    method tratarColision(personaje) 
    {
        personaje.kill()
    }
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
        personaje.retroceder()
    }
} 

class BloqueFuego
{
    var property position = game.at(0,0)
	method image() = "bloqueDeFuego.png"
    method tratarColision(personaje) 
    {
        personaje.tratarColisionBloqueFuego()
    }
}

class BloqueAgua
{
    var property position = game.at(0,0)
	method image() = "bloqueDeAgua.png"
    method tratarColision(personaje) 
    {
        personaje.tratarColisionBloqueAgua()
    }
   
}

class BloqueAcido
{
    var property position = game.at(0,0)
	method image() = "acido46.png"
    method tratarColision(personaje) 
    {
        personaje.kill()
    }
}

