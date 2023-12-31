local lockPick = Action()

function lockPick.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid ~= 12503 then
		return false
	end

	if math.random(100) <= 15 then
		if player:getStorageValue(PlayerStorageKeys.thievesGuild.Mission02) == 1 then
			player:addItem(8760, 1)
			player:setStorageValue(PlayerStorageKeys.thievesGuild.Mission02, 2)
		end
	else
		item:remove(1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your lock pick broke.")
	end
	return true
end

lockPick:id(8717)
lockPick:register()
