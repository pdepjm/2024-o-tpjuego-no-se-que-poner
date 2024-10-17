class Personaje {
	var property position
	var cantSaltos = 0
	var estaSaltando = false
	method tipo() = "personaje"
	method tratarColision(personaje) {}
	
	method moverse(nuevaPosicion) 
	{
		if (self.puedeMoverse(nuevaPosicion)) position = nuevaPosicion
	}
	
	method movIzquierda() 
	{
		self.moverse(position.left(1))
		if(!estaSaltando) self.caer()
	}
	
	method movDerecha() 
	{
		self.moverse(position.right(1))
		if(!estaSaltando)self.caer()
	}
	
	method movSubir() 
	{
		self.moverse(position.up(1))
		game.sound("salto.ogg").play()
		estaSaltando = true
	}
	
	method movBajar() 
	{
		self.moverse(position.down(1))
		estaSaltando = false
	}
	
	method movSaltar() 
	{
		if (cantSaltos < 2) {
			self.movSubir()
			cantSaltos += 1
			game.schedule(800, {
				self.movBajar()
				if (cantSaltos == 2) cantSaltos = 0
			})
		}
	}
	
	method caer() 
	{
   		const posicionAnt = self.position()
		var puedeBajar = true
    
    	(1..4).forEach { y =>
			if (self.puedeMoverse(posicionAnt.down(y)) && puedeBajar) position = posicionAnt.down(y)
			else puedeBajar = false

    	}
	}
	
	method puedeMoverse(posicion) 
	{
		if(self.dentroDeLosLimites(posicion))
		{
			const posiblesObjetos = game.getObjectsIn(posicion)
			return posiblesObjetos.all({ objeto => objeto.tipo() != "BloqueTierra" && objeto.tipo() != "Elevador" })  	
		}
		else return false
	}

	method dentroDeLosLimites(posicion) = posicion.x().between(0, 14) && posicion.y().between(0, 15)

	method presionar()
	{
		const presionable = game.getObjectsIn(self.position()).head()
		if(presionable.tipo() == "Elemento") presionable.activar()  
	}

	method morir(){
	  game.removeVisual(self)
	}
}

object fireboy inherits Personaje (position = game.at(0, 0)) {
	method image() = "fireboy6.png"
	method tocarFuego(){}
	method tocarAgua(){ self.morir()}
}

object watergirl inherits Personaje (position = game.at(0, 2)) {
	method image() = "watergirl3.png"
	method tocarFuego(){self.morir()}
	method tocarAgua(){}
}