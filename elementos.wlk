import personajes.*

class Elemento 
{
    var property position
    method tipo() = "Elemento"
}

class Elevador inherits Elemento
{
    var activado = false
    method image() = "elevador2.png"
    override method tipo() = "Elevador"
    method tratarColision(personaje) {}

    method activarse()
    {
        if(activado) self.subir() else self.bajar()
    }

    method bajar()
    {
        position = position.down(1)
        activado = true
    }

    method subir()
    {
        position = position.up(1)
        activado = false
    }
}

const elevadorPorBoton = new Elevador (position = game.at(14, 9))

const elevadorPorPalanca = new Elevador (position = game.at(0, 6))

object boton inherits Elemento (position = game.at(5, 7))
{
    method image() = "boton.png"
    method tratarColision(personaje) {}
}

object palanca inherits Elemento (position = game.at(3, 4))
{
    method image() = "palanca.png"
    
    method tratarColision(personaje){}

    method activar() {
       elevadorPorPalanca.activarse()
    }
}

object cubo inherits Elemento (position = game.at(6, 10))
{
    method image() = "cubo.png"
    method tratarColision(personaje) {}
}

object puertaFuego inherits Elemento (position = game.at(12, 14))
{   
    method image() = "puertaFuego.png"
    method tratarColision(personaje) {}
}

object puertaAgua inherits Elemento (position = game.at(8, 14))
{
    method image() = "puertaAgua.png"
    method tratarColision(personaje) {}
}