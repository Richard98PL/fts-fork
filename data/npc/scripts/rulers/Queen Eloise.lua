local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()							npcHandler:onThink()						end

-- Promotion
local promoteKeyword = keywordHandler:addKeyword({'promot'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you want to be promoted in your vocation for 20000 gold?'})
promoteKeyword:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, level = 20, cost = 20000})
promoteKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Ok, whatever.', reset = true})

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if msgcontains(msg, "outfit") or msgcontains(msg, "addon") then
		npcHandler:say("In exchange for a truly generous donation, I will offer a special outfit. Do you want to make a donation?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({
				"Excellent! Now, let me explain. If you donate 1.000.000.000 gold pieces, you will be entitled to wear a unique outfit. ...",
				"You will be entitled to wear the {armor} for 500.000.000 gold pieces, {helmet} for an additional 250.000.000 and the {boots} for another 250.000.000 gold pieces. ...",
				"What will it be?"
			}, cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say("In that case, return to me once you made up your mind.", cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			if player:getStorageValue(PlayerStorageKeys.goldenOutfit) < 1 then
				if player:getTotalMoney() >= 500000000 then
					local storeInbox = player:getStoreInbox()
					if storeInbox then
						local item = Game.createItem(ITEM_DECORATION_KIT, 1)
						if item then
							item:setStoreItem(true)
							item:setAttribute("wrapid", 34156)
							item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Unwrap it in your own house to create a " .. ItemType(34156):getName() .. ".")
							storeInbox:addItemEx(item)
						end

						npcHandler:say("Take this armor as a token of great gratitude. Let us forever remember this day, my friend!", cid)
						player:removeTotalMoney(500000000)
						player:addOutfit(1211)
						player:addOutfit(1210)
						player:getPosition():sendMagicEffect(CONST_ME_EARLY_THUNDER)
						player:setStorageValue(PlayerStorageKeys.goldenOutfit, 1)
						npcHandler.topic[cid] = 2
					end
				else
					npcHandler:say("You do not have enough money to donate that amount.", cid)
					npcHandler.topic[cid] = 2
				end
			else
				npcHandler:say("You already own this outfit.", cid)
				npcHandler.topic[cid] = 0
			end
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 4 then
			if player:getStorageValue(PlayerStorageKeys.goldenOutfit) == 1 then
				if player:getStorageValue(PlayerStorageKeys.goldenOutfit) < 2 then
					if player:getTotalMoney() >= 250000000 then
						npcHandler:say("Take this helmet as a token of great gratitude. Let us forever remember this day, my friend.", cid)
						player:removeTotalMoney(250000000)
						player:addOutfitAddon(1210, 2)
						player:addOutfitAddon(1211, 2)
						player:getPosition():sendMagicEffect(CONST_ME_EARLY_THUNDER)
						player:setStorageValue(PlayerStorageKeys.goldenOutfit, 2)
						npcHandler.topic[cid] = 2
					else
						npcHandler:say("You do not have enough money to donate that amount.", cid)
						npcHandler.topic[cid] = 2
					end
				else
					npcHandler:say("You already own this addon.", cid)
					npcHandler.topic[cid] = 2
				end
			else
				npcHandler:say("You need to donate for the {armor} outfit first.", cid)
				npcHandler.topic[cid] = 2
			end
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 5 then
			if player:getStorageValue(PlayerStorageKeys.goldenOutfit) == 2 then
				if player:getStorageValue(PlayerStorageKeys.goldenOutfit) < 3 then
					if player:getTotalMoney() >= 250000000 then
						npcHandler:say("Take this boots as a token of great gratitude. Let us forever remember this day, my friend.", cid)
						player:removeTotalMoney(250000000)
						player:addOutfitAddon(1210, 1)
						player:addOutfitAddon(1211, 1)
						player:getPosition():sendMagicEffect(CONST_ME_EARLY_THUNDER)
						player:setStorageValue(PlayerStorageKeys.goldenOutfit, 3)
						npcHandler.topic[cid] = 2
					else
						npcHandler:say("You do not have enough money to donate that amount.", cid)
						npcHandler.topic[cid] = 2
					end
				else
					npcHandler:say("You already own this addon.", cid)
					npcHandler.topic[cid] = 2
				end
			else
				npcHandler:say("You need to donate for the {helmet} addon first.", cid)
				npcHandler.topic[cid] = 2
			end
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "armor") and npcHandler.topic[cid] == 2 then
		npcHandler:say("So you would like to donate 500.000.000 gold pieces which in return will entitle you to wear a unique armor?", cid)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, "helmet") and npcHandler.topic[cid] == 2 then
		npcHandler:say("So you would like to donate 250.000.000 gold pieces which in return will entitle you to wear a unique helmet?", cid)
		npcHandler.topic[cid] = 4
	elseif msgcontains(msg, "boots") and npcHandler.topic[cid] == 2 then
		npcHandler:say("So you would like to donate 250.000.000 gold pieces which in return will entitle you to wear a unique boots?", cid)
		npcHandler.topic[cid] = 5
	end
