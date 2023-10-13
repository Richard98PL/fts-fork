function onSay(player, words, param)
	param = 'thais'
	local town = Town(param) or Town(tonumber(param))

	if not (not player:isPzLocked() and not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)) then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are PZ locked.")
		return false
	end

	if town then
		player:teleportTo(town:getTemplePosition())
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Welcome in Thais!")
	else
		player:sendCancelMessage("Town not found.")
	end
	return true
end