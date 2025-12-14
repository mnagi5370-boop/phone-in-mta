-- client.lua
local phoneBrowser = nil
local phoneVisible = false

-- وظيفة لفتح وإغلاق التليفون
function togglePhone()
    if not phoneBrowser then
        phoneBrowser = guiCreateBrowser(0, 0, 1, 1, true, true, false)
        addEventHandler("onClientBrowserCreated", phoneBrowser,
            function()
                -- تم تعديل هذا السطر لتصحيح الخطأ
                loadBrowserURL(phoneBrowser, "http://localhost/iphone_ui.html")
            end
        )
    end

    phoneVisible = not phoneVisible
    guiSetVisible(phoneBrowser, phoneVisible)
    showCursor(phoneVisible)
end

bindKey("m", "down", togglePhone) -- M تفتح التليفون

-- استقبال أحداث من السيرفر (Calls, SMS)
addEvent("phone:receiveSMS", true)
addEventHandler("phone:receiveSMS", root, function(fromNumber, message)
    if phoneBrowser then
        executeBrowserJavascript(phoneBrowser, ("addMessage('%s', '%s', 'in');"):format(fromNumber, message))
    end
end)

addEvent("phone:receiveCall", true)
addEventHandler("phone:receiveCall", root, function(fromNumber)
    if phoneBrowser then
        executeBrowserJavascript(phoneBrowser, ("incomingCall('%s');"):format(fromNumber))
    end
end)

-- إرسال أحداث للسيرفر من HTML
function sendSMSToServer(toNumber, message)
    triggerServerEvent("phone:sendSMS", resourceRoot, toNumber, message)
end

function makeCall(toNumber)
    triggerServerEvent("phone:makeCall", resourceRoot, toNumber)
end
