--[[
61283655 --Trickstar Candina
91505214 --Trickstar Narkissus
35199656 --Trickstar Lycoris
98700941 --Trickstar Lilybell
22219822 --Trickstar Mandrake
98169343 --Trickstar Carobein
14558127 --Ash Blossom
59438930 --Ghost Ogre
94145021 --Droll
63845230 --Eater of Millions
73628505 --Terraforming
22159429 --Magicorolla
35371948 --Light Stage
54447022 --Soul Charge
83764718 --Monster Reborn
43898403 --Twin Twisters
73915051 --Scapegoat
21076084 --Reincarnation
40605147 --Solemn Strike

#extra
31833038 --Borreload
5043010 --Firewall
65330383 --Troymare Gryphoon
30194529 --Ningirsu
3792766 --Delfiendium
38342335 --Unicorn
86750474 --Foxy Witch
32448765 --Holly Angel
2857636 --Troymare Phoenix
75452921 --Troymare Cerberus
3987233 --Missus radiant
22862454 --Proxy Dragon
41999284 --Linkuriboh

]]
function TrickstarsStartup(deck) --Initializing the deck
AI.Chat("AI_Trickstars v0.1")
AI.Chat("Scripted by Naim Santos")
  deck.Init                 = TrickstarsInit  --function that holds commands to be performed during the main phases, in a open game state
  deck.ActivateBlacklist    = TrickstarsActivateBlacklist --matrix with cards that will never be activated/chained by the generic AI, unless a function is defined
  deck.SummonBlacklist      = TrickstarsSummonBlacklist --matrix with cards that will never be Summoned by the generic AI, unless a function is defined
  deck.PriorityList         = TrickstarsPriorityList --matrix with priorities for card. Check description in the function
  deck.Card                 = TrickstarsCard
  deck.Chain                = TrickstarsChain  --function that decides if a card should be chained and when to chain
  deck.Unchainable          = TrickstarsUnchainable --matrix with cards that will never be chained by the generic AI, unless defined in TrickstarsChain
  deck.SetBlacklist         = TrickstarsSetBlacklist --matrix with cards that will never be set by the generic AI
  deck.EffectYesNo          = TrickstarsEffectYesNo --called when an effect makes the AI choose Y/N (like adding a card to hand via Light Stage)
  deck.Position             = TrickstarsPosition   --called when the Ai has to decide which position to summon a monster
end
TrickstarsIdentifier = 98169343 -- Trickstar Carobein
DECK_Trickstars = NewDeck("Trickstars_Burn",TrickstarsIdentifier,TrickstarsStartup)

function TrickstarsInit(cards)
	local Act = cards.activatable_cards
	local Sum = cards.summonable_cards
	local SpSum = cards.spsummonable_cards
	local Rep = cards.repositionable_cards
	local SetMon = cards.monster_setable_cards
	local SetST = cards.st_setable_cards
	--MP= main phase
	if HasIDNotNegated(Act,73628505,UseTerra) then ---using Terraforming (MP)
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,35371948,UseLightStage,1) then --Light Stage from hand
	GlobalCardMode = 1
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,35371948,UseLightStage,2) then --Light Stage from field (targeting a face-down S/T)
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Act,35371948,UseLightStage,3) then --Light Stage (if it's facedown for some reason)
	GlobalCardMode = 1
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Sum,61283655,SummonCandina,1) then --Normal Summon Candina
		return COMMAND_SUMMON,CurrentIndex
	end
	if HasIDNotNegated(Act,35199656,ActivateLyco,1) then --Activating Lycos effect (Chain Link 1)
		return COMMAND_ACTIVATE,CurrentIndex
	end
	if HasIDNotNegated(Sum,98700941,SummonLily,1) then --Normal Summon Lily
		return COMMAND_SUMMON,CurrentIndex
	end
	if HasIDNotNegated(Sum,35199656,SummonLyco,1) then --Normal Summon Lyco
		return COMMAND_SUMMON,CurrentIndex
	end
end

