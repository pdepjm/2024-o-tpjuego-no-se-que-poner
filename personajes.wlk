object fireboy
{
	var property position = game.at(1,0)
    var property posicionAnt = game.at(1,0)
	var cantSaltos = 0
	
	method image() = "fireboy6.png"
	
	method movIzquierda()
	{
        self.actualizarPosicionAnt()
		position = position.left(1)
	}
	
	method movDerecha()
	{
        self.actualizarPosicionAnt()
		position = position.right(1)
	}
	
	method movSaltar()
	{
		if(cantSaltos < 2)
		{
			self.actualizarPosicionAnt()
			position = position.up(1)
			cantSaltos += 1
			game.schedule(800, {
				position = position.down(1)
				if(cantSaltos==2) cantSaltos = 0	
			})
		}
	}
    
	method retroceder() {
      position = self.posicionAnt()
    }

	method actualizarPosicionAnt(){
		posicionAnt = position
	}
	
	method caer() {
		self.actualizarPosicionAnt()
		position = position.down(1)
	}
	
    method tratarColision(watergirl) {
		self.kill()
		watergirl.kill()
	}

	method kill(){
		position = game.at(1,0)
		posicionAnt = game.at(1,0)
		game.say(watergirl,"Jaja ripeo el otro")
		game.say(self,"wahhhah me MORI")

	}

	method tratarColisionBloqueFuego() {}
	method tratarColisionBloqueAgua() {self.kill()}
}

object watergirl
{
	var property position = game.at(1,2)
	var property posicionAnt = game.at(1,2)
	var cantSaltos = 0
	method image() = "watergirl3.png"
	method movIzquierda()
	{
		self.actualizarPosicionAnt()
		position = position.left(1)
	}
	method movDerecha()
	{
		self.actualizarPosicionAnt()
		position = position.right(1)
	}
	method movSaltar()
	{
		if(cantSaltos < 2)
		{
			self.actualizarPosicionAnt()
			position = position.up(1)
			cantSaltos += 1
			game.schedule(800, {
				if(cantSaltos==2) cantSaltos = 0	
			})
		}
	}
	method actualizarPosicionAnt(){
		posicionAnt = position
	}
	method retroceder() {
	  position = self.posicionAnt()
	}

	method caer() {
		self.actualizarPosicionAnt()
		position = position.down(1)
	}
	
	method tratarColision(fireboy) {
		self.kill()
		fireboy.kill()
	}

	
	
	method kill(){
		position = game.at(1,2)
		posicionAnt = game.at(1,2)
		game.say(fireboy,"Jaja ripeo la otra")
		game.say(self,"wahhhah me MORI")
		
	}

	method tratarColisionBloqueFuego() {self.kill()}
	method tratarColisionBloqueAgua() {}

}
