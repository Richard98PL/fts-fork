function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

    Game.broadcastMessage(param, MESSAGE_STATUS_WARNING)
    return true
end