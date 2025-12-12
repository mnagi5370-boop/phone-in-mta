local phoneBrowser = nil
local phoneVisible = false

function togglePhone()
    if not phoneBrowser then
        phoneBrowser = guiCreateBrowser(0, 0, 1, 1, true, true, false)
        addEventHandler("onClientBrowserCreated", phoneBrowser,
            function()
                loadBrowserURL(source, "http://localhost/iphone_ui.html")
            end
        )
    end

    phoneVisible = not phoneVisible
    guiSetVisible(phoneBrowser, phoneVisible)
    showCursor(phoneVisible)
end

bindKey("M", "down", togglePhone) -- M تفتح التليفون
