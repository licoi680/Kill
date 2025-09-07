-- ========== Kill Aura ==========
local killAuraOn = false
local range = 20
local maxTargets = 3
local attackSpeed = 0.5 -- giây

-- Nút bật Kill Aura
local auraBtn = Instance.new("TextButton", Frame)
auraBtn.Size = UDim2.new(1,-20,0,30)
auraBtn.Position = UDim2.new(0,10,0,60)
auraBtn.Text = "Kill Aura: OFF"
auraBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
auraBtn.TextColor3 = Color3.new(1,1,1)

-- Nhãn thông số
local infoLabel = Instance.new("TextLabel", Frame)
infoLabel.Size = UDim2.new(1,-20,0,60)
infoLabel.Position = UDim2.new(0,10,0,100)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.new(1,1,1)
infoLabel.TextWrapped = true
infoLabel.Text = "Range: "..range.."\nMaxTargets: "..maxTargets.."\nAttackSpeed: "..attackSpeed

local function updateInfo()
    infoLabel.Text = "Range: "..range.."\nMaxTargets: "..maxTargets.."\nAttackSpeed: "..attackSpeed
end

-- Toggle Aura
auraBtn.MouseButton1Click:Connect(function()
    killAuraOn = not killAuraOn
    auraBtn.Text = killAuraOn and "Kill Aura: ON" or "Kill Aura: OFF"

    if killAuraOn then
        spawn(function()
            while killAuraOn do
                task.wait(attackSpeed)

                local humrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not humrp then continue end

                local count = 0
                for _, mob in ipairs(workspace:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                        local dist = (mob.HumanoidRootPart.Position - humrp.Position).Magnitude
                        if dist <= range and mob.Humanoid.Health > 0 then
                            -- Giả lập đánh (bạn cần thay bằng remote đúng của game)
                            mob.Humanoid:TakeDamage(10)

                            count += 1
                            if count >= maxTargets then break end
                        end
                    end
                end
            end
        end)
    end
end)

-- Phím tắt chỉnh nhanh (Z = giảm Range, X = tăng Range, C/V = MaxTargets, B/N = AttackSpeed)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X then range = range + 5 updateInfo() end
    if input.KeyCode == Enum.KeyCode.Z then range = math.max(5, range - 5) updateInfo() end
    if input.KeyCode == Enum.KeyCode.C then maxTargets = maxTargets + 1 updateInfo() end
    if input.KeyCode == Enum.KeyCode.V then maxTargets = math.max(1, maxTargets - 1) updateInfo() end
    if input.KeyCode == Enum.KeyCode.B then attackSpeed = math.max(0.1, attackSpeed - 0.1) updateInfo() end
    if input.KeyCode == Enum.KeyCode.N then attackSpeed = attackSpeed + 0.1 updateInfo() end
end)
