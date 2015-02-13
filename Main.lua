isMM = true
didGame = false
CurrentState = "MainMenu"
debug = true
local Character = "Human"

love.audio.setVolume(0.25)

game = require("Game")

function setColor(r, g, b, a)
	love.graphics.setColor(r, g, b, a)
end

function wait(n)
	if not n then n = 0.02 end
	local t = os.clock()
	while os.clock() - t <= n do
		-- nothing
	end
end

function SetBackground(r, g, b, a)
	setColor(r, g, b, a)
	love.graphics.rectangle("fill", 0, 0, 100000, 100000)
end

function GPrint(txt, x, y)
	love.graphics.print(txt, x, y)
end

function Clear()
	love.graphics.clear()
end

function love.load(arg)
	blip1 = love.sound.newSoundData("assets/sound/Blip.mp3")
	click1 = love.sound.newSoundData("assets/sound/Click.mp3")
	BGI = love.graphics.newImage("assets/sprites/Title.png")
	button = love.graphics.newImage("assets/sprites/Button.png")
	blip = love.audio.newSource(blip1)
	click = love.audio.newSource(click1)
	love.window.setTitle("The World of Aazara RPG by Brent \"XanthicDragon\" Duanne")
	icon = love.image.newImageData("assets/sprites/Icon.png")
	love.window.setIcon(icon)
end

image = love.graphics.newImage("assets/sprites/Power.png")

function Circle(x, y, radi, r, g, b)
	love.graphics.circle("fill", x, y, radi, 360)
	setColor(0, 0, 0, 255)
	love.graphics.circle("line", x, y, radi, 360)
	setColor(r, g, b, 255)
end
db = false
played = false

title1 = love.sound.newSoundData("assets/sound/Title.wav")
title = love.audio.newSource(title1)
if not played then
	love.audio.play(title)
	played = true
end
function love.draw(dt)
	love.graphics.draw(BGI, 0, 0, 0, 1)
	if not played then
		love.audio.play(title)
		played = true
	end
	setColor(255, 255, 255, 255)
	--love.graphics.rectangle("fill", 292.5, 350, 200, 50) --Start game
	--love.graphics.rectangle("fill", 292.5, 425, 200, 50) --Exit
	love.graphics.draw(button, 292.5, 340, 0, 3, 2) --Start game II
	love.graphics.draw(button, 292.5, 414.5, 0, 3, 2) --Exit II
	love.graphics.draw(button, 292.5, 489, 0, 3, 2) --Char select
	--Draw text in rectangles
	love.graphics.draw(image, 525, 450, 0, 1, 1, 0, 0)
	setColor(0, 0, 0)
	GPrint("Start Game", 355, 370)
	GPrint("Exit", 380, 445)
	GPrint("Characters", 355, 520)
	
	setColor(255, 255, 255)
	
	function love.mousepressed(x, y, _)
		if CurrentState == "MainMenu" then
			if x >= 292.5 and x <= 492.5 and y >= 350 and y <= 400 then
				didGame = true
				love.audio.play(click)
			elseif x >= 292.5 and x <= 492.5 and y >= 425 and y <= 475 then
				love.audio.play(click)
				db = true
				wait(0.1)
				love.event.quit()
			elseif x >= 292.5 and x <= 492.5 and y >= 489 and y <= 539 then
				love.audio.play(click)
			end
		end
	end
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	if x >= 292.5 and x <= 492.5 and y >= 350 and y <= 400 then
		if not db then
			love.audio.play(blip)
			db = true
		end
	elseif x >= 292.5 and x <= 492.5 and y >= 425 and y <= 475 then
		if not db then
			love.audio.play(blip)
			db = true
		end
	elseif x >= 292.5 and x <= 492.5 and y >= 489 and y <= 539 then
		if not db then
			love.audio.play(blip)
			db = true
		end
	else
		love.audio.stop(blip)
		db = false
	end
	if didGame then
		Clear()
		CurrentState = "Game"
		game:Run(Character)
	end
	
end
