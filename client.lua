---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
local display = true



vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","vrp_hud")
vRPhud = Tunnel.getInterface("vrp_hud","vrp_hud")
vRPhudC = {}
Tunnel.bindInterface("vrp_hud",vRPhudC)
vRPserver = Tunnel.getInterface("vrp_hud","vrp_hud")

local hudInchis = false
local isPauseMenu = false
local display = false

CreateThread(function()
    while true do 
        Wait(2000)
        if hudInchis == false and not isPauseMenu then
            vRPserver.getInfoAboutHud({})
        end
    end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)

		if IsPauseMenuActive() then
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
                SendNUIMessage({ action = 'hud', value = 'none' })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
                SendNUIMessage({ action = 'hud', value = 'block' })
			end
		end
	end
end)

paydaytimer = "00:00"
Citizen.CreateThread(function()
    while true do
        vRPserver.getPayDayTimer({}, function(payDay)
            paydaytimer = payDay
            payday = true
            SendNUIMessage({payday = paydaytimer})
            vRPserver.getPlayerDiamonds({},function(Diamante)
                print(Diamante)
                SendNUIMessage({action="test", shopbalance = Diamante})
                --SendNUIMessage({shopbalance = Diamante})
            end)
        end)
        Wait(1000)
    end
end)

function comma_value(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function vRPhudC.startMisiune(statement,date)
	if statement then
        if date then
            SendNUIMessage({
                action = "mission",
                value = "block",
                misiune = date
            })
        else
            SendNUIMessage({
                action = "mission",
                value = "none",
                misiune = ""
            })
        end
	else
        SendNUIMessage({
            action = "mission",
            value = "none",
            misiune = ""
        })
	end
end

numele = "Expirat"
phoneJucator = "Expirat"
function vRPhudC.sendDetails(statement,firstname,name,phone)
	if statement then
        numele = firstname.. " " ..name
        phoneJucator = phone
	else
        numele = "Expirat"
        phoneJucator = "Expirat"
	end
end

function vRPhudC.sendInformationsAboutHud(id,users,maxSlots,money,bankmoney,diamante,nume,factiune,rank,ore,vip,group,onlines, slots,staff)
    SendNUIMessage({
        action = "deschideHud",
        id = id,
        users = users,
        maxslots = maxSlots,
        nume = nume,
        factiune = factiune,
        rank = rank,
        slots = slots,
        ore = ore,
        vip = vip,
        group = group,
        onlines = onlines,
        staff = staff,
        voicechat = NetworkIsPlayerTalking(PlayerId()),
        money = comma_value(money),
        bankmoney = comma_value(bankmoney),
        diamante = comma_value(diamante),
        nameIG = numele,
        number = phoneJucator
    })
end

text = ""
amount = 0
function vRPhudC.paydayDetails(statement,text,amount)
	if statement then
        SendNUIMessage({
            action = "paydayDetails",
            textPayday = text,
            amount = amount
        })
        SendNUIMessage({
            action = "paydaySound"
        })
	else
        SendNUIMessage({
            action = "paydayDetails",
            textPayday = "",
            amount = 0
        })
	end
end

local minutesJ = 0
function vRPhudC.setMinutes(minutesJail, text, staffMember)
    minutesJ = minutesJail
    SendNUIMessage({
        action = "jail",
        minutes = minutesJail,
        motiv = text,
        staff = staffMember
    })
end

function vRPhudC.showJail(statement,text,staffMember)
	if statement then
        SendNUIMessage({
            action = "jail",
            stil = "block",
            minutes = minutesJ,
            motiv = text,
            staff = staffMember
        })
	else
        SendNUIMessage({
            action = "jail",
            stil = "none",
            motiv = "",
            minutes = 0,
            staff = ""
        })
	end
end

local tickets = 0
function vRPhudC.setTickets(amm)
    tickets = amm
end

function vRPhudC.setAdmin()
    Citizen.CreateThread(function()
        while true do
            SendNUIMessage({
                action = "tryTicket",
                stil = "block",
                tickete = string.format("%02d Tickete", tickets)
            })
            Wait(1000)
        end
    end)
end

inSafeZone = false
safeZone = nil
local CreateThread = Citizen.CreateThread
local safeZones = { 
    ['Showroom'] = {pos = vector3(-248.40342712402,6211.6528320313,31.938980102539),radius = 40.0},
    ['Spawn'] = {pos = vector3(-2225.0561523438,-623.34692382813,15.615658760071),radius = 75.0},
    ['Constructor'] = {pos = vector3(-139.75268554688,-990.61962890625,27.275220870972),radius = 65.0},
    ['Spawn2Yacht'] = {pos = vector3(-2335.40625,-658.41363525391,13.416130065918),radius = 75.0},
    ['Spital'] = {pos = vector3(315.89944458008,-593.17785644531,57.726112365723),radius = 50.0},
    ['Showroom Audi'] = {pos = vector3(-43.705089569092,-1097.9987792969,35.18578338623),radius = 50.0},
    ['Showroom Aston Martin'] = {pos = vector3(-278.91171264648,-2669.0063476563,15.584763526917),radius = 50.0},
    ['Showroom General'] = {pos = vector3(-798.45837402344,-219.20243835449,57.537887573242),radius = 50.0},
    ['CNN'] = {pos = vector3(-601.64636230469,-923.64892578125,36.833541870117),radius = 30.0},
}

local aparut = false

CreateThread(function()
    CreateThread(function()
        local ticks = 500
        while true do
            local ped = PlayerPedId()

            if (inSafeZone) then
                ticks = 1
                if aparut == false then
                aparut = true
                    SendNUIMessage({
                    action = "safezone",
                    stil = 'block'
                    })
                end
    
                DisableControlAction(0,24,true)
                DisableControlAction(0,25,true)
                DisableControlAction(0,47,true)
                DisableControlAction(0,58,true)
                DisableControlAction(0,263,true)
                DisableControlAction(0,264,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,140,true)
                DisableControlAction(0,141,true)
                DisableControlAction(0,142,true)
                DisableControlAction(0,143,true)
    
                SetEntityInvincible(ped, true)
                SetEntityInvincible(PlayerId(), true)
                ResetPedVisibleDamage(ped)
                ClearPedBloodDamage(ped)
                SetEntityCanBeDamaged(ped, false)
                NetworkSetFriendlyFireOption(false)
            else
        if aparut == true then
          aparut = false
            SendNUIMessage({
              action = "safezone",
              stil = 'none'
            })
        end
                ticks = 500
                SetEntityInvincible(ped, false)
                SetEntityInvincible(PlayerId(), false)
                SetEntityCanBeDamaged(ped, true)
                NetworkSetFriendlyFireOption(true)
            end
            Wait(ticks)
            ticks = 500
        end
    end)
    while true do
        Wait(500)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for key,value in pairs(safeZones) do
            pos = value.pos
            radius = value.radius
            if #(coords - pos) < radius then
                inSafeZone = true
                safeZone = key
            end
        end
        if safeZone ~= nil then
            pos = safeZones[safeZone].pos
            radius = safeZones[safeZone].radius
            if #(pos - coords) > radius then
                inSafeZone = false
                safeZone = nil
            end
        end
    end
end) 

Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    while true do
        Citizen.Wait(300)
        local playerID = PlayerId()

        for _,player in ipairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(player)

            if player ~= playerID then
                if boolTalking then
                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                elseif not boolTalking then
                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                end
            end
            SendNUIMessage({
                action = "voicechat",
                toggle = boolTalking
            })
        end
    end
end)

