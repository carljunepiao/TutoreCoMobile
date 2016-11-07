--Required (imports?)
local myApp = require( "myapp" ) 
local widget = require("widget")
local composer = require("composer")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Declare Needed Variables
-- -----------------------------------------------------------------------------------

local fnameLabel
local lnameLabel
local mnameLabel
local addressLabel
local emailLabel
local passwordLabel

local fnameField
local lnameField
local mnameField
local addressField
local emailField
local passwordField

--This will be use for the connection & to get data in server
local serializeString

--Button for login & register
local backButton
local registerButton

--This will be use as a check if email & password is valid & present in the (server?)
local check = false --Set to false

--Text to show invalidmessage 
local showInvalidMsg 

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Submit & Network Connection event functions
-- -----------------------------------------------------------------------------------

--Back to sign in page
local function backers( event )
	composer.gotoScene( "signin", { isModal=true, time=250, effect="fade" } )
end

--LoginButton/ SubmitButton To have connection
local function registerForm( event )
	--Change this address of server where email and password is located !!!
	-- network.request( "http://172.16.14.55:4000/mobileviewposttutor", "GET", networkListener, params)
	composer.gotoScene( "signin", { isModal=true, time=250, effect="fade" } )
end

--Handle inputted email and password in field
local function handleField( Input )
	return function (event)
	    if ( event.phase == "began" ) then
	        -- User begins editing "defaultField"
	        event.target.text = ''
	    elseif ( event.phase == "ended" ) then
	        -- Output resulting text from "defaultField"
	        print( event.target.text )

	    elseif ( event.phase == "editing" ) then
	        print( event.newCharacters )
	        print( event.oldText )
	        print( event.startPosition )
	        print( event.text )
	    elseif(event.phase == "submitted" ) then

	    	native.setKeyboardFocus( nil )
	    end
	end
end

--Get needed data for connection and check whether it's valid or not
local function networkListener( event )
    if ( event.isError ) then
        print( "Network error: ", event.response )
    else
        serializeString = json.decode(event.response)

        
        
	end
	
	if check == true then
		composer.gotoScene( "main2", { isModal=true, time=250, effect="fade" } )
	else
		print("Invalid Email (& or /) password")
	-- 	showInvalidMsg = display.newText("Invalid Email (& or /) Password", display.contentCenterX - 80, display.contentCenterY - 20, native.systemFont)
	-- 	showInvalidMsg:setFillColor(0,0,0)
	-- 	showInvalidMsg.anchorX = 0
	end
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    --For background
    local bg = display.newRect( 0,0, display.contentWidth, display.contentHeight)
	bg:setFillColor(1,1,1)
    bg.x = display.contentWidth / 2
    bg.y = display.contentHeight / 2
	sceneGroup:insert(bg)

	-- local imgIcon = widget.newButton{
	-- 		x = display.contentWidth/2,
	-- 		y = 70,
	-- 		defaultFile = "imageicn.png",
	-- 		overFile = "imageicn.png",
	-- 		onEvent = imgIconEvent,
	-- 		width = 100,
	-- 		height = 100,
	-- }
	-- sceneGroup:insert(imgIcon)


	--Show Label for email & password
	fnameLabel = display.newText("First Name:", display.contentCenterX - 120, display.contentHeight/4.5, native.systemFont,15)
	fnameLabel:setFillColor(0,0,0)
	sceneGroup:insert(fnameLabel)
	fnameLabel.anchorX = 0

	lnameLabel = display.newText("Last Name:", display.contentCenterX - 120, display.contentHeight/3, native.systemFont,15)
	lnameLabel:setFillColor(0,0,0)
	sceneGroup:insert(lnameLabel)
	lnameLabel.anchorX = 0

	emailLabel = display.newText("UP mail:", display.contentCenterX - 120, display.contentHeight/2.25, native.systemFont,15)
	emailLabel:setFillColor(0,0,0)
	sceneGroup:insert(emailLabel)
	emailLabel.anchorX = 0

	passwordLabel = display.newText("Password:", display.contentCenterX - 120, display.contentHeight/1.8, native.systemFont,15)
	passwordLabel:setFillColor(0,0,0)
	sceneGroup:insert(passwordLabel)
	passwordLabel.anchorX = 0

	--
	-- composer.gotoScene( "main2", { isModal=true, time=250, effect="fade" } )

end


function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

	if ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        local fieldWidth = display.contentWidth/1.3

        -- Email & Password Field
		fnameField = native.newTextField( display.contentCenterX - 120 , fnameLabel.y+30, fieldWidth, 25 )
		fnameField:addEventListener( "userInput", handleField( function() return fnameField end ) ) 
		sceneGroup:insert(fnameField)
		fnameField.anchorX = 0

		lnameField = native.newTextField( display.contentCenterX - 120, lnameLabel.y + 30, fieldWidth, 25 )
		lnameField:addEventListener( "userInput", handleField( function() return lnameField end ) ) 
		lnameField.isSecure = true
		sceneGroup:insert(lnameField)
		lnameField.anchorX = 0

		-- Email & Password Field
		emailField = native.newTextField( display.contentCenterX - 120 , emailLabel.y+30, fieldWidth, 25 )
		emailField:addEventListener( "userInput", handleField( function() return emailField end ) ) 
		sceneGroup:insert(emailField)
		emailField.anchorX = 0

		passwordField = native.newTextField( display.contentCenterX - 120, passwordLabel.y + 30, fieldWidth, 25 )
		passwordField:addEventListener( "userInput", handleField( function() return passwordField end ) ) 
		passwordField.isSecure = true
		sceneGroup:insert(passwordField)
		passwordField.anchorX = 0

		-- Login Button
		backButton = widget.newButton({
	        width = 160,
	        height = 40,
	        label = "Back",
	        labelColor = { 
	            default = { 0,0,0 }, 
	            over = { 1,0,0 } 
	        },
	        labelYOffset = -4, 
	        font = native.systemFont,
	        fontSize = 20,
	        emboss = false,
		    onRelease = backers
	    })
	    backButton.x = display.contentWidth/2
	    backButton.y = emailField.y + 185
	    sceneGroup:insert(backButton)

	    -- Register Button
		registerButton = widget.newButton({
	        width = 160,
	        height = 40,
	        label = "Register",
	        labelColor = { 
	            default = { 0,0,0 }, 
	            over = { 1,0,0 } 
	        },
	        labelYOffset = -4, 
	        font = native.systemFont,
	        fontSize = 25,
	        emboss = false,
		    onRelease = registerForm
	    })
	    registerButton.x = display.contentWidth/2
	    registerButton.y =  emailField.y + 140
	    sceneGroup:insert(registerButton)


    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        fnameField:removeSelf()
		fnameField = nil
		lnameField:removeSelf()
		lnameField = nil
        emailField:removeSelf()
		emailField = nil
		passwordField:removeSelf()
		passwordField = nil

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene