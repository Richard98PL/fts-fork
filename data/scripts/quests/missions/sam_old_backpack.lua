local door = Action()

function door.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= 1225 then
		return true
	end

	if player:getStorageValue(PlayerStorageKeys.SamsOldBackpack) == 2 then
		player:teleportTo(toPosition, true)
		item:transform(1226)
	end
	return true
end

door:aid(42535)
door:register()
