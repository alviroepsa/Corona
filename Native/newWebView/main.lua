-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local webView

webView=native.newWebView( display.contentWidth/2, display.contentHeight/2,300,300)
webView:request("www.epsa.upv.es")