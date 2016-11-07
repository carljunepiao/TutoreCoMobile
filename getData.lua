local composer = require("composer")
local widget = require("widget")
local myApp = require( "myapp" )
local json = require( "json" )  -- Include the Corona JSON library
local scene = composer.newScene()

local bg
local title
local sString
local myText

local function textListener( event )

	    if ( event.phase == "began" ) then
	        -- User begins editing "defaultBox"

	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"
	        print( event.target.text )

	    elseif ( event.phase == "editing" ) then
	        print( event.newCharacters )
	        print( event.oldText )
	        print( event.startPosition )
	        print( event.text )
	    end
end

function scene:create(event)
	local sceneGroup = self.view

	--BACKGROUND
	local containerBG = display.newContainer( 360, 568 )
	containerBG.x = display.contentCenterX 
	containerBG.y = display.contentCenterY

	-- local gradient = { type="gradient", color1={193/255, 255/255, 193/255}, color2={193/255, 255/255, 193/255}, direction="down" } 

	local bg = display.newRect( 0, 0, 360, 568 )
	bg:setFillColor( 0.901961, 0.901961, 0.980392)
	-- bg.x = display.contentCenterX
	-- bg.y = display.contentCenterY
	containerBG:insert(bg)

	-- Create the widget
	local scrollView = widget.newScrollView
	{
	    --top = -180,
	    --left = 284,
	    width = 330,
	    height = 452,
	    scrollWidth = 320,
	    scrollHeight = 450,
	    backgroundColor = { 0.9, 0.9, 0.9},
	    -- listener = scrollListener
	}
	containerBG:insert(scrollView)

	-- Layout
	containerBG.anchorX, containerBG.anchorY = 0, 0
	containerBG.width, containerBG.height = 360,568
	containerBG.x, containerBG.y = 0, 0

	--scrollView.anchorX, scrollView.anchorY = 0,0
	--scrollView:setScrollWidth(250)
	--scrollView:setScrollHeight(400)
	scrollView.x, scrollView.y = -20, 15

	
-----------------------------------------------------------------------------------------
	-- DisplayTextSample
local function networkListener( event )
    if ( event.isError ) then
       print( "Network error!")
    else
       print ( "RESPONSE: " .. event.response )
       serializedString = json.decode( event.response )
        					print(serializedString[1].row_to_json)

        		sString = serializedString[1].row_to_json
   	name = 
	{
        text = sString,
	    x = 130,
	    y = 20,
	    width = 250,
	    font = native.systemFontBold,   
	    fontSize = 18,
	    align = "justify"  -- alignment parameter
	} 
        		myText = display.newText( name )
	 			myText:setFillColor( 0, 0, 0 )
	 			scrollView:insert(myText)
                            
       -- local sString = json.decode( serializedString )				
        --data = json.decode(serializedString)
       -- print(sString.student_address)
    end
end  

network.request( "http://172.16.14.55:4000/mobileviewtutor", "GET", networkListener, params)
	--print(sString)

	--  name = 
	-- {
 --        text = sString,
	--     x = 130,
	--     y = 20,
	--     width = 250,
	--     font = native.systemFontBold,   
	--     fontSize = 18,
	--     align = "justify"  -- alignment parameter
	-- }  

	local details = 
	{
        text = "18 | B.S. Computer Science | Sweet Lover", --serializedString[1].row_to_json.student_upmail,
	    x = 130,
	    y = 60,
	    width = 250,
	    font = native.systemFontBold,   
	    fontSize = 15,
	    align = "justify"  -- alignment parameter
	}
	local Post = 
	{
        text = "Please help me. I do not know how to GITHUB", --serializedString[1].row_to_json.student_upmail,
	    x = 130,
	    y = 110,
	    width = 250,
	    font = native.systemFontBold,   
	    fontSize = 12,
	    align = "justify"  -- alignment parameter
	}  

	--network.request( "http://172.16.14.55:4000/mobileviewtutor", "GET", networkListener, params)