end

-- Postman
keywordHandler:addKeyword({'uniforms'}, StdModule.say, {npcHandler = npcHandler, text = 'I remember about those uniforms, they had a camouflage inlay so they could be worn the inside out too. I will send some color samples via mail to Mr. Postner.'},
	function(player) return player:getStorageValue(PlayerStorageKeys.postman.Mission06) == 5 end,
	function(player) player:setStorageValue(PlayerStorageKeys.postman.Mission06, 6) end
)

keywordHandler:addKeyword({'uniforms'}, StdModule.say, {npcHandler = npcHandler, text = 'The uniforms of our guards and soldiers are of unparraleled quality of course.'})

-- Basic
keywordHandler:addKeyword({'subject'}, StdModule.say, {npcHandler = npcHandler, text = 'I am {Queen} Eloise. It is my duty to reign over this marvellous {city} and the {lands} of the north.'})
keywordHandler:addAliasKeyword({'job'})
keywordHandler:addKeyword({'justice'}, StdModule.say, {npcHandler = npcHandler, text = 'We women try to bring justice and wisdom to all, even to males.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I am Queen Eloise. For you it\'s \'My Queen\' or \'Your Majesty\', of course.'})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = 'I don\'t care about gossip like a simpleminded male would do.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'Soon the whole land will be ruled by women at last!'})
keywordHandler:addAliasKeyword({'land'})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank you, I\'m fine.'})
keywordHandler:addKeyword({'castle'}, StdModule.say, {npcHandler = npcHandler, text = 'It\'s my humble domain.'})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, text = 'Sell? Your question shows that you are a typical member of your gender!'})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, text = 'We honor the gods of good in our fair city, especially Crunor, of course.'})
keywordHandler:addKeyword({'citizen'}, StdModule.say, {npcHandler = npcHandler, text = 'All citizens of Carlin are my subjects. I see them more as my childs, though, epecially the male population.'})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = 'This beast scared my cat away on my last diplomatic mission in this filthy town.'})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = 'He is the scourge of the whole continent!'})
keywordHandler:addKeyword({'treasure'}, StdModule.say, {npcHandler = npcHandler, text = 'The royal treasure is hidden beyond the grasps of any thieves by magical means.'})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, text = 'Go and hunt them! For queen and country!'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'Visit the church or the townguards for help.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, text = 'I will call for heroes as soon as the need arises again.'})
keywordHandler:addAliasKeyword({'mission'})
keywordHandler:addKeyword({'gold'}, StdModule.say, {npcHandler = npcHandler, text = 'Our city is rich and prospering.'})
keywordHandler:addAliasKeyword({'money'})
keywordHandler:addAliasKeyword({'tax'})
keywordHandler:addKeyword({'sewer'}, StdModule.say, {npcHandler = npcHandler, text = 'I don\'t want to talk about \'sewers\'.'})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, text = 'Dungeons are places where males crawl around and look for trouble.'})
keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, text = 'Feel free to visit our town\'s magnificent shops.'})
keywordHandler:addAliasKeyword({'food'})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = 'Don\'t worry about time in the presence of your Queen.'})
keywordHandler:addKeyword({'hero'}, StdModule.say, {npcHandler = npcHandler, text = 'We need the assistance of heroes now and then. Even males prove useful now and then.'})
keywordHandler:addAliasKeyword({'adventure'})
keywordHandler:addKeyword({'collector'}, StdModule.say, {npcHandler = npcHandler, text = 'The taxes in Carlin are not high, more a symbol than a sacrifice.'})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the Queen, the only rightful ruler on the continent!'})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = 'Ask one of the soldiers about that.'})
keywordHandler:addKeyword({'enemy'}, StdModule.say, {npcHandler = npcHandler, text = 'Our enemies are numerous. We have to fight vile monsters and have to watch this silly king in the south carefully.'})
keywordHandler:addAliasKeyword({'enemies'})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = 'They dare to reject my reign over them!'})
keywordHandler:addAliasKeyword({'south'})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = 'Isn\'t our city marvellous? Have you noticed the lovely gardens on the roofs?'})
keywordHandler:addAliasKeyword({'city'})
keywordHandler:addKeyword({'shop'}, StdModule.say, {npcHandler = npcHandler, text = 'My subjects maintain many fine shops. Go and have a look at their wares.'})
keywordHandler:addKeyword({'merchant'}, StdModule.say, {npcHandler = npcHandler, text = 'Ask around about them.'})
keywordHandler:addAliasKeyword({'craftsmen'})
keywordHandler:addKeyword({'guild'}, StdModule.say, {npcHandler = npcHandler, text = 'The four major guilds are the Knights, the Paladins, the Druids, and the Sorcerers.'})
keywordHandler:addKeyword({'minotaur'}, StdModule.say, {npcHandler = npcHandler, text = 'They haven\'t troubled our city lately. I guess, they fear the wrath of our druids.'})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, text = 'The paladins are great hunters.'})
keywordHandler:addAliasKeyword({'legola'})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = 'It\'s a shame that the High Paladin does not reside in Carlin.'})
keywordHandler:addKeyword({'knight'}, StdModule.say, {npcHandler = npcHandler, text = 'The knights of Carlin are the bravest.'})
keywordHandler:addAliasKeyword({'trisha'})
keywordHandler:addKeyword({'sorc'}, StdModule.say, {npcHandler = npcHandler, text = 'The sorcerers have a small isle for their guild. So if they blow something up it does not burn the whole city to ruins.'})
keywordHandler:addAliasKeyword({'lea'})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, text = 'The druids of Carlin are our protectors and advisors. Their powers provide us with wealth and food.'})
keywordHandler:addAliasKeyword({'padreia'})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, text = 'Carlin is a center of the forces of good, of course.'})
keywordHandler:addKeyword({'evil'}, StdModule.say, {npcHandler = npcHandler, text = 'The forces of evil have a firm grip on this puny city to the south.'})
keywordHandler:addKeyword({'order'}, StdModule.say, {npcHandler = npcHandler, text = 'The order, Crunor gives the world, is essential for survival.'})
keywordHandler:addKeyword({'chaos'}, StdModule.say, {npcHandler = npcHandler, text = 'Chaos is common in the southern regions, where they allow a man to reign over a realm.'})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = 'A mans tale ... that means \'nonsense\', of course.'})
keywordHandler:addKeyword({'reward'}, StdModule.say, {npcHandler = npcHandler, text = 'If you want a reward, go and bring me something this silly King Tibianus wants dearly!'})
keywordHandler:addKeyword({'tbi'}, StdModule.say, {npcHandler = npcHandler, text = 'A dusgusting organisation, which could be only created by men.'})
keywordHandler:addKeyword({'eremo'}, StdModule.say, {npcHandler = npcHandler, text = 'It is said that he lives on a small island near Edron. Maybe the people there know more about him.'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, 'I greet thee, my loyal {subject}.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Farewell, |PLAYERNAME|!')

local focusModule = FocusModule:new()
focusModule:addGreetMessage('hail queen')
focusModule:addGreetMessage('salutations queen')
npcHandler:addModule(focusModule)
