--[[ Cards used in this deck:
33015627	---Sandaion
7733560	--Michion
34137269	--Hailon
60222213	--Raphion
91712985	--Kamion
92435533	--Lazion

13893596	--Exodious
27107590	--Time Maiden

14558127	--Ash Blossom
59438930	--Ghost ogre

2295440	--One for One
34236961	--Ante
51630558	--Advanced Draw
28890974	--Celestial Transformation
43898403	--Twin Twisters

10045474	--Infinite Impermenance
40605147	--Solemn Strike
41420027	--Solemn Warning
#extra
62541668	--Number 77
26556950	--Number 84
66523544	--Superdimensional RObot Galaxy Destroyer
3814632	--Skypalace Gandaridai
49032236	--Number 81
56910167	--Gustav Max
90162951	--Number 35
31833038	--Borreload
85289965	--Borrelsword
1861629	--Decode
41999284	--Linkuriboh

]]
function TimelordStartup(deck) --Initializing the deck
AI.Chat("AI_Timelords v0.1")
AI.Chat("Scripted by Naim Santos")
  deck.Init                 = TimelordInit
  deck.ActivateBlacklist    = TimelordActivateBlacklist
  deck.SummonBlacklist      = TimelordSummonBlacklist
  deck.PriorityList         = TimelordPriorityList
  deck.Card                 = TimelordCard
  deck.Unchainable          = TimelordUnchainable
  deck.SetBlacklist         = TimelordSetBlacklist
  deck.Chain                = TimelordChain
-- deck.ChainOrder           = TimelordChainOrder --Not implemented (i need to find a way to finish Droll+Reincarnation loop)
-- deck.BattleCommand        = TimelordBattleCommands --não implementada corretamente
--  deck.EffectYesNo          = TimelordYesNo --called when an effect makes the AI choose Y/N
deck.Position             = TimelordPosition   --called when the Ai has to decide which position to summon a monster
end
TimelordIdentifier = 7733560 -- Michion the Timelord
DECK_Timelord = NewDeck("Timelord",TimelordIdentifier,TimelordStartup)

function TimelordInit(cards)
	local Act = cards.activatable_cards
	local Sum = cards.summonable_cards
	local SpSum = cards.spsummonable_cards
	local Rep = cards.repositionable_cards
	local SetMon = cards.monster_setable_cards
	local SetST = cards.st_setable_cards
	--During main phase, the AI tries to activate the following cards.
	if HasIDNotNegated(Act,2295440,Use141) then --using One for One)
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,34236961,UseAnte) then
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasID(SpSum,27107590) and SummonMaiden(1) then
		return {COMMAND_SPECIAL_SUMMON,CurrentIndex}
  end
	
end

TimelordActivateBlacklist={
33015627,	---Sandaion
7733560,	--Michion
34137269,	--Hailon
60222213,	--Raphion
91712985,	--Kamion
92435533,	--Lazion
13893596,	--Exodious
14558127,	--Ash Blossom
59438930,	--Ghost ogre
27107590,	--Time Maiden
2295440,	--One for One
34236961,	--Ante
51630558,	--Advanced Draw
28890974,	--Celestial Transformation
43898403,	--Twin Twisters
10045474,	--Infinite Impermenance
40605147,	--Solemn Strike
41420027,	--Solemn Warning
}
TimelordSummonBlacklist={
27107590,	--Time Maiden

13893596,	--Exodious
14558127,	--Ash Blossom
59438930,	--Ghost ogre

62541668,	--Number 77
26556950,	--Number 84
66523544,	--Superdimensional RObot Galaxy Destroyer
3814632,	--Skypalace Gandaridai
49032236,	--Number 81
56910167,	--Gustav Max
90162951,	--Number 35
31833038,	--Borreload
85289965,	--Borrelsword
1861629,	--Decode
41999284,	--Linkuriboh
}
TimelordUnchainable={
14558127,	--Ash Blossom
59438930,	--Ghost ogre
}
TimelordSetBlacklist={
14558127,	--Ash Blossom
59438930,	--Ghost ogre
27107590,	--Time Maiden
2295440,	--One for One
34236961,	--Ante
51630558,	--Advanced Draw
28890974,	--Celestial Transformation
43898403,	--Twin Twisters
10045474,	--Infinite Impermenance
40605147,	--Solemn Strike
41420027,	--Solemn Warning
}

