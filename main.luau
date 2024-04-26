local function chat(msg)
    game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
end

local function connectPlayer(plr)
    local money = 75
    local chanceSize = 16
    local BuyChanceRequest = false
    
    plr.Chatted:Connect(function(msg)
        if msg == "+gamble" then
            local getGamble = math.random(0, chanceSize)
            local trueGamble = math.modf(getGamble-(chanceSize/2))
            
            warn(plr.Name.." gambled "..trueGamble.." money with "..chanceSize.." chances.")
            
            money = (money+trueGamble)
            
            if trueGamble > 0 then
                if math.random(0,1000) == 500 then
                    chat("[🔷] Jackpot!! 1 in 1000 chances! You've got 1000 money! Incredible!")
                    money = (1000-trueGamble)
                else
                    chat("[🔷] Nice! You've got "..trueGamble.." money!")
                end
            elseif trueGamble < 0 then
                if money >= 0 then
                    chat("[🔷] Yikes! You've lost "..trueGamble.." money!")
                else
                    chat("[🔷] Game over! You went broke!")
                    plr.Chatted:Disconnect()
                end
            else
                chat("[🔷] Oops! You've got no money at all!")
            end
        elseif msg == "+buychance" then
            if not BuyChanceRequest then
                BuyChanceRequest = true
                chat("[🔶] Do you want to buy some chances for 15 money? (adds +2)")
                wait(3)
                chat("[🔶] Say +acceptbuy to confirm! Or if you don't want to, say +denybuy!")
            else
                chat("[🔶] I'm already waiting!")
            end
        elseif msg == "+acceptbuy" then
            if BuyChanceRequest then
                if (money-15) > (-1) then
                    money = (money-15)
                    chanceSize = (chanceSize+4)
                    BuyChanceRequest = false
                
                    chat("[🔶] Purchase was successful! Come back later!")
                else
                    BuyChanceRequest = false
                    
                    chat("[🔶] Oh, I'm sorry! You don't have enough money! Come back later!")
                end
            else
                chat("[🔶] You need to say +buychance first!")
            end
        elseif msg == "+declinebuy" then
            if BuyChanceRequest then
                BuyChanceRequest= false
                
                chat("[🔶] Well, alright! Come back later!")
            else
                chat("[🔶] You need to say +buychance first!")
            end
        elseif msg == "+balance" then
            chat("[🔷] You have: "..money.." money, and "..(chanceSize/2).." chances.")
        elseif msg == "+cmds" then
            chat("[🔷] Available commands: +gamble, +balance, +buychance, +info, +cmds, +getscript")
        elseif msg == "+info" then
            chat("[🔷] Welcome to Gamble X, where you gamble, gamble and gamble! This game is still in beta! Version: v0000")
        elseif msg == "+getscript" then
            chat("[🔷] On GittyHubby, /IvanTheProtogen/GambleX/blob/main/main.luau")
        end
    end)
end

for _0000_, player in game:GetService('Players'):GetPlayers() do
    connectPlayer(player)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    connectPlayer(player)
end)

chat("[🔷] Welcome to Gamble X! A game, where you gamble money! Say +cmds to get started!")
