local composer = require("composer")
local widget = require("widget")
local myApp = require( "myapp" )
local json = require( "json" )  -- Include the Corona JSON library
local scene = composer.newScene()
-- stringS

local bg
local effects

function scene:create(event)
	local sceneGroup = self.view

	--BACKGROUND
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg:setFillColor( 0.901961,  0.901961, 0.980392)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	sceneGroup:insert(bg)


	-- 	-- Forward declares
	-- 	-------------------------------------------------------------------------------
	-- 	local list
		local previewShowing = false

	-- 	-- UI
	-- 	-------------------------------------------------------------------------------

		-- Handle row rendering
		local function onRowRender( event )
			local phase = event.phase
			local row = event.row
			
			-- Precalculate y position. NOTE: row's height will change as we add children
			local y = row.contentHeight * 0.5

			local rowTitle = display.newText( row, row.id.name, 0, 0, native.systemFontBold, 16 )
			local rowArrow = display.newImage( row, "rowArrow.png", false )

			-- Left-align title
			rowTitle.anchorX = 0
			rowTitle.x = 10
			rowTitle.y = y
			rowTitle:setFillColor( 0 )
			
			-- Right-align the arrow
			rowArrow.anchorX = 1
			rowArrow.x = row.contentWidth - 10
			rowArrow.y = y
		end

		-- Hande row touch events
		local function onRowTouch( event )
			local phase = event.phase
			local row = event.target
			
			if "press" == phase then
				-- print( "Pressed row: " .. row.index )
				stringS = effects[row.index].name
				print(stringS)
			elseif "release" == phase then
				-- Set preview effect
				-- after.fill.effect = row.id.name
				-- for i,v in pairs(row.id) do
				-- 	after.fill.effect[i] = v
				-- end

				-- -- Alert the user if this device does not support high precision fragment shaders.
				-- if row.id.reqhp and not supportHPS then
				-- 	precisionText.isVisible = true
				-- else
				-- 	precisionText.isVisible = false
				-- end

				-- -- Transition out the list, transition in the item selected text and the back button
				-- -- The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
				-- transition.to( list, { x = - width * 0.5 + display.screenOriginX, time = 400, transition = easing.outExpo } )
				-- transition.to( preview, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
				-- titleText.text = row.id.name:sub( 8 )
				-- previewShowing = true
				-- -- print( "Tapped and/or Released row: " .. row.index )

				--composer.removeHidden(true)
				-- print(effects[1].name)
				stringS = effects[row.index].name
				composer.hideOverlay("subject",true)

    			composer.gotoScene("findTutor", {time=250, effect="crossFade"})

			end
		end

		-- Create a tableView
		list = widget.newTableView
		{
			top = display.contentHeight/8,
		    left = 0,
		    width = display.contentWidth,
		    height = display.contentHeight/1.27,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
		}

		-- list is child of main view
		sceneGroup:insert( list )


	-- 	-- Load effect list
	-- 	-------------------------------------------------------------------------------

		-- Read effects from json
	local f = io.open( system.pathForFile( "filters.json" ) )
		local data = f:read( "*a" )
		effects = json.decode( data )

		for i = 1, #effects do
			list:insertRow{
				id = effects[i], -- use name of effect as id
				height = 72,
				category = "foo"
			}
		end



		print("Printing the effects")
		-- handle key events
		local function onKeyEvent( event )

		    local phase = event.phase
		    local keyName = event.keyName

		    if ( "back" == keyName and "up" == phase ) then
		        if previewShowing then
		            onBackRelease()
		        else
		            native.requestExit()
		        end
		        -- we handled the key event, return true
		        return true
		    end
		    -- we did not handle the key event, let the system know it has to deal with it
		    return false
		end
		Runtime:addEventListener( "key", onKeyEvent )

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