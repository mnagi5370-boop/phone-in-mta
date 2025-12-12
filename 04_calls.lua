-- التحقق من الشريحة قبل إجراء المكالمة
function canCall(playerID)
    if hasActiveSim(playerID) then
        return true
    else
        outputChatBox("لا يمكنك إجراء مكالمة بدون شريحة مفعلة!", getPlayerFromID(playerID))
        return false
    end
end

-- بدء مكالمة بين لاعبين
function startCall(callerID, receiverNumber)
    if not canCall(callerID) then return end

    -- البحث عن اللاعب المستقبل بالرقم
    local query = dbQuery("SELECT player_id FROM players_phone WHERE phone_number = ?", receiverNumber)
    local result = dbPoll(query, -1)

    if #result == 0 then
        outputChatBox("الرقم غير موجود!", getPlayerFromID(callerID))
        return
    end

    local receiverID = result[1].player_id

    if not hasActiveSim(receiverID) then
        outputChatBox("اللاعب المستقبل ليس لديه شريحة مفعلة!", getPlayerFromID(callerID))
        return
    end

    -- هنا تضع الكود الخاص بـ Voice Chat أو VoIP لبدء المكالمة
    outputChatBox("تم بدء المكالمة مع الرقم: " .. receiverNumber, getPlayerFromID(callerID))
    outputChatBox("لديك مكالمة واردة من الرقم: " .. getPhoneNumber(callerID), getPlayerFromID(receiverID))
end

-- إنهاء المكالمة
function endCall(callerID, receiverID)
    -- هنا تضع الكود الخاص بإنهاء المكالمة في Voice Chat أو VoIP
    outputChatBox("تم إنهاء المكالمة.", getPlayerFromID(callerID))
    outputChatBox("تم إنهاء المكالمة.", getPlayerFromID(receiverID))
end

-- دالة للحصول على رقم الموبايل للاعب
function getPhoneNumber(playerID)
    local query = dbQuery("SELECT phone_number FROM players_phone WHERE player_id = ?", playerID)
    local result = dbPoll(query, -1)
    if #result > 0 then
        return result[1].phone_number
    end
    return "غير معروف"
end