function TimelordPosition(id,available)
	local battletargets = OppMon() --i took this for Majespecters, i suppose. It's used in CanWinBattle but i need a funnction with battle commands @_@
	local result --this will hold the position the monster should be summoned on
	if id==35199656 then
		result=POS_FACEUP_DEFENSE
	end
	return result
end

function TimelordBattleCommands(cards,activatable) --it's disabled, because i don't know how to use it. sorry
  for i=1,#cards do
    cards[i].index = i
  end
  local targets = OppMon()  --what are the targets
  local attackable = {}		--initial
  local mustattack = {} 	--initial
	for i=1,#targets do
		if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then --can be attacked
		attackable[#attackable+1]=targets[i]
		end
		if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then --must be attacked
		mustattack[#mustattack+1]=targets[i]
		end
	end
	if #mustattack>0 then
		targets = mustattack
	else
		targets = attackable
  end
  if CanWinBattle(cards[CurrentIndex],targets,true,false) then
    return Attack(IndexByID(cards))
  end
  return nil
end

function TimelordChain(cards)
	if HasIDNotNegated(cards,35199656,LycoChain,1) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,59438930,GhostOgreChain) then --needs improvement (a table, maybe?)
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
	if HasIDNotNegated(cards,14558127,AshBlossomChain) then --same
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
end
TimelordChainlinks={
21076084, --Reincarnation
94145021, --Droll
}

function TimelordChainOrder(TimelordChainlinks) --wrong, i should disable it for now
end

function TimelordYesNo(id,card)
  local result
	if id==61283655 then
		GlobalCardMode = 1
		return 1 --yes
	end
	if id==35371948 then
		GlobalCardMode = 1
		return 1
	end
	if id==98700941 then
	OPTSet(98700941) --defines that Lily's OPT effect is being used
		GlobalCardMode = 1
		return 1
		--end
	end	
end
function LycoChain()
	if	Duel.GetTurnCount()==1 and Duel.GetCurrentPhase()==PHASE_END then
	--turn 1
		return true
	end
	if RemovalCheck(61283655) then
	--if Candina is leaving the field
	return true
	end
	if Duel.GetTurnPlayer()==player_ai and Duel.GetCurrentPhase()==PHASE_MAIN2 then
	--if Battle phase has passed
			if (HasID(AIMon(),61283655,true) and CardsMatchingFilter(AIHand(),FilterID,35199656)>2)
					--if there is a candina on field + 2 lycos in hand
					or
					(HasID(AIMon(),61283655,true) and CardsMatchingFilter(AIHand(),FilterID,35199656)>0 and HasID(AIST(),35371948,true))
					--if there is 1 candina on the field + 1 lyco AND lighstage on the field
					then return true
			end
	end
	if Duel.GetCurrentPhase()==PHASE_MAIN1 then
			local e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
		if e and e:GetHandler():GetCode()==09952083
		--if chain summoning was activated in this chain linck, chains Lyco
			then return true
		end
	end
	if Duel.GetTurnPlayer()==player_ai or Duel.GetTurnPlayer()==1-player_ai then 
		local e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
		if e and e:GetHandler():GetCode()==35199656
		--if lyco was activated, chain another lyco
			then return true
		end
	end
return false
end

function AshBlossomChain()
--This works checking the chain links in a chain using the "for" loop
--If any of the chain links fullflis the condition, it returns true to chain Ash
--I'm using e:GetHandlerPlayer()==1-player_ai because i want to negate opponent's effects
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandlerPlayer()==1-player_ai and	UnchainableCheck(74519184) then
	--GetHandler():GetCode()==  can be used to check for a Card's ID
	 return true
	end
  end
 return false
end
function GhostOgreChain()
--same as Ash Blossom
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandlerPlayer()==1-player_ai and	UnchainableCheck(59438930) then
	 return true
	end
  end
 return false
end

function Use141()
	return NormalSummonCount(player_ai)>0
	and CardsMatchingFilter(AIHand(),FilterID,27107590)==0
end
function UseAnte()
	return CardsMatchingFilter(AIHand(),Level10Filter)>0
end
function Level10Filter(c)
--used for Ante, mainly
  return c.level==10
end
function SummonMaiden(mode)
  if mode == 1 and #AIMon()==0)
	then	return true
  return false
end
function UseRaigeki()
	return true
end

function TimelordCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard)
  if id == 61283655 then --Candina
    return CandinaTarget(cards)
  end
   if id == 35371948 then --Lighstage
    return LightStageTarget(cards)
  end
   if id == 21076084 then --Reincarnation
    return  ReincarnationGraveTargets(cards) --needs improvements in the conditions
  end
    if id == 98700941 then --Lily
    return LilyGraveTargets(cards)
  end
    if id == 35199656 then --Licorys
    return LycoTargets(cards)
  end
 return nil