TrickstarsActivateBlacklist={
61283655, --Trickstar Candina
91505214, --Trickstar Narkissus
35199656, --Trickstar Lycoris
98700941, --Trickstar Lilybell
22219822, --Trickstar Mandrake
98169343, --Trickstar Carobein
14558127, --Ash Blossom
59438930, --Ghost Ogre
94145021, --Droll
63845230, --Eater of Millions
73628505, --Terraforming
22159429, --Magicorolla
35371948, --Light Stage
54447022, --Soul Charge
83764718, --Monster Reborn
43898403, --Twin Twisters
73915051, --Scapegoat
21076084, --Reincarnation
40605147, --Solemn Strike
}
TrickstarsSummonBlacklist={
61283655, --Trickstar Candina
91505214, --Trickstar Narkissus
35199656, --Trickstar Lycoris
98700941, --Trickstar Lilybell
22219822, --Trickstar Mandrake
98169343, --Trickstar Carobein
14558127, --Ash Blossom
59438930, --Ghost Ogre
94145021, --Droll
63845230, --Eater of Millions

31833038, --Borreload
5043010, --Firewall
65330383, --Troymare Gryphoon
30194529, --Ningirsu
3792766, --Delfiendium
38342335, --Unicorn
86750474, --Foxy Witch
32448765, --Holly Angel
2857636, --Troymare Phoenix
75452921, --Troymare Cerberus
3987233, --Missus radiant
22862454, --Proxy Dragon
41999284, --Linkuriboh
}
TrickstarsUnchainable={
91505214 --Trickstar Narkissus
35199656 --Trickstar Lycoris
98169343 --Trickstar Carobein
14558127 --Ash Blossom
59438930 --Ghost Ogre
94145021 --Droll
63845230 --Eater of Millions
22159429 --Magicorolla
43898403 --Twin Twisters
73915051 --Scapegoat
21076084 --Reincarnation
40605147 --Solemn Strike
}
TrickstarsSetBlacklist={
43898403, --Twin Twisters
73915051, --Scapegoat
21076084, --Reincarnation
40605147, --Solemn Strike
}

function TrickstarsPosition(id,available)
	local battletargets = OppMon() --i took this for Majespecters, i suppose. It's used in CanWinBattle but i need a function with battle commands @_@
	local result --this will hold the position the monster should be summoned on
	if id==35199656 then --TRICKSTAR LYCO
		if Duel.GetTurnPlayer()==player_ai then --AI's turn
			if Duel.GetTurnCount()==1
			then 
			result=POS_FACEUP_ATTACK
			elseif CanWinBattle(c,battletargets) then --can win battle
			result=POS_FACEUP_ATTACK
			elseif CardsMatchingFilter(OppMon())==0 then --no monsters
			result=POS_FACEUP_ATTACK
			else
			result=POS_FACEUP_DEFENSE
			end
			else  --OPPONENT's turn
			if Duel.GetCurrentPhase()>PHASE_BATTLE then --Battle phase has passed
			result=POS_FACEUP_ATTACK
			else
			result=POS_FACEUP_DEFENSE
			end
		end
	elseif  id==98700941 then --TRICKSTAR LILYBELL
		if Duel.GetTurnPlayer()==player_ai then --AI's turn
			if Duel.GetCurrentPhase()<PHASE_MAIN2 and GlobalBPAllowed --can still have battle
			then
			result=POS_FACEUP_ATTACK
			else
			result=POS_FACEUP_DEFENSE
			end
		else 	--OPPONENT's turn
			if Duel.GetCurrentPhase()<PHASE_MAIN2 then --opponent can still battle
			result=POS_FACEUP_DEFENSE
			else
			result=POS_FACEUP_ATTACK
			end
		end
	elseif  id==61283655 then --TRICKSTAR CANDINA
		if Duel.GetTurnPlayer()==player_ai then  --AI's turn
			if Duel.GetTurnCount()==1 --turn 1, for pressure XD
			then 
			result=POS_FACEUP_ATTACK
			elseif CanWinBattle(c,battletargets) then 
			result=POS_FACEUP_ATTACK
			elseif CardsMatchingFilter(OppMon())==0 then --no monsters
			result=POS_FACEUP_ATTACK
			end
		else		--OPPONENT's turn
			if  Duel.GetCurrentPhase()>PHASE_BATTLE then
			result=POS_FACEUP_ATTACK
			elseif OppHasFaceupMonster(1800) then --to see if opponent has a monster with ATK >= Candina's
			result=POS_FACEUP_ATTACK
			else
			result=POS_FACEUP_DEFENSE
			end
		end
	end
	return result
