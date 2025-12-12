-- التحقق من الشريحة قبل أي عملية (مكالمة أو رسالة)
function hasActiveSim(playerID)
    local query = dbQuery("SELECT sim_active FROM players_phone WHERE player_id = ?", playerID)
    local result = dbPoll(query, -1)
    
    if #result == 0 then
        return false -- اللاعب مش موجود في DB
    end

    return result[1].sim_active == 1
end

-- تفعيل الشريحة (لو اللاعب شراها من المتجر)
function activateSim(playerID)
    local query = dbQuery("SELECT sim_active FROM players_phone WHERE player_id = ?", playerID)
    local result = dbPoll(query, -1)

    if #result == 0 then
        outputChatBox("حدث خطأ: اللاعب غير موجود في قاعدة البيانات.", player)
        return
    end

    if result[1].sim_active == 1 then
        outputChatBox("شريحتك مفعلة بالفعل.", player)
    else
        dbExec("UPDATE players_phone SET sim_active = ? WHERE player_id = ?", true, playerID)
        outputChatBox("تم تفعيل شريحتك بنجاح!", player)
    end
end

-- إلغاء الشريحة (مثلاً لو اللاعب حذفها)
function deactivateSim(playerID)
    dbExec("UPDATE players_phone SET sim_active = ? WHERE player_id = ?", false, playerID)
    outputChatBox("تم إلغاء شريحتك.", player)
end
