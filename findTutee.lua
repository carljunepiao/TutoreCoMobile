local composer = require("composer")
local widget = require("widget")
require("newPanel")
local myApp = require( "myapp" )
local json = require( "json" )  -- Include the Corona JSON library
local dropdown = require('dropdown')
local screen = require('screen')

local scene = composer.newScene()

local bg
local title
local add
local textField
local postContent
local count = 1
local tableMax

local  images = nil
local imgNum = nil

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local pad = 0
local top = top or 0
local bottom = bottom or 0

local start = 1

function scene:create(event)
	local sceneGroup = self.view

	--BACKGROUND
	bg = display.newRect( 0,0, display.contentWidth, display.contentHeight)
	bg:setFillColor(1,1,1)
    bg.x = display.contentWidth / 2
    bg.y = display.contentHeight / 2
	sceneGroup:insert(bg)


	local imgIcon = widget.newButton{
			x = display.contentWidth/2,
			y = 60,
			-- defaultFile = "imageicn.png",
			-- overFile = "imageicn.png",
			onEvent = imgIconEvent,
			width = 100,
			height = 100,
	}
	-- sceneGroup:insert(imgIcon)

	--------------------------------------------------TESTingnan -----------------------------------------



	-- local function networkListener( event )

	    
	     -- if ( event.isError ) then
	         -- print( "Network error!")
	     -- else
				local f = io.open( system.pathForFile( "viewPost.json" ) )
				local data = f:read( "*a" )
				local serializedString = json.decode( data )
				--local serializedString = json.decode( event.response )	

				-- print(serializedString)
				 local imageSet = serializedString
				 
				viewableScreenW = display.contentWidth
				viewableScreenH = display.contentHeight - 120

				images = {{},{},{},{},{}} 

				for i = 1, #imageSet do
				 	e = i
						print("imageSet"..#imageSet.." i="..i)
					
					local name = 
					{
				       text = imageSet[i].row_to_json.student_firstname.." "..serializedString[1].row_to_json.student_middlename.." "..serializedString[1].row_to_json.student_lastname,
					   x = display.contentWidth/2,
					   y = 160,
					   width = 250,
					   height = 0,
					   font = native.systemFontBold,   
					   fontSize = 24,
					   align = "center"  -- alignment parameter
					} 
					local Title = 
					{
				        text =  imageSet[i].row_to_json.title,
					   x = display.contentWidth/2,
					   y = name.height + name.y + 40,
					    width = 250,
					    height = 0,
					    font = native.systemFontBold,   
					    fontSize = 18,
					    align = "center"  -- alignment parameter
					}
					local Post = 
					{
				        text = imageSet[i].row_to_json.description,
					    x = display.contentWidth/2,
						y = Title.height + Title.y + 80,
					    width = 250,
					    height = 0,
					    font = native.systemFontBold,   
					    fontSize = 18,
					    align = "left"  -- alignment parameter
					}  
					local details = 
					{
				        text =   imageSet[i].row_to_json.student_upmail.."\n"..serializedString[1].row_to_json.student_contactno.."\n4th yr",
					    x = 160,
					   	y = Post.height + Post.y + 125,
					    width = 250,
					    height = 0,
					    font = native.systemFontBold,   
					    fontSize = 15,
					    align = "justify"  -- alignment parameter
					}


					local h = viewableScreenH-(top+bottom)
					
					if name.width > viewableScreenW or name.height > h then
						if name.width/viewableScreenW > name.height/h then 
								name.xScale = viewableScreenW/name.width
								name.yScale = viewableScreenW/name.width
						else
								name.xScale = h/name.height
								name.yScale = h/name.height
						end
					end

					if Title.width > viewableScreenW or Title.height > h then
						if Title.width/viewableScreenW > Title.height/h then 
								Title.xScale = viewableScreenW/Title.width
								Title.yScale = viewableScreenW/Title.width
						else
								Title.xScale = h/Title.height
								Title.yScale = h/Title.height
						end		 
				 	end

					if Post.width > viewableScreenW or Post.height > h then
						if Post.width/viewableScreenW > Post.height/h then 
								Post.xScale = viewableScreenW/Post.width
								Post.yScale = viewableScreenW/Post.width
						else
								Post.xScale = h/Post.height
								Post.yScale = h/Post.height
						end		 
				 	end

					if details.width > viewableScreenW or details.height > h then
						if details.width/viewableScreenW > details.height/h then 
								details.xScale = viewableScreenW/details.width
								details.yScale = viewableScreenW/details.width
						else
								details.xScale = h/details.height
								details.yScale = h/details.height
						end		 
				 	end

					local detail = display.newText( details )
					detail:setFillColor(64/255,61/255,71/255,1)
					sceneGroup:insert(detail)

					local post = display.newText( Post )
					post:setFillColor(64/255,61/255,71/255,1)
					sceneGroup:insert(post)

					local name = display.newText( name )
					name:setFillColor( 30/255, 124/255, 144/255)
					sceneGroup:insert(name)

					local title = display.newText( Title )
					title:setFillColor(64/255,61/255,71/255,1)
					sceneGroup:insert(title)

						-- local name = display.newText( Name )
						-- name:setFillColor( 30/255, 124/255, 144/255)

						 
					if (i > 1) then
						name.x = screenW*1.5 + pad -- all images offscreen except the first one
						detail.x = screenW*1.5 + pad
						post.x = screenW*1.5 + pad
						title.x = screenW*1.5 + pad
					else 

							name.x = screenW*.5
							detail.x = screenW*.5
							post.x = screenW*.5
							title.x = screenW*.5

					end

					images[i][1] = name
					images[i][2] = detail
					images[i][3] = post
					images[i][4] = title
								
				end

				
				imgNum = 1
				
				sceneGroup.x = 0
				sceneGroup.y = top + display.screenOriginY
						
				function touchListener (self, touch) 
					local phase = touch.phase
					print("slides", phase)
					if ( phase == "began" ) then
			            -- Subsequent touch events will target button even if they are outside the contentBounds of button
			            display.getCurrentStage():setFocus( self )
			            self.isFocus = true

						startPos = touch.x
						prevPos = touch.x

			        elseif( self.isFocus ) then
						if ( phase == "moved" ) then
							if tween then transition.cancel(tween) end
							print("Image number: "..imgNum)
							-- print(tween)
							local delta = touch.x - prevPos
							prevPos = touch.x
							images[imgNum][1].x = images[imgNum][1].x + delta
							images[imgNum][2].x = images[imgNum][2].x + delta
							images[imgNum][3].x = images[imgNum][3].x + delta
							images[imgNum][4].x = images[imgNum][4].x + delta
							if (images[imgNum-1]) then
								images[imgNum-1][1].x = images[imgNum-1][1].x + delta
								images[imgNum-1][2].x = images[imgNum-1][1].x + delta
								images[imgNum-1][3].x = images[imgNum-1][1].x + delta
								images[imgNum-1][4].x = images[imgNum-1][1].x + delta
							end
							if (images[imgNum+1]) then
								images[imgNum+1][1].x = images[imgNum+1][1].x + delta
								images[imgNum+1][2].x = images[imgNum+1][2].x + delta
								images[imgNum+1][3].x = images[imgNum+1][3].x + delta
								images[imgNum+1][4].x = images[imgNum+1][4].x + delta
							end

						elseif ( phase == "ended" or phase == "cancelled" ) then
							dragDistance = touch.x - startPos
							print("dragDistance: " .. dragDistance)
							if (dragDistance < -40 and imgNum < #images) then
								nextImage()
							elseif (dragDistance > 40 and imgNum > 1) then
								prevImage()
							else
								cancelMove()
							end				
							if ( phase == "cancelled" ) then		
								cancelMove()
							end
			                -- Allow touch events to be sent normally to the objects they "hit"
			                display.getCurrentStage():setFocus( nil )
			                self.isFocus = false								
						end
					end					
					return true
				end
				
				-- function setSlideNumber()
				-- 	-- print("setSlideNumber", imgNum .. " of " .. #images)
				-- 	-- navBar:setLabel( imgNum .. " of " .. #images )
				-- 	--imageNumberTextShadow.text = imgNum .. " of " .. #images

				-- 	name = 
				-- 	{
				--         text = imgNum .. " of " .. #images,
				-- 	    x = display.contentWidth/2,
			 --    		y = 40,
				-- 	    width = 250,
				-- 	    font = native.systemFontBold,   
				-- 	    fontSize = 15,
				-- 	    align = "center"  -- alignment parameter
				-- 	}

				-- 	myText = display.newText( name )
				-- 	myText:setFillColor( 0, 0, 0 )
				-- 	sceneGroup:insert(myText)

				-- end
				
				
				function nextImage()
					tween = transition.to( images[imgNum][1], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					print("imgNum : "..imgNum.." images[imgNum] ".." images[imgNum][1] "..images[imgNum][1].text)
					tween = transition.to( images[imgNum+1][1], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][2], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][2], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][3], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][3], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][4], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][4], {time=400, x=screenW*.5, transition=easing.outExpo } )
					imgNum = imgNum + 1
					initImage(imgNum)
				end
				
				function prevImage()
					tween = transition.to( images[imgNum][1], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][1], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][2], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][2], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][3], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][3], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][4], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][4], {time=400, x=screenW*.5, transition=easing.outExpo } )
					imgNum = imgNum - 1
					initImage(imgNum)
				end
				
				--Naay ERROR ANHI
				function cancelMove()
					tween = transition.to( images[imgNum][1], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][1], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][1], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][2], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][2], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][2], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][3], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][3], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][3], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
					tween = transition.to( images[imgNum][4], {time=400, x=screenW*.5, transition=easing.outExpo } )
					tween = transition.to( images[imgNum-1][4], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
					tween = transition.to( images[imgNum+1][4], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
				end
				
				function initImage(num)
					if (num < #images) then
						images[num+1][1].x = screenW*1.5 + pad
						images[num+1][2].x = screenW*1.5 + pad	
						images[num+1][3].x = screenW*1.5 + pad	
						images[num+1][4].x = screenW*1.5 + pad				
					end
					if (num > 1) then
						images[num-1][1].x = (screenW*.5 + pad)*-1
						images[num-1][2].x = (screenW*.5 + pad)*-1
						images[num-1][3].x = (screenW*.5 + pad)*-1
						images[num-1][4].x = (screenW*.5 + pad)*-1

					end
					-- setSlideNumber()
				end

				bg.touch = touchListener
				bg:addEventListener( "touch", bg )

				------------------------
				-- Define public methods
				
				function jumpToImage(num)
					local i
					print("jumpToImage")
					print("#images", #images)
					for i = 1, #images do
						if i < num then
							images[i][1].x = -screenW*.5;
							images[i][2].x = -screenW*.5;
							images[i][3].x = -screenW*.5;
							images[i][4].x = -screenW*.5;

						elseif i > num then
							images[i][1].x = screenW*1.5 + pad
							images[i][2].x = screenW*1.5 + pad
							images[i][3].x = screenW*1.5 + pad
							images[i][4].x = screenW*1.5 + pad
						else
							images[i][1].x = screenW*.5 - pad
							images[i][2].x = screenW*.5 - pad
							images[i][3].x = screenW*.5 - pad
							images[i][4].x = screenW*.5 - pad

						end
					end
					imgNum = num
					initImage(imgNum)
				end

				jumpToImage(start)
		--end
--	end

	-- network.request( "http://172.16.14.55:4000/mobileviewposttutee", "GET", networkListener, params)


	local function handleButtonEvent( event)
		if("ended" == event.phase) then
			panel:show()
        	panel:toFront()
        	postContent = native.newTextBox(161,340,317.5,260) --kay gahi man ug ulo ang textbox
			postContent.placeholder = "Enter post here. \nPlease review your post before\n submitting it" --inig click na lang sa user sa write post 
			postContent.isEditable = true -- maghimo ug textbox. pabebe ang textbox, wag gayahin
			postContent.font = native.newFont("Helvetica-Bold", 18)
			postContent.hasBackground = false
			-- composer.gotoScene("tutorPost", {time=250, effect="crossFade"})
		end
	end

	local writePost = widget.newButton{
			label = "Write a Post",
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
			onEvent = handleButtonEvent,
			emboss = false,
			fillColor = { default={236/255,238/255,240/255}, over={1,1,1} },
        	strokeColor = { default={236/255,238/255,240/255 }, over={1,1,1} },
        	strokeWidth = 4,
			x = display.contentCenterX - 80,
			y = display.contentCenterY - 188
	}

	sceneGroup:insert(writePost)


	local function filterListener( event)
		if("ended" == event.phase) then
			composer.gotoScene("subject", {time=250, effect="crossFade"})
		end
	end

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
	----------------------------------------------------------------------------------------------------
	--panel for write a post

	local function filterSubject( event)
		if("ended" == event.phase) then
			panel:hide()
			postContent.isVisible = false
			composer.gotoScene("subject", {time=250, effect="crossFade"})
			-- panel:toBack()
		end
	end
	local function submitPostEvent( event)
			if("ended" == event.phase) then
				print ("Button was pressed and released")
				print(panel.item2.text)
				print(postContent.text)
				panel:hide()
				postContent.isVisible = false
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
		      stud_id=6,
		      isTutor=false,
		      subj_id=40,
		      post_title= panel.item2.text,
		      desc = postContent.text
		}

		local params = {}
		params.headers = headers
		params.body = json.encode( tutor )

		print( "params.body: "..params.body )

		-- POST
		network.request( "http://172.16.14.55:4000/add_mobilepost", "POST", networkListener,params)
			end
	end

	local function cancelSubmitEvent( event)
		if("ended" == event.phase) then
			print ("Button was pressed and released")
			panel:hide()
			postContent.isVisible = false

		end
	end



	panel = widget.newPanel
	{
	    location = "left",
	    onComplete = panelTransDone,
	    width = display.contentWidth,
	    height = display.contentHeight,
	    speed = 500,
	    inEasing = easing.outBack,
	    outEasing = easing.outCubic
	}
	panel.background = display.newRect( 0, 12, 360,449 )
	panel.background:setFillColor( 157/255,208/255,138/255,.8 )
	panel:insert( panel.background )

	panel.item1= display.newRect(0,-187.5,360,50)
	panel.item1:setFillColor(157/255,208/255,138/255,.8)

	panel.title = display.newText( "Write a Post", -55, -187.5, native.systemFont, 30 )
	panel.title:setFillColor( 1,1,1,1 )

	panel.item2 = native.newTextField(1,-142.5,317.5,40)
	panel.item2.placeholder = "Enter title here"
	panel.item3 =  widget.newButton{
		--	onEvent = submitPostEvent,
			--label = "Submit",
			defaultFile = "checkB.png",
			overFile = "Submit.png",
			onEvent = submitPostEvent,
			width =30,
			height = 30
	}
	panel.item3.x =  30
	panel.item3.y =  210

	panel.item4 =  widget.newButton{
			--	onEvent = submitPostEvent,
				--label = "Submit",
				defaultFile = "cancelB.png",
				overFile = "cancelB.png",
				onEvent = cancelSubmitEvent,
				width =30,
				height = 30
	}
	panel.item4.x =  100
	panel.item4.y =  210

	panel.item5 = native.newTextField(1, -100.5,317.5,40)
	panel.item5.placeholder = "Enter subject here"
	panel:insert(panel.item5)
	panel:insert(panel.item2)
	panel:insert(panel.item1)
	panel:insert(panel.title)
	panel:insert(panel.item3)
	panel:insert(panel.item4)
	-- panel:insert(panel.item5)
	---------------------------------------------------------------------------------------------------------------
	---------------------------------------------TRANSITION TO ANOTHER POST----------------------------------------


	---------------------------------------------------------------------------------------------------------------
	--SCENE Insert


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