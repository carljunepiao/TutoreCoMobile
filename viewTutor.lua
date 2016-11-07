local composer = require("composer")
local widget = require("widget")
-- local widgetExtras = require("widget-extras")
local myApp = require( "myapp" ) 
-- require("newNavigationBar")
local scene = composer.newScene()

--*************************************************

local bg
local title

function scene:create(event)
	local sceneGroup = self.view

	local bg = display.newRect( 0, 0, 360, 568 )
	bg:setFillColor( 0.901961, 0.901961, 0.980392)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	sceneGroup:insert(bg)



	local container = display.newContainer( 300, 300 ) --size of container
    container:translate( 160, 240 ) -- center the container

	local myText = display.newText( "Watch Me!", 0, 0, native.systemFont, 40 )
    myText:setFillColor( 1, 1, 0 )
    container:insert( myText, true ) -- insert and center text
    sceneGroup:insert(container)
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if(phase == "will") then

	elseif(phase == "did") then

	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if(phase == "will") then

	elseif(phase == "did") then

	end
end

function scene:destroy(event)
	local sceneGroup = self.view
end
--*************************************************
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene