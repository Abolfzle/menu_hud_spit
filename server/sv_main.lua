
local Tunnel = module("ANCH", "lib/Tunnel")
local Proxy = module("ANCH", "lib/Proxy")

vRP = Proxy.getInterface("ANCH")
vRPclient = Tunnel.getInterface("ANCH","vrp_rent")
vRPCrent = Tunnel.getInterface("vrp_rent","vrp_rent")
vRPrent = {}
Tunnel.bindInterface("vrp_rent",vRPrent)
Proxy.addInterface("vrp_rent",vRPrent)

VehiclesRented = {}


RegisterServerEvent("fizzfau-rental:rent")
AddEventHandler("fizzfau-rental:rent", function(k, v, plate, store)
    local identifier = vRP.getUserId({source})
    if VehiclesRented[identifier] == nil then
        VehiclesRented[identifier] = {
            plate = plate,
            time = os.time(),
            max_time = v.max_time * 60 * 60 * 1000,
            price = v.price,
            store = store
        }
        TriggerClientEvent("fizzfau-rental:spawnVehicle", source, k, v, plate)
        TriggerEvent("fizzfau-rental:startCounter", player)
    else
        TriggerClientEvent("notification", source, "Aveți deja un vehicul închiriat, livrați-l mai întâi!")
    end
end)

RegisterServerEvent("fizzfau-rental:giveback")
AddEventHandler("fizzfau-rental:giveback", function(health)
    local identifier = vRP.getUserId({source})
    if VehiclesRented[identifier] ~= nil then
        TriggerClientEvent("fizzfau-rental:delete", source, VehiclesRented[identifier].vehicle)
        if health < 1000 then
            vRP.tryFullPayment({identifier,Config.Fee * (1000 - health)/100})
        elseif os.time() - VehiclesRented[identifier].time > VehiclesRented[identifier].max_time then
            player.removeMoney(Config.Fee * max_time)
            vRP.tryFullPayment({identifier,Config.Fee * max_time})
        end
        VehiclesRented[identifier] = nil
    end
end)

RegisterServerEvent("fizzfau-rental:update")
AddEventHandler("fizzfau-rental:update", function(vehicle, bool)
    local identifier = vRP.getUserId({source})
    if bool then
        VehiclesRented[identifier] = nil
        return
    end
    VehiclesRented[identifier].vehicle = vehicle    
end)

RegisterServerEvent("fizzfau-rental:getVehicle")
AddEventHandler("fizzfau-rental:getVehicle", function()
    local identifier = vRP.getUserId({source})
    if VehiclesRented[identifier] ~= nil then
        TriggerClientEvent("fizzfau-rental:client:getVehicle", source, VehiclesRented[identifier].vehicle)
    end
end)

RegisterServerEvent("fizzfau-rental:startCounter")
AddEventHandler("fizzfau-rental:startCounter", function(player)
    local identifier = vRP.getUserId({source})
    Citizen.CreateThread(function()
        while true do
            if VehiclesRented[identifier] ~= nil then
                if player then
                    local cash = vRP.getMoney({user_id})
                    local bank = player.getAccount("bank").money
                    vRP.tryFullPayment({identifier,VehiclesRented[identifier].price})
                end
            else
                break
            end
            Citizen.Wait(60*60*1000)
        end
    end)
end)
