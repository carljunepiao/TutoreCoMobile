local composer = require("composer")
local widget = require("widget")
local myApp = require( "myapp" )
local json = require( "json" )  -- Include the Corona JSON library
local screen = require('screen')
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view
	local containerBG = display.newContainer( display.contentWidth, display.contentHeight)
	containerBG:translate(160,295)

	-- local gradient = { type="gradient", color1={193/255, 255/255, 193/255}, color2={193/255, 255/255, 193/255}, direction="down" } 

	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
	bg:setFillColor(1,1,1)
	-- bg.x = display.contentCenterX
	-- bg.y = display.contentCenterY
	containerBG:insert(bg)

	-- Create the widget
	
	-- Layout
	--containerBG.anchorX, containerBG.anchorY = 0, 0
	-- containerBG.width, containerBG.height = 200,500
	--containerBG.x, containerBG.y = 160,295

	--scrollView.anchorX, scrollView.anchorY = 0,0
	-- scrollView:setScrollWidth(200)
	-- scrollView:setScrollHeight(500)
	-- scrollView.x, scrollView.y = 160, 295
sceneGroup:insert(containerBG)	

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

--------------------------------------------------------------------------------------------------------
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene