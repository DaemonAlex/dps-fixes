-- DPS manual recovery: clears a stuck menu/NUI focus and unfreezes the player.
-- Press F10 (rebindable in Settings > Key Bindings > FiveM) or type /unstick.
local function unstick()
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    local ped = PlayerPedId()
    if ped and ped ~= 0 then
        FreezeEntityPosition(ped, false)
        SetPlayerControl(PlayerId(), true, 0)
    end
end

RegisterCommand('unstick', unstick, false)
RegisterKeyMapping('unstick', 'Unstick: release stuck menu focus / unfreeze', 'keyboard', 'F10')

-- DPS 2026-10-28 (Damon): while any NUI app has focus (DPS Studio, fleet, tow, city worker...),
-- Esc belongs to the app and never opens the pause menu. Held 500 ms past the close too, so the
-- Esc press that closes an app does not fall through to the game.
CreateThread(function()
    local holdUntil = 0
    while true do
        local now = GetGameTimer()
        if IsNuiFocused() then holdUntil = now + 500 end
        if now < holdUntil then
            DisableControlAction(0, 199, true); DisableControlAction(0, 200, true); DisableControlAction(0, 322, true)
            Wait(0)
        else
            Wait(100)
        end
    end
end)
