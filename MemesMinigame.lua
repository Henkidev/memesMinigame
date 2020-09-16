-- meme contest by [Aron#6810] -- 
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disablePhysicalConsumables(true)
tfm.exec.newGame([[<C><P/><Z><S><S X="402" Y="200" T="0" L="810" H="409" P="0,0,0.3,0.2,0,0,0,0" i="0,0,173e28fe01b.png" c="4"/><S X="135" Y="189" T="14" L="278" H="17" P="0,0,0.3,0.2,0,0,0,0"/><S X="662" Y="190" T="14" L="274" H="22" P="0,0,0.3,0.2,0,0,0,0"/><S X="-30" Y="250" T="14" L="67" H="623" P="0,0,0,0,0,0,0,0"/><S X="834" Y="252" T="14" L="67" H="623" P="0,0,0,0,0,0,0,0"/><S X="37" Y="161" T="14" L="31" H="1" P="0,0,0.3,0.2,0,0,0,0"/><S X="760" Y="160" T="14" L="29" H="5" P="0,0,0.3,0.2,0,0,0,0"/></S><D><DS X="395" Y="160"/></D><O/><L/></Z></C>]])
pics = {"173e2f95f22.png","173e30acb86.png","173e30aeab6.png","173e3135bb2.png","173e3137c02.png","173e313943e.png","173e313abb0.png","173e31baffd.png","173e31c68a3.png","17497d8a7ab.png","17497d8c9ff.png","17497d8f65b.png","17497d9275f.png","17497d9cb63.png","17497da1410.png","17497da9014.png","17497daa786.png","17497db9bb7.png"}
admins = {["Aron#6810"] = true}
players = {}
player1 = {}
player2 = {}
banned = {}
start_player1 = false
start_player2 = false
end_player1 = false
end_player2 = false
game = true
time_write = false
stop = false
isPlayer1Playing = false
isPlayer2Playing = false
function start_game()
    tfm.exec.addPhysicObject(2,399,316,{type=14,restitution=0,friction=0,width=263,height=272,groundCollision=true})
    ui.addTextArea(0, "<a href='event:left'><p align='center'><font size='16'><b> [اضغط هنا]", nil, -11, 82, 101, 28, 0x000000, 0x000000, 1, true)
    ui.addTextArea(1, "<a href='event:right'><p align='center'><font size='16'><b> [اضغط هنا]", nil, 542, 89, 424, 28, 0x000000, 0x000000, 1, true)
end
start_game()

vote_player1 = 0
vote_player2 = 0
function eventTextAreaCallback(id,name,callback)
    local x = tfm.get.room.playerList[name].x
    if callback == "left" then
        if x > 0 and x < 90 then
            start_player1 = true
            isPlayer1Playing = true
            ui.removeTextArea(1,name)
            tfm.exec.movePlayer(name,37,142)
            ui.addTextArea(0, "<p align='center'><font size='16'><b>"..name.."", nil, -11, 82, 101, 28, 0x000000, 0x000000, 1, true)
            table.insert(player1,name)
            tfm.exec.chatMessage("<v>[Module] : </v><vp> "..name.." </vp><n> لقد اختار الكرسي الأيسر </n>",nil)
            if isPlayer2Playing == true then
                ui.addTextArea(1, "<p align='center'><font size='16'><b>"..player2[1].."", nil, 542, 89, 424, 28, 0x000000, 0x000000, 1, true)
            end
        else
            tfm.exec.chatMessage("<rose> انت بعيد جدا !!</rose>",name)
        end
    elseif callback == "right" then
        if x > 710 and x < 800 then
            start_player2 = true
            isPlayer2Playing = true
            tfm.exec.movePlayer(name,758,142)
            ui.removeTextArea(0,name)
            ui.addTextArea(1, "<p align='center'><font size='16'><b>"..name.."", nil, 542, 89, 424, 28, 0x000000, 0x000000, 1, true)
            table.insert(player2,name)
            tfm.exec.chatMessage("<v>[Module] : </v><vp> "..name.." </vp><n> لقد اختار الكرسي الأيمن</n>",nil)
            if isPlayer1Playing == true then
                ui.addTextArea(0, "<p align='center'><font size='16'><b>"..player1[1].."", nil, -11, 82, 101, 28, 0x000000, 0x000000, 1, true)
            end
        else
            tfm.exec.chatMessage("<rose> انت بعيد جداََََ </rose>",name)
        end
    elseif callback == "player_left" then
        if players[name].canVote then
            vote_player1 = vote_player1 + 1
            tfm.exec.chatMessage("<vp>"..name.." لقد قام بالتصويت ")
            ui.removeTextArea(7,name)
            ui.removeTextArea(8,name)
            players[name].canVote = false
        end
    elseif callback == "player_right" then
        if players[name].canVote then
            vote_player2 = vote_player2 + 1
            tfm.exec.chatMessage("<r>"..name.." لقد قام بالتصويت ")
            ui.removeTextArea(7,name)
            ui.removeTextArea(8,name)
            players[name].canVote = false
        end
    end
end
function newMeme()
    ui.addPopup(1,2,"<p align='center'> اكتب العبارة التي تليق مع الصورة التي ستجعل اللاعبين يضحكون",player1[1],11,210,224,true)
    ui.addPopup(2,2,"<p align='center'> اكتب العبارة التي تليق مع الصورة التي ستجعل اللاعبين يضحكون",player2[1],569,210,224,true)
    for name , player in next, tfm.get.room.playerList do
        tfm.exec.chatMessage("<vp> لقد بدأت الجولة , سيكتب المتنافسون الكلام الذي يصلح أن يكون على الصورة والذي سيجعلك تضحك \n بعد انتهاء المتسابقين صوت على العبارة التي جعلتك تضحك \n عبر الضغط على زر Vote",name)
        tfm.exec.addImage(pics[math.random(#pics)],"!1",0,0)
        tfm.exec.addPhysicObject(1,262,198,{type=14,restitution=0,friction=0,width=17,height=405,groundCollision=true})
        tfm.exec.addPhysicObject(2,532,198,{type=14,restitution=0,friction=0,width=17,height=405,groundCollision=true})
    end
end
function endGame()
    for name , player in next, tfm.get.room.playerList do
        players[name].canVote = true
    end
    ui.addTextArea(7, "<a href='event:player_left'><p align='center'><font size='23'><b><vp> Vote", name, 143, 89, 76, 36, 0x05080a, 0x000000, 1, true)
    ui.addTextArea(8, "<a href='event:player_right'><p align='center'><font size='23'><b><ch> Vote", name, 557, 88, 76, 36, 0x05080a, 0x000000, 1, true)
    tfm.exec.removePhysicObject(1)
    tfm.exec.addPhysicObject(2,399,316,{type=14,restitution=0,friction=0,width=263,height=272,groundCollision=true})
    for name , player in next, tfm.get.room.playerList do
        tfm.exec.chatMessage("<rose> لقد انتهى المتسابقون من كتابة عباراتهم المضحكة \n يمكنك الأن التصويت على أكثر عبارة اضحكتك والتي تتناسق مع الصورة",name)
    end
end
function eventPopupAnswer(id, name, answer)
    if id == 1 then
        if name == player1[1] then
            end_player1 = true
            ui.addTextArea(5, "<p align='center'><font size='20' color='#000'> العبارة : </font>\n<font size='17' color='#000'> "..answer.." ", nil, 11, 210, 224, 193, 0xe6e6e6, 0x000000, 1, true)
        end
    elseif id == 2 then
        if name == player2[1] then
            end_player2 = true
            ui.addTextArea(6, "<p align='center'><font size='20' color='#000'> العبارة : </font>\n<font size='17' color='#000'> "..answer.." ", nil, 569, 210, 224, 188, 0xd4d4d4, 0x000000, 1, true)
        end
    end
end

time_start = 0
time_to = os.time()
time = os.time()
win = os.time()
time_to_write = 0
function eventLoop(past,left)
    if left<1000 then
        tfm.exec.newGame([[<C><P/><Z><S><S X="402" Y="200" T="0" L="810" H="409" P="0,0,0.3,0.2,0,0,0,0" i="0,0,173e28fe01b.png" c="4"/><S X="135" Y="189" T="14" L="278" H="17" P="0,0,0.3,0.2,0,0,0,0"/><S X="662" Y="190" T="14" L="274" H="22" P="0,0,0.3,0.2,0,0,0,0"/><S X="-30" Y="250" T="14" L="67" H="623" P="0,0,0,0,0,0,0,0"/><S X="834" Y="252" T="14" L="67" H="623" P="0,0,0,0,0,0,0,0"/><S X="37" Y="161" T="14" L="31" H="1" P="0,0,0.3,0.2,0,0,0,0"/><S X="760" Y="160" T="14" L="29" H="5" P="0,0,0.3,0.2,0,0,0,0"/></S><D><DS X="395" Y="160"/></D><O/><L/></Z></C>]])
    end
    if game == true then
        ui.addTextArea(2, "<p align='center'><font size='35'><b>0", nil, 377, 103, 65, 54, 0x000000, 0x000000, 1, true)
        if time+1000 < os.time() then
            time_start = time_start + 1
            ui.addTextArea(2, "<p align='center'><font size='35'><b>" .. time_start, nil, 377, 103, 65, 54, 0x000000, 0x000000, 1, true)
        end
    end
    if time_start == 40 then
        if start_player1 == false or start_player2 == false then
            time_start = 0
            tfm.exec.chatMessage('<r>تحذير : هناك خطأ في عدد اللاعبين المتنافسين </r>')
        else
            ui.removeTextArea(2,nil)
            time_start = 0
            game = false
            time_write = true
            newMeme()
        end
    end
    if time_write == true then
        if time_to+1000 < os.time() then
            time_to_write = time_to_write + 1
            ui.addTextArea(9, "<p align='center'><font size='27'><b>"..time_to_write, nil, 365, 339, 68, 48, 0x07090a, 0x000000, 1, true)
        end
    end
    if time_write == true and (time_to_write == 100 or (end_player1 == true and end_player2 == true)) then
        time_to_write = 0
        ui.addTextArea(9, "<p align='center'><font size='27'>:)", nil, 365, 339, 68, 48, 0x07090a, 0x000000, 1, true)
        time_write = false
        stop = true
        endGame()
    end
    if stop == true then
            if win+1000 < os.time() then
                time_to_write = time_to_write + 1
            if time_to_write == 10 then
                time_write = false
                tfm.exec.chatMessage("<rose> يتم إختيار افضل ميمر من قبل اللاعبين ...")
            elseif time_to_write == 30 then
                if vote_player1 > vote_player2 then
                    tfm.exec.chatMessage("<j> الفائز هو : " .. player1[1])
                    tfm.exec.playEmote(player1[1],0)
                    tfm.exec.playEmote(player2[1],2)
                    tfm.exec.setGameTime(0,true)
                end
                if vote_player2 > vote_player1 then
                    tfm.exec.chatMessage("<j> الفائز هو : " .. player2[1])
                    tfm.exec.playEmote(player2[1],0)
                    tfm.exec.playEmote(player1[1],2)
                    tfm.exec.setGameTime(0,true)
                end
                if vote_player1 == vote_player2 then
                    tfm.exec.chatMessage("<j>  لايوجد فائز !")
                    tfm.exec.setGameTime(0,true)
                end
            end
        end
    end
end

function eventNewGame()
    tfm.exec.chatMessage("<V>[Module] :</v><n> جولة جديدة قد بدأت !!</n>")
    player1 = {}
    player2 = {}
    for _,remove in next,{3,4,5,6,7,8,9} do
        ui.removeTextArea(remove,nil)
    end
    start_player1 = false
    start_player2 = false
    end_player1 = false
    end_player2 = false
    game = true
    time_write = false
    stop = false
    isPlayer1Playing = false
    isPlayer2Playing = false
    time_start = 0
    time_to = os.time()
    time = os.time()
    time_to_write = 0
    start_game()
    vote_player1 = 0
    vote_player2 = 0
    for i = 1, #banned do
        ui.addTextArea(3, "",banned[i], -377, -85, 1544, 799, 0x070c0f, 0x000000, 1, true)
        ui.addTextArea(4, "<p align='center'><font size='53'> عذرا تم حظرك من اللعب :(", banned[i], 168, 134, 452, 228, 0x070c0f, 0x070c0f, 1, true)
    end
end
function eventNewPlayer(name)
    players[name] = {canVote = false}
    tfm.exec.chatMessage("<o> >[Aron#6810][" .. os.date("%H") .. ":" .. os.date("%M") .. "]</o><cep> مرحبا بك في النمط </cep>",name)
    tfm.exec.respawnPlayer(name)
    for i = 1, #banned do
        ui.addTextArea(3, "",banned[i], -377, -85, 1544, 799, 0x070c0f, 0x000000, 1, true)
        ui.addTextArea(4, "<p align='center'><font size='53'> عذرا تم حظرك من اللعب :(", banned[i], 168, 134, 452, 228, 0x070c0f, 0x070c0f, 1, true)
    end
    if player1[1] then
        ui.addTextArea(0, "<p align='center'><font size='16'><b>"..player1[1].."", name, -11, 82, 101, 28, 0x000000, 0x000000, 1, true)
    else
        ui.addTextArea(0, "<a href='event:left'><p align='center'><font size='16'><b> [اضغط هنا]", name, -11, 82, 101, 28, 0x000000, 0x000000, 1, true)
    end
    if player2[1] then
        ui.addTextArea(1, "<p align='center'><font size='16'><b>"..player2[1].."", name, 542, 89, 424, 28, 0x000000, 0x000000, 1, true)
    else
        ui.addTextArea(1, "<a href='event:right'><p align='center'><font size='16'><b> [اضغط هنا]", name, 542, 89, 424, 28, 0x000000, 0x000000, 1, true)
    end
end
function eventPlayerLeft(name)
    if name == player1[1] or name == player2[1] then
        tfm.exec.setGameTime(0,true)
        tfm.exec.chatMessage('<r>تحذير : هناك خطأ في عدد اللاعبين المتنافسين </r>')
        print("<r>تحذير : هناك خطأ في عدد اللاعبين المتنافسين </r>")
    end
end
function eventChatCommand(name,command)
    local args = {}
    for name in command:gmatch("%S+") do
        table.insert(args, name)
    end
    if admins[name] then
        if command == "skip" then
            tfm.exec.newGame([[<C><P/><Z><S><S X="402" Y="200" T="0" L="810" H="409" P="0,0,0.3,0.2,0,0,0,0" i="0,0,173e28fe01b.png" c="4"/><S X="135" Y="189" T="14" L="278" H="17" P="0,0,0.3,0.2,0,0,0,0"/><S X="662" Y="190" T="14" L="274" H="22" P="0,0,0.3,0.2,0,0,0,0"/><S X="-30" Y="250" T="14" L="67" H="623" P="0,0,0,0,0,0,0,0"/><S X="834" Y="252" T="14" L="67" H="623" P="0,0,0,0,0,0,0,0"/><S X="37" Y="161" T="14" L="31" H="1" P="0,0,0.3,0.2,0,0,0,0"/><S X="760" Y="160" T="14" L="29" H="5" P="0,0,0.3,0.2,0,0,0,0"/></S><D><DS X="395" Y="160"/></D><O/><L/></Z></C>]])
        end
    end
    if admins[name] then
        if args[1] == "ban" then
            table.insert(banned, args[2])
            tfm.exec.chatMessage("<v>[Module] : </v><n> لقد تم حظر اللاعب" .. args[2] .. "الى من الروم نهائيا")
            print("<v>[Module] : </v><n> لقد تم حظر اللاعب" .. " ".. args[2])
            ui.addTextArea(3, "", args[2], -377, -85, 1544, 799, 0x070c0f, 0x000000, 1, true)
            ui.addTextArea(4, "<p align='center'><font size='53'> عذرا تم حظرك من اللعب :(", args[2], 168, 134, 452, 228, 0x070c0f, 0x070c0f, 1, true)
        end
    end
end
function eventPlayerDied(name)
    for i = 1, #banned do
        ui.addTextArea(3, "",banned[i], -377, -85, 1544, 799, 0x070c0f, 0x000000, 1, true)
        ui.addTextArea(4, "<p align='center'><font size='53'> عذرا تم حظرك من اللعب :(", banned[i], 168, 134, 452, 228, 0x070c0f, 0x070c0f, 1, true)
    end
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)
