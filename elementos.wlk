import personajes.*

object ayudaTexto{

    method position() = game.at(0,14)
    method text()="Salta en tu lugar antes de cualquier salto para sacar el timing"
    method textcolor() = "00FF00FF"
    method tratarColision() {}
}
object boton
{
    var property position = game.at(5,7) 
    method image() = "boton.png"
    method tratarColision() {}
}

object elevadorPorPalanca 
{
    var property position = game.at(0,6) 
    method image() = "elevador2.png"
    method tratarColision() {}
}

object elevadorPorBoton 
{
    var property position = game.at(14,9) 
    method image() = "elevador2.png"
    method tratarColision() {}
}

object palanca 
{
    var property position = game.at(3,4) 
    method image() = "palanca.png"
    method tratarColision() {}
}

object puertaFuego 
{   var property puertaFuegoAbierta = false
    var property position = game.at(12,14) 
    method image() = "puertaFuego.png"
    method tratarColision(fireboy) {self.puertaFuegoAbierta(true);if(puertaAgua.puertaAguaAbierta()){game.say(fireboy,"Ganaste!")}  }
    method tratarColision() {}
}

object puertaAgua 
{   var property puertaAguaAbierta=false
    var property position = game.at(8,14) 
    method image() = "puertaAgua.png"
    method tratarColision(watergirl) {self.puertaAguaAbierta(true); if(self.puertaAguaAbierta()){game.say(watergirl,"Ganaste!")}}
    method tratarColision() {}
}

object cubo 
{
    var property position = game.at(6,10) 
    method image() = "cubo.png"
    method tratarColision() {}

}
