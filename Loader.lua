-- Loader script cho Delta X
-- Chỉ cần đổi <USERNAME> và <REPO> thành GitHub của bạn

local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/<USERNAME>/<REPO>/main/main.lua"))()
end)

if not success then
    warn("[Loader Error]: "..tostring(err))
end
