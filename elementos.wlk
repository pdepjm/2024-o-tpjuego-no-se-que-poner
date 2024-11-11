import personajes.*
import mapa.*

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
    const offset
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
            return posicionInicial.down(offset)
        }

        return posicionInicial
    }

    method reiniciar()
    {
        activado = false
    }
}

class ElevadorPorBoton inherits Elevador
{
    const botonAsociado1
    const botonAsociado2

    method chequearSusBotones()
    {
        if(botonAsociado1.estaPresionado() || botonAsociado2.estaPresionado()) self.cambiarEstado(true)
        else self.cambiarEstado(false)
    }

    method agregarseAlMapa()
    {
        game.addVisual(self)
        game.addVisual(botonAsociado1)
        game.addVisual(botonAsociado2)
    }
}

class ElevadorPorPalanca inherits Elevador
{
    const palancaAsociada

    method chequearSuPalanca()
    {
        if(palancaAsociada.estaActiva()) self.cambiarEstado(true)
        else self.cambiarEstado(false)
    }

    method agregarseAlMapa()
    {
        game.addVisual(self)
        if(!game.hasVisual(palancaAsociada))game.addVisual(palancaAsociada)
    }

    override method reiniciar()
    {
        super()
        palancaAsociada.reiniciar()
    }
}
class Boton inherits Elemento 
{
    method image() = "boton2.png"

    method estaPresionado()
    {
        const posibles = game.getObjectsIn(self.position())
        return posibles.any({objeto => objeto.puedePresionarBoton()})
    }
}
class Palanca inherits Elemento
{
    var property estaActiva = false
    method image() = "palanca.png"

    override method puedeSerPresionado() = true

    method activar() {
       estaActiva = !estaActiva
       game.sound("activar.ogg").play()
    }

    method reiniciar() 
    {
        estaActiva = false
    }
}

const primerElevadorPorBoton = new ElevadorPorBoton (posicionInicial = game.at(14, 9), 
                                                    botonAsociado1 = new Boton (position = game.at(5, 7)), 
                                                    botonAsociado2 = new Boton (position = game.at(10, 10)),
                                                    offset = 1)
const segundoElevadorPorBoton = new ElevadorPorBoton(posicionInicial = game.at(8,14),
                                                    botonAsociado1 = new Boton (position = game.at(4, 14)), 
                                                    botonAsociado2 = new Boton (position = game.at(12, 14)),
                                                    offset = -1)

const primerElevadorPorPalanca = new ElevadorPorPalanca (posicionInicial = game.at(0, 6), 
                                                    palancaAsociada = new Palanca (position = game.at(3, 4)),
                                                    offset = 1)
const palancaMultiple = new Palanca(position = game.at(6,16))

const segundoElevadorPorPalanca = new ElevadorPorPalanca (posicionInicial = game.at(9, 17), 
                                                    palancaAsociada = palancaMultiple,
                                                    offset = 1)
const terceroElevadorPorPalanca = new ElevadorPorPalanca (posicionInicial = game.at(7, 18), 
                                                    palancaAsociada = palancaMultiple,
                                                    offset = 1)
const cuartoElevadorPorPalanca = new ElevadorPorPalanca (posicionInicial = game.at(5, 19), 
                                                    palancaAsociada = palancaMultiple,
                                                    offset = 1)                                                   
object cubo inherits Elemento (position = game.at(6, 10))
{
    method image() = "cubo.png"
    override method puedeSerAtravesado() = false
    
    override method puedeSerMovido() = true

    method moverse(desplazamiento)
    {
        position = game.at(position.x() + desplazamiento, position.y())
        game.sound("bloque.ogg").play() 
    }

    method reiniciar()
    {
        position = game.at(6, 10)
    }
}

class Puerta inherits Elemento
{
    const property tipo
    method puedeAbrirla(personaje) = (tipo == personaje.tipo())
    const imagenCerrada
    var property estaAbierta = false
    //method puedeAbrirPuertaFuego() = false
	//method puedeAbrirPuertaAgua() = false
    method image()
    {
        if(estaAbierta) return "puertaAbierta.png"
        return imagenCerrada
    }
    
    method hayAlguienEnPuerta()
    {
        const posibles = game.getObjectsIn(self.position())
        return posibles.any({ p => (self.puedeAbrirla(p) && self!=p) })
    }

    method chequearPuerta()
    {
        if(self.hayAlguienEnPuerta() && !estaAbierta)
        {
            estaAbierta = self.hayAlguienEnPuerta()
            game.sound("puerta.ogg").play()
        }
        if (juego.condicionesGanadoras())
        {
            juego.ganaste()
        }
    }
}

const puertaFuego = new Puerta(position = game.at(3, 19), imagenCerrada = "puertaFuego.png", tipo = fuego)

const puertaAgua = new Puerta (position = game.at(1, 19), imagenCerrada = "puertaAgua.png", tipo = agua)

/*class Puerta inherits Elemento
{
    const condicion 
    const imagenCerrada
    var property estaAbierta = false
    method puedeAbrirPuertaFuego() = false
	method puedeAbrirPuertaAgua() = false
    method image()
    {
        if(estaAbierta) return "puertaAbierta.png"
        return imagenCerrada
    }
    
    method hayAlguienEnPuerta()
    {
        const posibles = game.getObjectsIn(self.position())
        return posibles.any(condicion)
    }

    method chequearPuerta()
    {
        if(self.hayAlguienEnPuerta() != estaAbierta)
        {
            estaAbierta = self.hayAlguienEnPuerta()
            game.sound("puerta.ogg").play()
        }
    }
}

const puertaFuego = new Puerta(position = game.at(3, 19), imagenCerrada = "puertaFuego.png", condicion = {p => p.puedeAbrirPuertaFuego()})

const puertaAgua = new Puerta (position = game.at(1, 19), imagenCerrada = "puertaAgua.png", condicion = {p => p.puedeAbrirPuertaAgua()})*/