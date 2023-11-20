---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
local Tunnel = module("ANCH", "lib/Tunnel")
local Proxy = module("ANCH", "lib/Proxy")

vRP = Proxy.getInterface("ANCH")
vRPclient = Tunnel.getInterface("ANCH","vrp_hud")
vRPChud = Tunnel.getInterface("vrp_hud","vrp_hud")
vRPhud = {}
Tunnel.bindInterface("vrp_hud",vRPhud)
Proxy.addInterface("vrp_hud",vRPhud)

function vRPhud.cumparaStarterPack()
    local user_id = vRP.getUserId({source})
    if user_id then

    end
end

 
function vRPhud.cumparaGold(index,price)
    local user_id = vRP.getUserId({source})
    if user_id then
        if vRP.isUserBronzeVip({user_id}) then 
        end
    end
end


vRPhud.getPlayerDiamonds = function()
    local user_id = vRP.getUserId({source})
    if user_id then
        return vRP.getDiamante{user_id}
    end
end

function vRPhud.getInfoAboutHud()
    thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    local player = vRP.getUserSource({user_id})
    if user_id ~= nil then
        local money = vRP.getMoney({user_id})
        local bankmoney = vRP.getBankMoney({user_id})
        local diamante = vRP.getDiamante({user_id})
        local useriOn = vRP.getUsers({user_id})
        local factiune = vRP.getUserFaction({user_id})
        local rank = vRP.getFactionRank({user_id})
        local ore = vRP.getUserHoursPlayed({user_id})
        local vip = vRP.isUserVip({user_id})
        local group = vRP.getUserGroupByType({user_id,"job"})
        local onlines = vRP.getOnlineUsersByFaction({user_id})
        local slots = vRP.getFactionSlots({user_id})
        local staff = vRP.getUserAdminLevel({user_id})
        id = user_id
        users = #useriOn
        countJucatori = 0
        for k,v in pairs(useriOn) do
            countJucatori = countJucatori + 1
        end        
        vRPChud.sendInformationsAboutHud(source,{id,countJucatori,maxSlots,money,bankmoney,diamante,GetPlayerName(source),factiune,rank,ore,vip,group,onlines,slots,staff})
    end
end

local minute = 29
local secunde = 60
local totalmin = 29
local totalsec = 60
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 
        zero = 0
        secunde = secunde - 1
        totalsec = secunde
        if secunde < 10 then
            totalsec = "0"..totalsec
        end
        if secunde == 0 then
            secunde = 60
            minute = minute -1
            totalmin = minute
            if minute == 0  then
                minute = 29
                secunde = 60
                doPayDay()
            end
        end
    end
end)

function vRPhud.getPayDayTimer()
    if totalmin < 10  then
        return "0"..minute..":"..secunde
    else
        return ""..minute..":"..secunde
    end
end

function doPayDay()
    local users = vRP.getUsers({})
    for i, v in pairs(users)do
        user_id = i
        player = vRP.getUserSource({user_id})
        if player then
            factionPayday = 0
            jobPayday = 0
            theFaction = ""
            pictura = "CHAR_BANK_FLEECA"
            titlu = "Season Flecca"
            mesaj = "Ai primit salariul ~g~$"
            if(vRP.hasUserFaction({user_id}))then
                theFaction = vRP.getUserFaction({user_id}) or "" 
                vipCuaie = vRP.isUserVip({user_id}) or ""                                       
                theRank = vRP.getFactionRank({user_id}) or ""
                thePay = vRP.getFactionRankSalary({theFaction, theRank}) or 100
                if(thePay > 0)then
                    factionPayday = thePay
                end
            end
            if(factionPayday > 0)then
                vRP.giveBankMoney({user_id, factionPayday})
                vRPChud.paydayDetails(player, {true, 'AI PRIMIT SALARIUL'})
            end
            -- # PAYDAY [ VIP ONLY ]    
            if vRP.isUserBronzeVip({user_id}) then
                vRP.giveBankMoney({user_id,1250})
                vRPChud.paydayDetails(player, {true, 'AI PRIMIT SALARIUL',3000})
            end

            if vRP.isUserSilverVip({user_id}) then
                vRP.giveBankMoney({user_id,1250})
                vRPChud.paydayDetails(player, {true, 'AI PRIMIT SALARIUL',3000})
            end
            if vRP.isUserGoldVip({user_id}) then
                vRP.giveBankMoney({user_id,2000})
                vRPChud.paydayDetails(player, {true, 'AI PRIMIT SALARIUL',4000})
            end
            if vRP.isUserDiamondVip({user_id}) then
                vRP.giveBankMoney({user_id,3000})
                vRPChud.paydayDetails(player, {true, 'AI PRIMIT SALARIUL',4000})
            end
            if vRP.isUserEmeraldVip({user_id}) then
                vRP.giveBankMoney({user_id,4500})
                vRPChud.paydayDetails(player, {true, 'AI PRIMIT SALARIUL',13500})
            end
            -- # PAYDAY [ VIP ONLY ]       
   
        end
    end
end


