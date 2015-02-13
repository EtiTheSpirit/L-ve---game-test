local game = {}

local phys = require("Phys")

love.audio.setVolume(0.25)

local x = 0
local y = 0
local rate = 2
local change = false
local t = 0
local step = 0
local sec = false
local escape = false

function SetBackground(r, g, b, a)
	love.graphics.setColor(r, g, b, a)
	love.graphics.rectangle("fill", 0, 0, 100000, 100000)
end

function wait(n)
	if not n then n = 0.02 end
	local t = os.clock()
	while os.clock() - t <= n do
		-- nothing
	end
end
idle = love.graphics.newImage("assets/sprites/Ch_Idle.png")
pause = love.graphics.newImage("assets/sprites/Pause.png")
bgs1 = love.sound.newSoundData("assets/sound/Brinstar.mp3")
bgs = love.audio.newSource(bgs1)
bgs:setLooping(true)

played = false
local r = 0
local db2 = false
function game:Run(Character)
	
	function EscMenu(active)
		ps1 = love.sound.newSoundData("assets/sound/Pause.wav")
		ps = love.audio.newSource(ps1)
		if not active then
			db2 = false
			love.audio.play(bgs)
			love.graphics.draw(pause, 100000, 0, 0)
		else
			love.audio.pause(bgs)
			if not db2 then
				love.audio.play(ps)
				db2 = true
			end
			love.graphics.draw(pause, 0, 0, 0)
		end
	end
	SetBackground(255, 255, 255, 255)
	function love.draw(dt)
		if not played then
			love.audio.play(bgs)
			played = true
		end
		love.graphics.setColor(255, 255, 255)
		if not escape then
			EscMenu(false)
			if love.keyboard.isDown("left") then
				if x >= 0 then
					x = x - rate
				elseif x < 0 then
					x = 0
				end
			end
			if love.keyboard.isDown("right") then
				if x <= 736 then
					x = x + rate
				elseif x > 736 then
					x = 736
				end
			end
			if love.keyboard.isDown("up") then
				if y >= 0 then
					y = y - rate
				elseif y < 0 then
					y = 0
				end
			end
			if love.keyboard.isDown("down") then
				if y <= 536 then
					y = y + rate
				elseif y > 536 then
					y = 536
				end
			end
			if love.keyboard.isDown("lshift") then
				sec = true
			else
				sec = false
			end
			phys.newObject("fill", 400, 300, 50, 50, true, rate)
			nx, ny, obj = phys.Character(idle, x, y)
			if obj then
				x = nx
				y = ny
			end
		else
			EscMenu(true)
		end
		function love.keypressed(key, _)
			if key == "escape" then
				escape = not escape
			end
		end
	end
end
return game
