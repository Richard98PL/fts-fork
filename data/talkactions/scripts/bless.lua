-- !blessing by leo
local cost = 100 -- 10k each bless

	
function onSay(player, words)

	if(player:hasBlessing(1) and player:hasBlessing(2) and player:hasBlessing(3) and player:hasBlessing(4) and player:hasBlessing(5) and player:hasBlessing(6)) then        
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You already have all blessings.')  
        return true
    end

	
	if (player:hasBlessing(1) == false) then
		if player:removeMoney(cost) == false then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You dont have enough money.')  
			return false		
		end
		player:addBlessing(1)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You Receive The Twist of Fate Blessing')  
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	
	if (player:hasBlessing(2) == false) then
		if player:removeMoney(cost) == false then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You dont have enough money.')  
			return false		
		end
		player:addBlessing(2)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You Receive The Wisdom of Solitude Blessing')  
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	
	if (player:hasBlessing(3) == false) then
		if player:removeMoney(cost) == false then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You dont have enough money')  
			return false		
		end
		player:addBlessing(3)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You Receive The Spark of the Phoenix Blessing')  
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	
	if (player:hasBlessing(4) == false) then
		if player:removeMoney(cost) == false then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You dont have enough money')  
			return false		
		end
		player:addBlessing(4)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You Receive The Fire of the Suns Blessing')  
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	
	if (player:hasBlessing(5) == false) then
		if player:removeMoney(cost) == false then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You dont have money')  
			return false		
		end
		player:addBlessing(5)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You Receive The Spiritual Shielding Blessing')  
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	
	if (player:hasBlessing(6) == false) then
		if player:removeMoney(cost) == false then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You dont have money')  
			return false		
		end
		player:addBlessing(6)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,'You Receive The Embrace of Tibia Blessing')  
		player:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	
	
	
	
	return true
end