-- PENTRU MEDICI SA APARA PE MINIMAPA
local ACTIVE_EMERGENCY_PERSONNEL = {}
RegisterServerEvent("eblips:add")
AddEventHandler("eblips:add", function(person)
	ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
	for k, v in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		TriggerClientEvent("eblips:updateAll", -1, ACTIVE_EMERGENCY_PERSONNEL)
	end
    TriggerClientEvent("eblips:toggle", -1, true)
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	ACTIVE_EMERGENCY_PERSONNEL[src] = nil
	for k, v in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		TriggerClientEvent("eblips:remove", -1, src)
	end
	TriggerClientEvent("eblips:toggle", -1, false)
end)

AddEventHandler("playerDropped", function()
	if ACTIVE_EMERGENCY_PERSONNEL[source] then
		ACTIVE_EMERGENCY_PERSONNEL[source] = nil
	end
end)

RegisterServerEvent('checkEmergencyTime')
AddEventHandler('checkEmergencyTime', function()
	local user_id = vRP.getUserId({source})
    thePlayer = vRP.getUserSource({user_id})
    theMedics = vRP.getOnlineUsersByFaction({"EMS"})
    for k,v in pairs(theMedics) do
        sourcePlayer = vRP.getUserSource({v})
        TriggerEvent("eblips:add", {src = sourcePlayer, name = GetPlayerName(sourcePlayer), color = 1})
    end
    if not vRP.isUserInFaction({user_id, "EMS"}) then
        TriggerEvent("eblips:remove", source)
    end
end)

---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord

---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord


function vRPhud.getOnlineMedics()
	theMedics = vRP.getOnlineUsersByFaction({"EMS"})
	--print(#theMedics)
	return #theMedics
end

called = {}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10*5000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
            if(called[i] == 1)then
                called[i] = nil
                TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'info', 'Acum poti suna iara la medic', 'mid-left', 4000)
            end
		end
	end
end)

function vRPhud.callMedics(x,y,z)
    local user_id = vRP.getUserId({source})
    if called[user_id] == 1 then
        TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'error', 'Nu poti suna iara', 'mid-left', 4000)
    else
    vRP.sendServiceAlert({source, "EMS",x,y,z,"Un om este ranit"})
        called[user_id] = 1
    end
end


called = {}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10*5000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
            if(called[i] == 1)then
                called[i] = nil
                TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'info', 'Acum poti suna iara la medic', 'mid-left', 4000)
            end
		end
	end
end)

--------------------


function vRPhud.getOnlineMedici()
	theMedic = vRP.getOnlineUsersByFaction({"EMS"})
	--print(#theMedics)
	return #theMedic
end

sunaMedic = {}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
            if(sunaMedic[i] == 1)then
                sunaMedic[i] = nil
                TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'info', 'Acum poti face un alt apel catre ambulanta', 'mid-left', 4000)
            end
		end
	end
end)

function vRPhud.sunaMedic(x,y,z)
    local user_id = vRP.getUserId({source})
    if sunaMedic[user_id] == 1 then
        TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'error', 'Poti face un alt apel peste un minut', 'mid-left', 4000)
    else
    vRP.sendServiceAlert({source, "EMS",x,y,z,""})
    sunaMedic[user_id] = 1
    end
end

---------------------- meidic in sus ------------------



function vRPhud.getOnlineTaxi()
	theTaxi = vRP.getOnlineUsersByFaction({"LSPD"})
	--print(#theMedics)
	return #theTaxi
end

sunataxi = {}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
            if(sunataxi[i] == 1)then
                sunataxi[i] = nil
                TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'info', 'Acum poti face un alt apel catre agentia de taxi', 'mid-left', 4000)
            end
		end
	end
end)
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord

function vRPhud.sunaTaxi(x,y,z)
    local user_id = vRP.getUserId({source})
    if sunataxi[user_id] == 1 then
        TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'error', 'Poti face un alt apel peste un minut', 'mid-left', 4000)
    else
    vRP.sendServiceAlert({source, "LSPD",x,y,z,""})
    sunataxi[user_id] = 1
    end
end



---------------------------- taxi in sus ------------------------------


function vRPhud.getOnlinePolice(x,y,x)
	theLspd = vRP.getOnlineUsersByFaction({"Politie"})
	--print(#theMedics)
	return #theLspd
end

sunaPolice = {}
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
            if(sunaPolice[i] == 1)then
                sunaPolice[i] = nil
                sunaPolice("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'info', 'Acum poti face un alt apel catre politie', 'mid-left', 4000)
            end
		end
	end
end)

function vRPhud.sunaPolice(x,y,z)
    local user_id = vRP.getUserId({source})
    if sunaPolice[user_id] == 1 then
        TriggerClientEvent("H-Notif:SendNotification", thePlayer, 'fas fa-cog', 'error', 'Poti face un alt apel peste un minut', 'mid-left', 4000)
    else
    vRP.sendServiceAlert({source, "Politie",x,y,z,""})
    sunaPolice[user_id] = 1
    end
end


---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
-------- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord



AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
    local target = vRP.getUserSource({user_id})
    SetTimeout(1000,function()
        if vRP.isUserTrialHelper({user_id}) then
            vRPChud.setAdmin(source, {})
            --  vRPhud.spawnTickets()
        end
    end)
end)


---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord