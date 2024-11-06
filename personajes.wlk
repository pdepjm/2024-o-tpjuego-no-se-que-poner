class Personaje {
	var property position
	var cantSaltos = 0
	var property estaMuerto = false
	var estaSaltando = false
	method tratarColision(personaje) {}
	method puedeSerAtravesado() = true
	method puedePresionarBoton() = true
	method puedeSerMovido() = false
	method puedeSerPresionado() = false

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
	
	method movSaltar() 
	{
		if (cantSaltos < 2) {
			self.movSubir()
			cantSaltos += 1
			game.schedule(800, {
				self.caer()
				estaSaltando = false
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
		const posiblesObjetos = game.getObjectsIn(posicion)
		return posiblesObjetos.all({ objeto => objeto.puedeSerAtravesado() }) && self.dentroDeLosLimites(posicion)
  	}

	method dentroDeLosLimites(posicion) = posicion.x().between(0, 14) && posicion.y().between(0, 15)

	method morir(){
		if(!estaMuerto) game.sound("morir.ogg").play()	
	  	game.removeVisual(self)
		estaMuerto = true
	}

}

object fireboy inherits Personaje (position = game.at(0, 0)) {
	method image() = "fireboy6.png"
	method tocarFuego(){}
	method tocarAgua(){ self.morir()}

	method presionar()
	{
		const elemento = game.getObjectsIn(self.position()).head()
		if(elemento.puedeSerPresionado()) elemento.activar()  
	}
}

object watergirl inherits Personaje (position = game.at(0, 2)) {
	method image() = "watergirl3.png"
	method tocarFuego(){self.morir()}
	method tocarAgua(){}

	method moverElemento()
	{
		const elementosIzquierda = game.getObjectsIn(self.position().left(1))
		const elementosDerecha = game.getObjectsIn(self.position().right(1))
		if(elementosIzquierda.size() > 0)
		{
			elementosIzquierda.forEach({elemento => if(elemento.puedeSerMovido()) elemento.moverse(-1)})
		}
		else if(elementosDerecha.size() > 0)
		{
			elementosDerecha.forEach({elemento => if(elemento.puedeSerMovido()) elemento.moverse(1)})
		}
	}
}