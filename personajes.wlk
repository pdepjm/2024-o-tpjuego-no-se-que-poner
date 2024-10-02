object fireboy
{
	var property position = game.at(0,0)
    var posicionAnt = null
	var cantSaltos = 0
	method image() = "fireboy6.png"
	method movIzquierda()
	{
        posicionAnt = position
		position = position.left(1)
	}
	method movDerecha()
	{
        posicionAnt = position
		position = position.right(1)
	}
	method movSaltar()
	{
		if(cantSaltos < 2)
		{
            posicionAnt = position
			position = position.up(1)
			cantSaltos += 1
			game.schedule(800, {
				position = position.down(1)
				if(cantSaltos==2) cantSaltos = 0	
			})
		}
	}
    method retroceder() {
      position = posicionAnt
    }
}

object watergirl
{
	var property position = game.at(0,2)
	var cantSaltos = 0
	method image() = "watergirl3.png"
	method movIzquierda()
	{
		position = position.left(1)
	}
	method movDerecha()
	{
		position = position.right(1)
	}
	method movSaltar()
	{
		if(cantSaltos < 2)
		{
			position = position.up(1)
			cantSaltos += 1
			game.schedule(800, {
				position = position.down(1)
				if(cantSaltos==2) cantSaltos = 0	
			})
		}
	}
}
