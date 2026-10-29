local settings = require 'shared.settings'
local nextRequestAt = 0

-- Fehlende Streaming-Assets dürfen den Interaktions-Thread nicht beenden.
function MurphyTextureReady()
    local loaded = HasStreamedTextureDictLoaded(settings.Style)
    if loaded == true or loaded == 1 then return true end
    local now = GetGameTimer()
    if now >= nextRequestAt then
        nextRequestAt = now + 1000
        RequestStreamedTextureDict(settings.Style, true)
    end
    return false
end

CreateThread(function()
    local startedAt = GetGameTimer()
    local warned = false
    while true do
        local ready = MurphyTextureReady()
        if not ready and not warned and GetGameTimer() - startedAt >= 30000 then
            warned = true
            print(('[murphy_interact] Textur %s noch nicht geladen; erneuter Versuch im Hintergrund.'):format(settings.Style))
        end
        Wait(1000)
    end
end)