end

function TrickstarsChain(cards)
	if HasIDNotNegated(cards,35199656,LycoChain,1) then
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,21076084,ReincarnationRegular) then --general usage of Reincarnation
	GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,21076084,ReincarnationGraveChain) then --Using Reincarnation from the graveyard
	GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,94145021,DrollRegularChain) then --droll regular
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
	if HasIDNotNegated(cards,21076084,ReincarnationInitializateDroll) then --initial reincarnation in Droll Reincarnation combo
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,21076084,ReincarnationCL1Droll) then --second reincarnation in the Droll Reincarnation combo
		GlobalCardMode = 1
		return {1,CurrentIndex}
	end
	if HasIDNotNegated(cards,94145021,DrollForReincarnation) then --Droll in the Droll Reincarnation combo
		GlobalCardMode = 1
		return {1,CurrentIndex}	
	end
	
end

function TrickstarsEffectYesNo(id,card)
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
function UsableSetReincarnation(c)
	return c.id==21076084 and FilterLocation(c,LOCATION_SZONE) and not FilterStatus(c,STATUS_SET_TURN)
end
function ReincarnationRegular(c)
	if FilterLocation(c,LOCATION_GRAVE) then return false
	else
	return UnchainableCheck(21076084)
	and (Duel.GetCurrentPhase()==PHASE_STANDBY	and CardsMatchingFilter(AIMon(),FilterID,35199656)>0) --lycos no campo
	or RemovalCheck(21076084)
	--and not ReincarnationForDroll()
	end
end
function ReincarnationGraveChain(c)
	if FilterLocation(c,LOCATION_GRAVE) then
	Debug.Message("ReincarnationNo Grave: okay")
		if	UnchainableCheck(21076084) then
				if RemovalCheck(21076084) then
					Debug.Message("Reincar grave: removalcheck")
					return true
				elseif	Duel.GetTurnPlayer()==1-player_ai then --OPPONENT'S TURN
						if Duel.GetCurrentPhase()==PHASE_BATTLE
						or Duel.GetCurrentPhase()==PHASE_END
						then
						return true	end
				else--AI'S TURN
						return NormalSummonCount(player_ai)>0 and Duel.GetCurrentPhase()<PHASE_MAIN2 and (HasID(AIHand(),35199656,true) or 
						(CardsMatchingFilter(AIGrave(),FilterID,61283655)>1 and HasID(AIGrave(),98700941,true)))
						--or CardsMatchingFilter(OppMon())==0 and Duel.GetCurrentPhase()==PHASE_BATTLE
				end
		end
	else return false --if it's not in the graveyard, it will not activate
	end
end
function DrollRegularChain()
	if
	UnchainableCheck(94145021) and	Duel.GetTurnPlayer()==1-player_ai and (not HasID(AIST(),74519184,true))
	--only activates droll if it's not the AI's turn and hand destruction is not set
	and not DrollForReincarnation()
	then	return true
	end
	--	and HasID(AIHand(),35371948,true) --se Droll está na mao
end
function ReincarnationSameChain()
  local e
  for i=1,Duel.GetCurrentChain() do
    e = Duel.GetChainInfo(i, CHAININFO_TRIGGERING_EFFECT)
    if e and e:GetHandler():GetCode()==21076084 then
	 return true
	end
  end
 return false
end
function ReincarnationInitializateDroll(c)
if FilterLocation(c,LOCATION_GRAVE) then return false
	else
local e
	if (Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()==1-player_ai) and --OPPONENT'S TURN
	HasID(AIHand(),94145021,true) and CardsMatchingFilter(AIST(),UsableSetReincarnation)>1
	and not ReincarnationSameChain()
	then return true
	end
