-- start, play, pause, win, death
--state = "start"

function love.load()
	g = love.graphics

	love.mouse.setVisible(false)

	particle = g.newImage('flare.png')
	ps = g.newParticleSystem(particle, 1500)
	p = ps
	p:setPosition(100, 100)
	p:setEmissionRate(350)
--	p:setLifetime(2)
	p:setSizes(0.5, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2)
	p:setTangentialAcceleration(-100.0, 100.0)
	p:setSpeed(50, 100)
	p:setParticleLife(1.5)
	p:setSpin(1)
	p:setSpread(360)
	p:setColors(120,130,255,255, 200,200,255,255, 200,200,255,0)
	p:start()

	ball_ps = g.newParticleSystem(particle, 1500)
	p = ball_ps
	p:setPosition(100, 100)
	p:setEmissionRate(350)
--	p:setLifetime(2)
	p:setSizes(0.5, 0.3, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1)
	p:setTangentialAcceleration(-100.0, 100.0)
	p:setSpeed(50, 100)
	p:setParticleLife(1.0)
	p:setSpin(1)
	p:setSpread(360)
	p:setColors(120,130,255,255, 200,200,255,255, 200,200,255,0)
	p:start()

	
	part1 = g.newImage("part1.png");
	explosions = {}

	game = require 'game'
	game.level = require 'level'
	game.level.load()
end

function love.update(dt)
	game.update(dt)
	ps:setPosition(love.mouse.getX(), love.mouse.getY())
--	ps:update(dt)

	for i, e in ipairs(explosions) do 
		if not e:isActive() then
			table.remove(explosions, i)
		else
			e:update(dt) 
		end
	end
end

function love.draw()
	game.draw()

	love.graphics.setColorMode("modulate")
	love.graphics.setBlendMode("additive")
--	g.draw(ps, 0, 0)

	for _, e in ipairs(explosions) do g.draw(e, 0, 0) end

	local text = ps:count()..' particles'
	text = text..'\n'..love.timer.getFPS()..' fps'
	text = text..'\n'..#explosions..' explosions'
	g.print(text, 5, 5)
end

function love.keypressed(key)
	game.keypressed(key)
	if key == "escape" then love.event.push('quit') end
end