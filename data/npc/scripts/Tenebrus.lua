local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Basic Keywords
keywordHandler:addKeyword({'hint'}, StdModule.rookgaardHints, {npcHandler = npcHandler})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = 'Time doesn\'t matter to me.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m Tenebrus ex hero.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m a mage.'})
keywordHandler:addKeyword({'mage'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh you want to know more about mages ? well they can use spells on more profitable manner also their effectiveness increases. If you want to become a mage you need to exceel in magic skills'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, text = 'Storage for worldly wealth.'})
keywordHandler:addKeyword({'destiny'}, StdModule.say, {npcHandler = npcHandler, text = 'Well i know it could break your faith but our destiny was ruined by some upper being...'})
keywordHandler:addKeyword({'how', 'are', 'you'}, StdModule.say, {npcHandler = npcHandler, text = 'Thank the gods, I\'m fine.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'What help do you seek? I sell health potions, ask me for a {trade} if you need one.'})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m one of the few magic users on this isle.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'It is shaped by the will of the gods, so we don\'t have to question it.'})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, text = 'I used to be there with my old friend Cipfried to heal adventurers. After all these years, I prefer solitude now.'})
keywordHandler:addKeyword({'library'}, StdModule.say, {npcHandler = npcHandler, text = 'The library is in the {academy}, north of the {temple}.'})
keywordHandler:addKeyword({'academy'}, StdModule.say, {npcHandler = npcHandler, text = 'A place to learn about {Tibia}.'})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, text = 'Are you hungry? I\'m sorry, I have no food here.'})
keywordHandler:addKeyword({'potion'}, StdModule.say, {npcHandler = npcHandler, text = 'Yes, I sell health and mana potions. Ask me for a {trade} if you need one.'})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, text = 'The dungeons are dangerous for inexperienced adventurers.'})

keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'Just ask me for a {trade} to check out my offers. I have only small health potions for sale, though.'})
keywordHandler:addAliasKeyword({'stuff'})
keywordHandler:addAliasKeyword({'wares'})
keywordHandler:addAliasKeyword({'buy'})
keywordHandler:addAliasKeyword({'sell'})

keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, text = 'You\'ll have to buy that from the merchants in town. I\'m just a simple druid and healer.'})
keywordHandler:addAliasKeyword({'rope'})
keywordHandler:addAliasKeyword({'backpack'})
keywordHandler:addAliasKeyword({'shovel'})
keywordHandler:addAliasKeyword({'shield'})
keywordHandler:addAliasKeyword({'armor'})
keywordHandler:addAliasKeyword({'helmet'})

keywordHandler:addKeyword({'deposit'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'ll pay you 5 gold for every empty vial and potion flask. Just ask me for a {trade}.'})
keywordHandler:addAliasKeyword({'flask'})
keywordHandler:addAliasKeyword({'vial'})

