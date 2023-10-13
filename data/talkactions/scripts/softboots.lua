function onSay(player, words)
    -- player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Softboots!")
	-- player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    -- player:addItem(6132, 1) -- id new soft boots
    -- player:removeMoney(10000)
    -- player:removeItem(10021, 1)

    -- if player:getItemCount(6530) >= 1 then
    --     if player:removeMoney(10000) then
    --         player:removeItem(6530, 1)
    --         player:addItem(6132, 1) -- id new soft boots
    --         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You charged a soft boots!")
    --     else
    --         player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    --         player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not have enough money!")
    --     end
    if player:getItemCount(10021) >= 1 then
        if player:removeMoney(10000) then
            player:removeItem(10021, 1)
            player:addItem(6132, 1) -- id new soft boots
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have charged the soft boots!")
        else
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not have enough money.")
        end
    else
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not have a worn soft boots!")
    end
    return true
end