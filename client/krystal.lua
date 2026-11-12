-- Krystal Casino (was dps-krystal-casino): hides NoPixel's "coming soon" sign on the entrance
-- (nopixel-casino, nve_pixelarea_strm_1.ymap) with CreateModelHide; NoPixel's escrowed files are not touched.
-- The way in and out is rcore_casino's own teleport (EnterCheckpointPosition / LeavePosition in rcore_casino/config.lua).
local SIGN = {
    model  = `lnrxvn_casino_entrance_sign`,
    coords = vec3(-150.76, -1073.38, 27.99),
    radius = 3.0,
}

local function hideSign()
    CreateModelHide(SIGN.coords.x, SIGN.coords.y, SIGN.coords.z, SIGN.radius, SIGN.model, true)
end

CreateThread(hideSign)

AddEventHandler('onClientResourceStart', function(resource)
    -- re-apply if the map streams in after us (e.g. nopixel-casino restarted)
    if resource == 'nopixel-casino' then hideSign() end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        RemoveModelHide(SIGN.coords.x, SIGN.coords.y, SIGN.coords.z, SIGN.radius, SIGN.model, false)
    end
end)