-- Names
keywordHandler:addKeyword({'obi'}, StdModule.say, {npcHandler = npcHandler, text = 'A greedy and annoying person just like most people are.'})
keywordHandler:addKeyword({'norma'}, StdModule.say, {npcHandler = npcHandler, text = 'Now she has completely gotten out of her mind.'})
keywordHandler:addKeyword({'loui'}, StdModule.say, {npcHandler = npcHandler, text = 'He was a promising young druid when something happened to his mind. It\'s a sad story.'})
keywordHandler:addKeyword({'santiago'}, StdModule.say, {npcHandler = npcHandler, text = 'He does a good job out there.'})
keywordHandler:addKeyword({'zirella'}, StdModule.say, {npcHandler = npcHandler, text = 'I know her since she was little.'})
keywordHandler:addKeyword({'al', 'dee'}, StdModule.say, {npcHandler = npcHandler, text = 'One of these greedy merchants.'})
keywordHandler:addKeyword({'amber'}, StdModule.say, {npcHandler = npcHandler, text = 'I saw her stranding with her raft.'})
keywordHandler:addKeyword({'billy'}, StdModule.say, {npcHandler = npcHandler, text = 'He\'s a farmer and behaves a little better than his cousin.'})
keywordHandler:addKeyword({'willie'}, StdModule.say, {npcHandler = npcHandler, text = 'An unpleasant person.'})
keywordHandler:addKeyword({'cipfried'}, StdModule.say, {npcHandler = npcHandler, text = 'His healing powers equal mine.'})
keywordHandler:addKeyword({'dixi'}, StdModule.say, {npcHandler = npcHandler, text = 'I think she\'s under bad influence.'})
keywordHandler:addKeyword({'hyacinth'}, StdModule.say, {npcHandler = npcHandler, text = 'That\'s my name.'})
keywordHandler:addKeyword({'lee\'delle'}, StdModule.say, {npcHandler = npcHandler, text = 'She\'s actually quite nice.'})
keywordHandler:addKeyword({'lily'}, StdModule.say, {npcHandler = npcHandler, text = 'She\'s a druid. Since she started selling health potions, people visit me only rarely. Which is a good thing, but of course I\'ll help if I\'m needed.'})
keywordHandler:addKeyword({'oracle'}, StdModule.say, {npcHandler = npcHandler, text = 'The oracle will lead you to your {destiny} once you are level 8.'})
keywordHandler:addKeyword({'paulie'}, StdModule.say, {npcHandler = npcHandler, text = 'I think that guy is new. He\'s a {bank} clerk.'})
keywordHandler:addKeyword({'seymour'}, StdModule.say, {npcHandler = npcHandler, text = 'He has some inner devils that torture him.'})
keywordHandler:addKeyword({'tom'}, StdModule.say, {npcHandler = npcHandler, text = 'Tom is the local tanner. That means he always needs fresh corpses or leather.'})
keywordHandler:addKeyword({'dallheim'}, StdModule.say, {npcHandler = npcHandler, text = 'A man of the sword.'})
keywordHandler:addAliasKeyword({'zerbrus'})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'See you then.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Bless you on your journeys.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Here you go. Don\'t forget, if you buy potions, there\'s a {deposit} of 5 gold on the empty flask.')
npcHandler:setMessage(MESSAGE_GREET, 'Greetings, traveller |PLAYERNAME|. As you have found me in this depths of books, how can i {help} you ?')


local booksByType = {
    ["attack"] = 1955,
    ["healing"] = 1960,
    ["support"] = 1959,
    ["runeMaking"] = 1958,
    ["conjure"] = 1958,
    ["enchant"] = 1958
}

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    if msgcontains(msg, 'trade') or msgcontains(msg, 'spells') then

        local shopWindow = {}
        
        local spells = {}
        local index = 1
        for var, item in pairs(GameConfig.BuySpellsList) do
            local magiclevel = item.magiclevel or 0
            local level = item.level or 0
            local skill_closeCombat = item.meelelevel or 0
            local skill_distance = item.distlevel or 0

            shopWindow[index] = {Level = level, MLevel = magiclevel, CLevel = skill_closeCombat, DLevel = skill_distance, Price = item.price, Words = item.words, SpellName = item.name}
            
            table.insert(spells, {id=booksByType[item.group], subType=index, buy = item.price, name = item.words, spell = item.name, vocations = {0,1,2,3,4,5,6,7,8}, level = level})
            print(booksByType[item.group] .. " - " .. index .. " " .. item.words)
            index = index + 1
        end


    
        local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
            print(item .. " " .. subType)
            --print(shopWindow[subType].name)
            -- if not getPlayerLearnedInstantSpell(cid, shopWindow[item].Words) then
            --     if getPlayerLevel(cid) >= shopWindow[item].Level then
            --         if isInArray(shopWindow[item].Vocs, getPlayerVocation(cid)) then
            --             doPlayerRemoveMoney(cid, shopWindow[item].Price)
            --             doPlayerLearnInstantSpell(cid, shopWindow[item].Words)
            --             npcHandler:say("You have learned " .. shopWindow[item].Words, cid)
            --         else
            --             npcHandler:say("This spell is not for your vocation.", cid)
            --         end
            --     else
            --         npcHandler:say("You need to obtain a level of " .. shopWindow[item].Level .. " or higher to be able to learn this spell.", cid)
            --     end
            -- else
            --     npcHandler:say("You already know this spell.", cid)
            -- end
                

            return true
        end
        openShopWindow(cid, spells, onBuy, onSell)
        return true
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