toggleD = 0
RegisterCommand('hud', function()
    if toggleD == 0 then
        toggleD = 1 
    elseif toggleD == 1 then
        toggleD = 0
    end
    if toggleD == 1 then
        SendNUIMessage({action = 'comenzi', value = 'none'})
    elseif toggleD == 0 then
        SendNUIMessage({action = 'comenzi', value = 'block'})
    end
end)

-- toggleC = false
-- RegisterCommand('cod', function()
--     if toggleC == false then
--         toggleC = true
--     elseif toggleC == true then
--         toggleC = false
--     end
--     if toggleC == true then
--         SendNUIMessage({action = 'codRadioTEXT', value = 'none'})
--     elseif toggleC == false then
--         SendNUIMessage({action = 'codRadioTEXT', value = 'block'})
--     end
-- end)

CreateThread(function()
    while true do
        if IsControlJustPressed(0, 243) then
            SendNUIMessage({action = 'test', stil = "block"})
            SetNuiFocus(true, true)

        end
        Wait(1)
    end
end)

local display = false

CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustPressed(0, 243) then
            SetDisplay(not display)
        end
    end
end)

RegisterNUICallback("exitcacat", function(data)
    SetNuiFocus(false)
    DisplayRadar(true)
end)

RegisterNUICallback('cumparaStarterPack', function(data, cb)
    vRPserver.cumparaStarterPack({})
end)


RegisterNUICallback('cumparaGold', function(data, cb)
    vRPserver.cumparaGold({})
end)



RegisterNUICallback('callMedics', function(data, cb)
    vRPserver.callMedics({})
end)

RegisterNUICallback('sunaPolice', function(data, cb)
    vRPserver.sunaPolice({})
end)


RegisterNUICallback('sunaTaxi', function(data, cb)
    vRPserver.sunaTaxi({})
end)

RegisterNUICallback("exit", function(data)
    SendNUIMessage({action = 'test', stil = "none", text = ""})
    SetDisplay(false)
    DisplayRadar(true)
end)

