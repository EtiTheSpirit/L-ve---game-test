local phys = {}

local Character = {}
Character.X = 0
Character.Y = 0
Character.X2 = 0
Character.Y2 = 0
obj = false

function distance(x1, y1, x2, y2)
	local x = ( x2-x1 )^2
	local y = ( y2-y1 )^2
	local d = math.sqrt(x+y)
	return d
end

function didCollide(did, collide)
	love.graphics.print("Touching = "..tostring(did), 0, 0)
	love.graphics.print("CharacterPos = ("..Character.X..", "..Character.Y..")", 0, 15)
	if collide then
		obj = did
	else
		obj = false
	end
end
col = false
function phys.newObject(mode, xpos, ypos, xs, ys, collide, rate)
	love.graphics.rectangle(mode, xpos, ypos, xs, ys)
	local x = Character.X
	local y = Character.Y
	local cx = xpos+(xs/2)
	local cy = ypos+(ys/2)
	local Hleft = xpos-(xs/2)-32
	local Hright = xpos+(xs/2)+32
	local Hup = ypos-(ys/2)-32
	local Hdown = ypos+(ys/2)+32
	local ctop = y-32
	local cbot = y+32
	local clef = x-32
	local crig = x+32
	didCollide(col, collide)
	if collide then
		local top = cbot-Hup >= 0 and cbot-ypos <= 0
		local bottom = ctop-Hdown <= 0 and ctop-ypos >= 0
		local left = crig-Hleft >= 0 and crig-xpos <= 0
		local right = clef-Hright <= 0 and clef-xpos >= 0
		love.graphics.print("Top="..tostring(top).." Bottom="..tostring(bottom).." Left="..tostring(left).." Right="..tostring(right), 0, 30)
		if x >= Hleft and x <= Hright and y >= Hup and y <= Hdown then
			col = true
			if left then
				Character.X2 = x-rate
				Character.Y2 = y
			end
			if right then
				Character.X2 = x+rate
				Character.Y2 = y
			end
			if top then
				Character.Y2 = y-rate
				Character.X2 = x
			end
			if bottom then
				Character.Y2 = y+rate
				Character.X2 = x
			end
		else
			col = false
		end
	end
end

function phys.Character(image, x, y)
	love.graphics.draw(image, x, y, 0, 2)
	Character.X = x
	Character.Y = y
	return Character.X2, Character.Y2, obj
end

return phys
