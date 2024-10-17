import personajes.*

class Elemento 
{
    var property position
    method tipo() = "Elemento"
}

object boton inherits Elemento (position = game.at(5, 7))
{
    method image() = "boton.png"
    method tratarColision() {}
}

object elevadorPorPalanca inherits Elemento (position = game.at(0, 6))
{
    method image() = "elevador2.png"
    method tratarColision() {}
}

object elevadorPorBoton inherits Elemento (position = game.at(14, 9))
{
    method image() = "elevador2.png"
    method tratarColision() {}
}

object palanca inherits Elemento (position = game.at(3, 4))
{
    method image() = "palanca.png"
    method tratarColision() {}
}

object puertaFuego inherits Elemento (position = game.at(12, 14))
{   
    method image() = "puertaFuego.png"
    method tratarColision() {}
}

object puertaAgua inherits Elemento (position = game.at(8, 14))
{
    method image() = "puertaAgua.png"
    method tratarColision() {}
}

object cubo inherits Elemento (position = game.at(6, 10))
{
    method image() = "cubo.png"
    method tratarColision() {}
}
