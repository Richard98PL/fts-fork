local brightSword = MoveEvent()

function brightSword.onStepIn(creature, item, position, fromPosition)
	creature:teleportTo(Position(32619, 32249, 8))
	return true
end

brightSword:type("stepin")
brightSword:aid(5634)
brightSword:register()
