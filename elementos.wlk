import personajes.*

class Elemento 
{
    var property position
    method puedeSerAtravesado() = true
    method puedeSerPresionado() = false
    method puedePresionarBoton() = false
    method puedeSerMovido() = false
    method tratarColision(personaje) {}
}
class Elevador 
{
    const posicionInicial
    var property activado = false
    method image() = "elevador2.png"
    method puedeSerAtravesado() = false

    method cambiarEstado(nuevoEstado) 
    {
        if(nuevoEstado != activado)
        {
            activado = nuevoEstado
            game.sound("elevador.ogg").play()
        }
    }

    method position()
    {
        if(activado){
            return posicionInicial.down(1)
        }

        return posicionInicial
    }
}

const elevadorPorBoton = new Elevador (posicionInicial = game.at(14, 9))

const elevadorPorPalanca = new Elevador (posicionInicial = game.at(0, 6))

class Boton inherits Elemento 
{
    method image() = "boton2.png"

    method estaPresionado()
    {
        const posibles = game.getObjectsIn(self.position())
        return posibles.any({objeto => objeto.puedePresionarBoton()})
    }
}

object botonAbajo inherits Boton (position = game.at(5, 7))
{
    method chequearBoton()
    {
        if(self.estaPresionado() || botonArriba.estaPresionado()) elevadorPorBoton.cambiarEstado(true)
        else elevadorPorBoton.cambiarEstado(false)
    }
}
object botonArriba inherits Boton (position = game.at(10, 10))
{
}

object palanca inherits Elemento (position = game.at(3, 4))
{
    method image() = "palanca.png"
    override method puedeSerPresionado() = true

    method activar() {
       if(elevadorPorPalanca.activado()) elevadorPorPalanca.cambiarEstado(false) 
       else elevadorPorPalanca.cambiarEstado(true)
       game.sound("activar.ogg").play()
    }
}

object cubo inherits Elemento (position = game.at(6, 10))
{
    method image() = "cubo.png"
    override method puedeSerAtravesado() = false
    override method puedePresionarBoton() = true
    override method puedeSerMovido() = true

    method moverse(desplazamiento)
    {
        position = game.at(position.x() + desplazamiento, position.y())
        game.sound("bloque.ogg").play() 
    }
}

object puertaFuego inherits Elemento (position = game.at(12, 14))
{   
    method image() = "puertaFuego.png"
    override method tratarColision(personaje) {}
}

object puertaAgua inherits Elemento (position = game.at(8, 14))
{
    method image() = "puertaAgua.png"
    override method tratarColision(personaje) {}
}