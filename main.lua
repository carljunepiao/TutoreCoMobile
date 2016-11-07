-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--IMPORT REQUIREMENTS
local composer = require("composer")
local myApp = require( "myapp" ) 
widget = require("widget")

---------------------------------------------------------------------------------------------
-----------------------------------SCREEN INTRODUCTION---------------------------------------
local logo = display.newImageRect("images/logoT.png", 320, 568)
logo.x = display.contentCenterX
logo.y = display.contentCenterY



local function closeSplash()
    display.remove(logo)
    logo = nil
    display.remove(background)
    background = nil
    composer.gotoScene("signin", {effect="crossFade",time=500})
end

timer.performWithDelay(1500, closeSplash)
-- composer.gotoScene("panel", {effect="fade",time=500})