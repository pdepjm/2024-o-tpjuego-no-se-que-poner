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
        game.sound("elevador.ogg").play()
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

object elevadorPorBoton inherits Elevador (position = game.at(14, 9))
{
    override method bajar()
    {
        position = game.at(14,8)
        activado = true
    }

    override method subir()
    {
        position = game.at(14,9)
        activado = false
    }
}

const elevadorPorPalanca = new Elevador (position = game.at(0, 6))

class Boton inherits Elemento 
{
    method image() = "boton2.png"
    method tratarColision(personaje) {
    }

    method estaPresionado()
    {
        const posibles = game.getObjectsIn(self.position())
        return posibles.any({objeto => objeto.tipo() == "personaje"})
    }


}

object botonAbajo inherits Boton (position = game.at(5, 7))
{
    method chequearBoton()
    {
        if(self.estaPresionado() || botonArriba.estaPresionado()) elevadorPorBoton.bajar()
        else elevadorPorBoton.subir()
    }
}
object botonArriba inherits Boton (position = game.at(10, 10))
{
}

object palanca inherits Elemento (position = game.at(3, 4))
{
    method image() = "palanca.png"
    
    method tratarColision(personaje){}

    method activar() {
       elevadorPorPalanca.activarse()
       game.sound("activar.ogg").play()
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