end
function CandinaAddPriority(card) --Picks which card Candina should add
--the priority will always be the highest return value found
	local id=card.id
		if id==35199656 then --LYCORIS
		return 7
		--usually adds Lyco
		end
		if id==98700941 then --LILYBELL
			if CardsMatchingFilter(AIGrave(),FilterID,35199656)>1 then
			return 8
			--lilybell, if there are at least 2 lycos in the graveyard
			else
			return 5
			end--]]
		end
		if id==35371948 then --LIGHT STAGE
			if HasID(UseLists({AIST(),AIHand()}),35371948,true) then
				return 6
				--if there is a lightstage, lower priority than lyco
			else
				return 10
			--No lighstage in hand/field, lightstage has a higher priority
			end
		end
		if id==61283655 then --CANDINA
			return 1
		end
		if id==21076084 then --Reincarnation
			if (CardsMatchingFilter(AICards(),FilterID,35199656)>1 and HasID(AICards(),35371948,true)) then
				--reincarnation, if lycos and light stage are in the hand/fields
				return 11
			else
				return 4
			end
		end
		
return GetPriority(card,PRIO_TOHAND)
end
function CandinaAddAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_HAND then
    func = CandinaAddPriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end
function CandinaAdd(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  CandinaAddAssignPriority(cards,LOCATION_HAND)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end
function CandinaTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return CandinaAdd(cards,1)
  else
   return Add(cards,PRIO_TOHAND)
  end
end
--these 3 functions above change the way priority is assigned
--So i can handle Candina individually instead of using the PriorityList matrix


function LightStageAddPriority(card) --Picks which card LIGHT STAGE should add
	local id=card.id
		if id==61283655 then
			if not HasID(UseLists({AIMon(),AIHand()}),61283655,true) then
			--Lighstage adds candina
				return 10
			else
				return 4
			end
		end
		if id==35199656 then
			if (CardsMatchingFilter(AIHand(),FilterID,35199656)>1 and  HasID(UseLists({AIMon(),AIHand()}),61283655,true)) then
				--if more than 1 Lyco in hand and has Candina, adds Lyco
				return 11
			elseif  (not (CardsMatchingFilter(AIHand(),FilterID,35199656)>=0)) and HasID(UseLists({AIMon(),AIHand()}),61283655,true) then
				--if has a Candina, but no lyco, adds lyco
				return 9
			else
				return 7
			end
		end
		if id==98700941 then
			if CardsMatchingFilter(AIGrave(),FilterID,35199656)>0 then
			--lilybell, if a Lyco is in the graveyard
				return 10
			elseif CardsMatchingFilter(AIGrave(),TrickstarFilterM)>0 then
				--lilybell, if a trickstar monster is on the graveard
				return 6
			else
				return 5
			end
		end
return GetPriority(card,PRIO_TOHAND)
end
function LightStageAddAssignPriority(cards,toLocation)
  local func = nil
  if toLocation==LOCATION_HAND then
    func = LightStageAddPriority
  end
  for i=1,#cards do
    cards[i].priority=func(cards[i])
  end
end
function LightStageAdd(cards,amount)
  local result = {}
  for i=1,#cards do
    cards[i].index=i
  end
  LightStageAddAssignPriority(cards,LOCATION_HAND)
  table.sort(cards,function(a,b) return a.priority>b.priority end)
  for i=1,amount do
    result[i]=cards[i].index
  end
  return result
end
function LightStageTarget(cards)
  if GlobalCardMode == 1 then
    GlobalCardMode = nil
    return LightStageAdd(cards,1)
  else
   return Add(cards,PRIO_TOHAND)
  end
  --this one is usuless since i'm being handled the same way as Candina
end
--thise functions refer to the PriorityList matrix:
function ReincarnationGraveTargets(cards)
	return Add(cards,PRIO_TOFIELD)
end
function LycoTargets(cards)
	if LocCheck(cards,LOCATION_MZONE)  then
	return Add(cards,PRIO_TOHAND)
	end
	return Add(cards,PRIO_TOHAND)
end
function LilyGraveTargets(cards)
	if LocCheck(cards,LOCATION_GRAVE)  then
	return Add(cards,PRIO_TOHAND)
	end
	return Add(cards,PRIO_TOHAND)
end
--------------------

function TrickstarFilterM(c)
  return IsSetCode(c.setcode,0xfb) and bit32.band(c.type,TYPE_MONSTER)>0
end
function TrickstarFilterAll(c)
  return IsSetCode(c.setcode,0xfb)
end
function CeasefireFilter(c)
	return  bit32.band(c.type,TYPE_MONSTER+TYPE_EFFECT)
end
function CeasefireDamage()
	return
	AI.GetPlayerLP(2) <= CardsMatchingFilter(AllMon(),CeasefireFilter)*500
		--checks for Ceasifire's Damage
	or
	AI.GetPlayerLP(2) <= (CardsMatchingFilter(AIST(),FilterID,85562745)*300 + CardsMatchingFilter(Field(),CeasefireFilter)*500)
		--If there is dark room, evaluates the combined damage
end

function LycoDamage()
	return CardsMatchingFilter(AIMon(),FilterID,35199656)*200 --number of lycos * 200: I use this to calculate damage.
																--just have to multiply the cards drawn. Check UseHandDes

end
function LightStageDamage()
	if HasIDNotNegated(AIST(),35371948,true) then --lighstage on the field
	return	CardsMatchingFilter(AIMon(),FilterID,35199656)*200
	else return 0
	end
end
--my priority function for the matrix below
function LycoCond(loc,c)
	if loc == PRIO_TOHAND then
		if FilterLocation(c,LOCATION_GRAVE) then
			return HasID(AIMon(),61283655,true) or (HasID(AIMon(),98700941,true) and not OPTCheck(98700941))
		end
	end
	if	loc == PRIO_TOFIELD then
		if FilterLocation(c,LOCATION_GRAVE) then
			return CardsMatchingFilter(AIMon(),FilterID,35199656)>1
		end
	end
end
function CandinaCond(loc,c)
	if loc == PRIO_TOHAND then
		if FilterLocation(c,LOCATION_GRAVE) then
			return NormalSummonCount(player_ai)>0
		end
	end
	if loc == PRIO_TOFIELD then
			if FilterLocation(c,LOCATION_GRAVE) then
				return HasID(AIHand(),35199656,true)
				or OppHasFaceupMonster(1800)
				or AI.GetPlayerLP(2) <= 1800
		end
	end
end
function LilyCond(loc,c)
	if loc == PRIO_TOHAND then
		return not OPTCheck(98700941)
	end
	if loc == PRIO_TOFIELD then
		if FilterLocation(c,LOCATION_GRAVE) then
			return CardsMatchingFilter(AIGrave(),TrickstarFilterM)>1
		end 
	end
end
function LightStageCond(loc)
  if loc == PRIO_HAND then
	if FilterLocation(c,LOCATION_DECK) then
	return true
	end
end
end
TimelordPriorityList={
--[[it took me sometime to get this working but it goes like this:
SYNTAX:[CardId]={hand,hand+,field,field+,grave,grave+,somewhereelse,somewhereelse,banished,banished+,XXXCondition}
Locations are handled in pairs
1 & 2 = PRIO_TOHAND
3 & 4 = PRIO_TOFIELD
5 & 6 = PRIO_TOGRAVE
7 & 8 = PRIO_... (it's not certain)
9 & 10 = PRIO_TOBANISHED

If no XXXCondition is given (or nil), it always return the first of those two priorities for a given location
if the XXXCondition fails it also returns the first of the two
But if the condition is fulfilled it returns the second value.
Example: if my CandinaCond fails, the priority to add candina to HAND will be 7
If the condition is met, it will be 4

--]]
[33015627] = {7,4,9,4,1,1,1,1,1,1,CandinaCond}, --Sandaion
[7733560] = {8,5,7,3,1,1,1,1,1,1,LycoCond}, --Michion
[34137269] = {9,3,8,2,1,1,1,1,1,1,LilyCond}, --Hailon
[60222213] = {9,1,1,1,1,1,1,1,1,1,LightStageCond}, --Raphion
[91712985] = {1,1,1,1,1,1,1,1,1,1,nil}, --Kamion
[92435533] = {1,1,1,1,1,1,1,1,1,1,nil}, --Lazion


[14558127] = {1,1,1,1,6,6,1,1,1,1,nil}, --Ash Blossom
[59438930] = {1,1,1,1,6,6,1,1,1,1,nil}, --Ghost Ogre

[40605147] = {1,1,1,1,1,1,1,1,1,1,nil}, --Solemn Strike

}
