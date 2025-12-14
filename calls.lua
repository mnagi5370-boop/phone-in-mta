local activeCalls = {}

-- ====== إعداد بيانات تجريبية (عشان يشتغل فوراً) ======
addEventHandler("onPlayerJoin", root,
    function()
        local number = math.random(100000, 999999)
        setElementData(source, "phone:number", tostring(number))
        setElementData(source, "phone:sim", true)
        outputChatBox("📱 رقمك: "..number, source, 0, 255, 0)
    end
)

-- ====== فحص الشريحة ======
function hasActiveSim(player)
    return getElementData(player, "phone:sim") == true
end

-- ====== البحث عن لاعب بالرقم ======
function getPlayerByPhone(number)
    for _, p in ipairs(getElementsByType("player")) do
        if getElementData(p, "phone:number") == number then
            return p
        end
    end
    return false
end

-- ====== بدء مكالمة ======
function startCall(player, number)
    if not hasActiveSim(player) then
        outputChatBox("❌ معندكش شريحة.", player, 255, 0, 0)
        return
    end

    if activeCalls[player] then
        outputChatBox("📵 أنت في مكالمة بالفعل.", player, 255, 255, 0)
        return
    end

    local target = getPlayerByPhone(number)
    if not target then
        outputChatBox("❌ الرقم غير موجود.", player, 255, 0, 0)
        return
    end

    if not hasActiveSim(target) then
        outputChatBox("📵 الرقم مغلق.", player, 255, 255, 0)
        return
    end

    if activeCalls[target] then
        outputChatBox("📵 الخط مشغول.", player, 255, 255, 0)
        return
    end

    activeCalls[player] = target
    activeCalls[target] = player

    outputChatBox("📞 بدأت المكالمة.", player, 0, 255, 0)
    outputChatBox("📞 مكالمة واردة.", target, 0, 255, 0)
end

-- ====== إنهاء مكالمة ======
function endCall(player)
    local target = activeCalls[player]
    if not target then
        outputChatBox("❌ أنت مش في مكالمة.", player, 255, 0, 0)
        return
    end

    activeCalls[player] = nil
    activeCalls[target] = nil

    outputChatBox("📴 أنهيت المكالمة.", player, 255, 255, 0)
    outputChatBox("📴 الطرف الآخر أنهى المكالمة.", target, 255, 255, 0)
end

-- ====== شات المكالمة ======
addEventHandler("onPlayerChat", root,
    function(msg, msgType)
        if msgType ~= 0 then return end

        local target = activeCalls[source]
        if not target then return end

        cancelEvent()

        outputChatBox("📱 أنت: "..msg, source, 200, 200, 255)
        outputChatBox("📱 المتصل: "..msg, target, 200, 255, 200)
    end
)

-- ====== أوامر ======
addCommandHandler("call",
    function(player, _, number)
        if number then
            startCall(player, number)
        else
            outputChatBox("❗ /call [رقم]", player, 255, 255, 0)
        end
    end
)

addCommandHandler("hangup",
    function(player)
        endCall(player)
    end
)
