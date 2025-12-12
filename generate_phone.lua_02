-- دالة لتوليد رقم موبايل فريد
function generatePhoneNumber()
    local prefix = "010"  -- البادئة
    local number
    repeat
        number = prefix .. tostring(math.random(1000000, 9999999))
        local query = dbQuery("SELECT * FROM players_phone WHERE phone_number = ?", number)
        local result = dbPoll(query, -1)
    until (#result == 0)  -- التأكد أن الرقم فريد
    return number
end

-- دالة تفعيل الشريحة لأول مرة
function activateSim(playerID)
    -- تحقق إذا اللاعب عنده رقم مسبق
    local query = dbQuery("SELECT phone_number FROM players_phone WHERE player_id = ?", playerID)
    local result = dbPoll(query, -1)
    
    if #result == 0 or result[1].phone_number == nil then
        -- توليد رقم جديد
        local newNumber = generatePhoneNumber()
        -- حفظ الرقم في قاعدة البيانات وتفعيل الشريحة
        dbExec("INSERT INTO players_phone (player_id, phone_number, sim_active) VALUES (?, ?, ?)", playerID, newNumber, true)
        outputChatBox("تم تفعيل شريحتك ورقمك الجديد: " .. newNumber, player)
    else
        outputChatBox("شريحتك مفعلة مسبقًا ورقمك هو: " .. result[1].phone_number, player)
    end
end
