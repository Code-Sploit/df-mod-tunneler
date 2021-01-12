local function calc_yaw(yaw_data)
	local directions = {"+z", "-x", "-z", "+x"}
	return directions[math.floor(yaw_data / 90 + 0.5) + 1]
end

local function dig()
	local player = minetest.localplayer
	local pos = player:get_pos()
	local pos2 = player:get_pos()

	local current_yaw_number = player:get_yaw()

	-- Set pos2.y to one block higher then pos.y
	pos2.y = pos2.y + 1
	
	if calc_yaw(current_yaw_number) == "+x" then
		pos.x = pos.x + 1
		pos2.x = pos2.x + 1
	elseif calc_yaw(current_yaw_number) == "-x" then
		pos.x = pos.x - 1
		pos2.x = pos2.x - 1
	elseif calc_yaw(current_yaw_number) == "+z" then
		pos.z = pos.z + 1
		pos2.z = pos2.z + 1
	elseif calc_yaw(current_yaw_number) == "-z" then
		pos.z = pos.z - 1
		pos2.z = pos2.z - 1
	end

	minetest.dig_node(pos)
	minetest.dig_node(pos2)
end

minetest.register_chatcommand("tunnel", {
	description = "Start tunneling",

	func = function()
		dig()
	end,
})

minetest.register_globalstep(function()
	if core.settings:get("tunneler") then
		dig()
	end
end)

minetest.register_cheat("Tunneler", "World", "tunneler")