RegisterNUICallback("main", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        ------ spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

isDead = false
respawnTime = 120
medics = 0
respawned = false

Citizen.CreateThread(function()
    wTime = 1000
	while true do
		local ped = GetPlayerPed(-1)
    
		local health = GetEntityHealth(ped)
		if (health <= 120)then
            wTime = 250
			vRPserver.getOnlineMedics({}, function(onlineMedics)
				medics = onlineMedics
			end)
                wTime = 250
				isDead = true
                SendNUIMessage({
                    action = "respawn",
                    stil = "block",
                    text = respawnTime
                })
            -- if(medics > 0)then
                -- wTime = 1
            if IsControlJustPressed(0, 38) then
                if(medics > 0)then
                    local coords = GetEntityCoords(PlayerPedId())
                    vRPserver.callMedics({coords.x,coords.y,coords.z})
                else
                    --vRP.notify({"No medics"})
                    exports['h-notif']:send('fa fa-exclamation-circle', 'error', 'Nu sunt medici online', 'top-center', 3000)
                end   
			end
		else
			isDead = false
			respawnTime = 120
            SendNUIMessage({
                action = "respawn",
                stil = "none",
                text = respawnTime
            })
		end
        if(respawnTime == 0)then
            wTime = 250
			isDead = false
			vRP.killComa({})
			respawnTime = 120
		end
        Citizen.Wait(wTime)
        wTime = 1000
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1600)
		if(respawnTime <= 120) and (respawnTime > 0) and (isDead)then
			respawnTime = respawnTime - 1
		end
	end
end)

local greenZones = {
    {pos = vector3(-2216.2104492188,-622.81268310547,15.044717788696), width = 100.0, height = 355.0, rot = 496},
    {pos = vector3(-149.07395935059,-1027.3874511719,24.36137008667), width = 195.0, height = 130.0, rot = 251},
    {pos = vector3(2946.3310546875,2788.9396972656,40.407691955566), width = 130.0, height = 135.0, rot = 130},
    {pos = vector3(-447.45950317382,6009.6860351562,42.350147247314), width = 20.0, height = 40.0, rot = 225},
    {pos = vector3(-1587.1923828125,4909.4267578125,64.487594604492), width = 140.0, height = 40.0, rot = 225},    
    {pos = vector3(1947.6429443359,3830.1437988281,32.442974090576), width = 90.0, height = 90.0, rot = 210},       
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local plyPos = GetEntityCoords(GetPlayerPed(-1))
        for _, zone in pairs(greenZones) do

            local dst = (IsPauseMenuActive() and 0.0) or GetDistanceBetweenCoords(plyPos, zone.pos, false)
            local minDst = math.max(zone.width, zone.height) + 10.0
            if not zone.blip and dst <= minDst then
                zone.blip = AddBlipForArea(zone.pos, zone.width, zone.height)
                SetBlipRotation(zone.blip, zone.rot)
                SetBlipColour(zone.blip, 69)
                SetBlipAlpha(zone.blip, 100)
            elseif dst > minDst then
                RemoveBlip(zone.blip)
                zone.blip = nil
            end

        end
    end
end)
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord
---- spit developer  # spit    https://discord.gg/rVcdM3hPPv  discord

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6000)
        TriggerServerEvent('checkEmergencyTime')
    end
end)
local ACTIVE = false
local ACTIVE_EMERGENCY_PERSONNEL = {}
RegisterNetEvent("eblips:toggle")
AddEventHandler("eblips:toggle", function(on)
	ACTIVE = on
	if not ACTIVE then
		RemoveAnyExistingEmergencyBlips()
	end
end)

RegisterNetEvent("eblips:updateAll")
AddEventHandler("eblips:updateAll", function(personnel)
	ACTIVE_EMERGENCY_PERSONNEL = personnel
end)

RegisterNetEvent("eblips:update")
AddEventHandler("eblips:update", function(person)
	ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
end)

RegisterNetEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	RemoveAnyExistingEmergencyBlipsById(src)
end)

function RemoveAnyExistingEmergencyBlips()
	for src, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(src)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			ACTIVE_EMERGENCY_PERSONNEL[src] = nil
		end
	end
end

function RemoveAnyExistingEmergencyBlipsById(id)
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(id)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			ACTIVE_EMERGENCY_PERSONNEL[id] = nil
		end
end

Citizen.CreateThread(function()
	while true do
		if ACTIVE then
			for src, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
				local player = GetPlayerFromServerId(src)
				local ped = GetPlayerPed(player)
				if GetPlayerPed(-1) ~= ped then
					if GetBlipFromEntity(ped) == 0 then
						local blip = AddBlipForEntity(ped)
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, info.color)
						SetBlipAsShortRange(blip, true)
						SetBlipDisplay(blip, 4)
						SetBlipShowCone(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(info.name)
						EndTextCommandSetBlipName(blip)
					end
				end
			end
		end
		Wait(0)
	end
end)

