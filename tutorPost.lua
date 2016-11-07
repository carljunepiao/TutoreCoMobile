local composer = require("composer")
local widget = require("widget")
local myApp = require( "myapp" ) 
local dropdown = require('dropdown')
local screen = require('screen')
local json = require( "json" ) 
local scene = composer.newScene()

local bg
local postField
local titleField

local function textListener( event )

	    if ( event.phase == "began" ) then
	        -- User begins editing "defaultBox"

	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- Output resulting text from "defaultBox"
	        -- print( event.target.text )

	    elseif ( event.phase == "editing" ) then
	        -- print( event.newCharacters )
	        -- print( event.oldText )
	        -- print( event.startPosition )
	        print( event.text )
	        -- print(postField.text)
	    end
end



local function submitForm( event )
	if("ended" == event.phase) then
				print ("Button was pressed and released")
				-- print(panel.item2.text)
				-- print(postContent.text)
				-- panel:hide()
				-- postContent.isVisible = false
				composer.gotoScene("findTutor", {time=250, effect="crossFade"})
		
		local function networkListener( event )
			if ( event.isError ) then
		        print( "Network error!")
		    else

		    end
		end
		    
	    local headers = {
		    ["Content-Type"] = "application/json",
		    ["Accept-Language"] = "en-US",
		}
		local tutor = {
		      stud_id=5,
		      isTutor=true,
		      subj_id=40,
		      post_title= titleField.text,
		      desc = postField.text
		}

		local params = {}
		params.headers = headers
		params.body = json.encode( tutor )

		print( "params.body: "..params.body )

		-- POST
		network.request( "http://172.16.14.55:4000/add_mobilepost", "POST", networkListener,params)
	end
end


function scene:create(event)
	local sceneGroup = self.view

	--BACKGROUND
	local containerBG = display.newContainer( display.contentWidth, display.contentHeight )
	containerBG.x = display.contentCenterX 
	containerBG.y = display.contentCenterY

	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg:setFillColor( 0.901961, 0.901961, 0.980392)
	-- bg.x = display.contentCenterX
	-- bg.y = display.contentCenterY
	containerBG:insert(bg)


--------------------------------------------------------------------------------------------------------
--PLACEHOLDER FOR TITLE
	titleField = native.newTextField( display.contentWidth/200, -150, 290, 30 )
	titleField:addEventListener( "userInput", textListener )
	containerBG:insert(titleField)

	local titleText = display.newText( "TITLE", display.contentWidth/200, -180, native.systemFont, 16 )
	titleText:setFillColor( 0, 0, 0 )
	containerBG:insert(titleText)

--PLACEHOLDER FOR SUBJECT
	local FilterPosts = widget.newButton{
			label = "Filter Posts",
			 labelColor = { 
	            default = {157/255,208/255,138/255,1}, 
	            over = { 0.698039, 0.133333, 0.133333},
	            x = display.contentCenterX - 80,
	            y = display.contentCenterY - 188,
	            font = native.systemFontBold
        	},
        	shape = "Rect",
        	width = display.contentWidth/2,
        	height = 47,
			onEvent = filterListener,
			emboss = false,
			fillColor = { default={236/255,238/255,240/255}, over={1,1,1} },
        	strokeColor = { default={236/255,238/255,240/255}, over={1,1,1} },
        	strokeWidth = 4,
			x = display.contentCenterX - 80,
			y = display.contentCenterY - 188
	}

	FilterPosts.x = display.contentCenterX + 80
	FilterPosts.y = display.contentCenterY - 188
	FilterPosts.setLabel = ("Filter Posts")

	sceneGroup:insert(FilterPosts)

	local subject = display.newText( "SUBJECT", display.contentWidth/200, -110, native.systemFont, 16 )
	subject:setFillColor( 0, 0, 0 )
	containerBG:insert(subject)

--PLACEHOLDER FOR POST
	postField = native.newTextBox(display.contentWidth/200,30,290,100)
	postField.inputType = "text"
	postField.isEditable = true
	postField.size = 15
	postField:addEventListener("userInput",textListener)
	containerBG:insert(postField)

	local titleText = display.newText( "POST", display.contentWidth/200, -40, native.systemFont, 16 )
	titleText:setFillColor( 0, 0, 0 )
	containerBG:insert(titleText)

--BUTTON FOR SUBMIT
	submitButton = widget.newButton({
        width = 160,
        height = 40,
        defaultFile = 'images/submit.png',
	  	overFile    = 'images/submitover.png',
        labelYOffset = -4, 
        font = myApp.font,
        fontSize = 18,
        emboss = false,
        onRelease = submitForm
    })

    submitButton.x = 0
    submitButton.y = display.contentCenterX
    containerBG:insert(submitButton)

---------------------------------------------------------------------------------------------------------------
	--Scene insert container
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