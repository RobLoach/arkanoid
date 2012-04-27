
function love.load()
	gs = require 'hump/gamestate'
	timer = require 'hump/timer'
	gui = require 'quickie'
	g = love.graphics

	game = {}
	game.state = {}
	game.state.menu = require 'states/main_menu'
	game.state.play = require 'states/play'
	game.level = require 'game/level'
	gs.switch(game.state.menu)
end

function love.update(dt)
	timer.update(dt)
	gs.update(dt)
end

function love.draw()
	gs.draw()
	gui.core.draw()

	g.setColor(255,255,255)
	g.print(love.timer.getFPS()..' fps', 5, 5)
end

function love.keypressed(key, code)
	if key == 'f12' then g.toggleFullscreen() end
	gs.keypressed(key, code)
	gui.core.keyboard.pressed(key, code)
end