end
end
function ReincarnationCL1Droll(c)
	if FilterLocation(c,LOCATION_GRAVE) then return false
	else
	if (Duel.GetCurrentPhase()~=PHASE_DRAW and Duel.GetTurnPlayer()==1-player_ai) and not ReincarnationSameChain()
	and Duel.CheckEvent(EVENT_TO_HAND)
	-- and HasID(AIHand(),94145021,true)
	 then return true
	 end
	end
end
function DrollForReincarnation()
	if ReincarnationSameChain() then
	return true
	else return false
end
end
--the 4 functions above handle Droll Reincarnation loop
--But the chain link order is wrong


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
function SummonCandina()
return true
end
function SummonLyco()
	if	(HasID(AIHand(),61283655,true) --candina in hand
	or HasID(AIHand(),98700941,true)) --lily in hand
	then return false
	else return true
	end
end
function SummonLily()
	return HasID(AIHand(),61283655,false) --candina in hand
	and CardsMatchingFilter(AIGrave(),FilterID,35199656)>0 --lyco in the graveyard
	or (CardsMatchingFilter(AIGrave(),FilterID,61283655)>0 --candina in the grave + normal summons (usually due to Chain summoning)
	and NormalSummonCount(player_ai)>0)
end

function UseLightStage(c,mode)
  if mode == 1 -- activate from hand
  and FilterLocation(c,LOCATION_HAND)
  and not HasIDNotNegated(AIST(),c.id,true)
  then
    return true
  end
  if mode == 2 -- activate on field
  and FilterLocation(c,LOCATION_ONFIELD) 
  and FilterPosition(c,POS_FACEUP)
  then
    return true
  end
  if mode == 3 -- activate face-down
  and FilterLocation(c,LOCATION_ONFIELD) 
  and FilterPosition(c,POS_FACEDOWN)
  then
    return true
  end
end

function UseReincarnationOrDisturbance()
local ncardsdraw=CardsMatchingFilter(OppHand())
return (ncardsdraw*LycoDamage() + LightStageDamage() >= AI.GetPlayerLP(2))
end

function UseTerra()
	return true
end

function ActivateLyco(c,mode)
	if mode == 1 then
		return NormalSummonCount(player_ai)>0
		or Duel.GetTurnCount()==1
	end
end

function TrickstarsCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard)
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

function LycoDamage()
	return CardsMatchingFilter(AIMon(),FilterID,35199656)*200
	--number of lycos * 200: I use this to calculate damage.
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
TrickstarsPriorityList={
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
If the condition is meet, it will be 4

--]]
[61283655] = {7,4,9,4,1,1,1,1,1,1,CandinaCond}, --Candina
[35199656] = {8,5,7,3,1,1,1,1,1,1,LycoCond}, --Lycoris
[98700941] = {9,3,8,2,1,1,1,1,1,1,LilyCond}, --Lilybell
[35371948] = {9,1,1,1,1,1,1,1,1,1,LightStageCond}, --Lightstage
[21076084] = {1,1,1,1,1,1,1,1,1,1,nil}, --Reincarnation

[14558127] = {1,1,1,1,6,6,1,1,1,1,nil}, --Ash Blossom
[59438930] = {1,1,1,1,6,6,1,1,1,1,nil}, --Ghost Ogre
[94145021] = {1,1,1,1,1,1,1,1,1,1,nil}, --Droll & Lock

[12580477] = {1,1,1,1,1,1,1,1,1,1,nil}, --Raigeki
[73628505] = {1,1,1,1,1,1,1,1,1,1,nil}, --Terraforming
[08267140] = {1,1,1,1,1,1,1,1,1,1,nil}, --Cosmic Cyclone
[74519184] = {1,1,1,1,1,1,1,1,1,1,nil}, --Hand Destruction
[85562745] = {1,1,1,1,1,1,1,1,1,1,nil}, --Dark Room of Nightmare
[09952083] = {1,1,1,1,1,1,1,1,1,1,nil}, --Chain Summoning

[36468556] = {1,1,1,1,1,1,1,1,1,1,nil}, --Ceasefire
[77561728] = {1,1,1,1,1,1,1,1,1,1,nil}, --Disturbance Strategy
[40605147] = {1,1,1,1,1,1,1,1,1,1,nil}, --Solemn Strike

}