--------------------------------------------------------------------------------------------------------
-- --DATABASE
-- 	local superHero = {
-- 	    name = "Clark Kent",
-- 	    nickname = "Superman",
-- 	    address = "Metropolis",
-- 	    age = 32
-- 	}

-- 	local serializedString = json.encode( superHeroes )

-- 	print( superHero.nickname )
-- 	local myText = display.newText( superHero.name ,120, 100, native.systemFont, 16)
--------------------------------------------------------------------------------------------------------
	 
	 
	local detail = display.newText( details )
	detail:setFillColor( 0, 0, 0 )
	scrollView:insert(detail)

	local post = display.newText( Post )
	post:setFillColor( 0, 0, 0 )
	scrollView:insert(post)
	-- sceneGroup:insert(myText)

 --    local container = display.newContainer( 300, 300 ) --size of container
 --    -- container:backgroundColor (0,0,0)
 --    container:translate( 160, 240 ) -- center the container

 --    -- local bkgd = display.newImage( "images/mask-80x80.png" )
 --    -- container:insert( bkgd, true ) -- insert and center bkgd

 --    local myText = display.newText( "Hello, World!", 0, 0, native.systemFont, 40 )
 --    myText:setFillColor( 1, 1, 0 )
 --    container:insert( myText, true ) -- insert and center text

 --    sceneGroup:insert(container)
	-- -- Enter Container
	-- local container = display.newContainer( 128, 128 )

	-- local options = 
	-- {
	--     --parent = textGroup,
	--     text = "Hello World",
	--     x = 100,
	--     y = 200,
	--     width = 128,
	--     font = native.systemFontBold,   
	--     fontSize = 18,
	--     align = "right"  -- alignment parameter
	-- }
	-- local txt = display.newText(options)
	-- container:insert(txt)

	-- sceneGroup:insert(container)
-----------------------------------------------------------------------------------------
	-- local myContainer = display.newContainer( 300, 200 )
	-- myContainer.x = display.contentCenterX 
	-- myContainer.y = display.contentCenterY

	-- local gradient = { type="gradient", color1={193/255, 255/255, 193/255}, color2={193/255, 255/255, 193/255}, direction="down" } 
	 
	-- local bg = display.newRect( 0, 0, 1000, 1000 )
	-- bg.fill = gradient
	-- myContainer:insert( bg )


	-- local myText = display.newText( "Hello World!", 0, 0, native.systemFont, 20 )
	-- myText:setFillColor(0,0,0)
	
	-- myContainer:insert( myText )
	-- sceneGroup:insert(myContainer)
-----------------------------------------------------------------------------------------
	-- Create text box label
	-- local textSettings =
	-- {
	--     text = "This is my text label.",
	--     x = display.contentCenterX,
	--     y = 100,
	--     width = display.contentWidth - 20,
	--     font = native.systemFont,
	--     fontSize = 20,
	-- }

	-- local textLabel = display.newText( textSettings )
	-- textLabel:setFillColor(0, 0, 0)
	-- sceneGroup:insert(textLabel)
-----------------------------------------------------------------------------------------
	-- Create a native text box using the same font size as the above text object
	-- local textBox = native.newTextBox( display.contentCenterX, 200, display.contentWidth-20, 120 )
	-- textBox.text = "This is line 1.\nAnd this is line2"
	-- textBox.isFontSizeScaled = true  -- Make the text box use the same font units as the text object
	-- textBox.size = textLabel.size
	-- textBox.isEditable = true
	-- sceneGroup:insert(textBox)

	-- Print the text box's font size measured in Corona's content-scaled units
	-- print( "Text Box Font Size (Corona Units) = " .. tostring( textBox.size ) )

	-- Print the text box's font size measured in the platform's native units
	-- textBox.isFontSizeScaled = false
	-- print( "Text Box Font Size (Native Units) = " .. tostring( textBox.size ) )
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
--*************************************************
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene
