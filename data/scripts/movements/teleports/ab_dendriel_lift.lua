local config = {
	[9700] = Position(32667, 31681, 6),
	[9701] = Position(32726, 31666, 6),
	[9702] = Position(32674, 31617, 6),
	[9703] = Position(32664, 31679, 6),
	[9704] = Position(32658, 31688, 8),
	[9705] = Position(32655, 31688, 6)
}

local abDendrielLift = MoveEvent()

function abDendrielLift.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = config[item.actionid]
	if not targetPosition then
		return true
	end

	player:teleportTo(targetPosition)
	targetPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

abDendrielLift:type("stepin")
abDendrielLift:aid(9700, 9701, 9702, 9703, 9704, 9705)
abDendrielLift:register()
