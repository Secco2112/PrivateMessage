local Net = _G.LuaNetworking

function isPlaying()
	if not BaseNetworkHandler then return false end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end

function send_Message(id)
	--managers.chat:_receive_message(1, "PrivateMessage", "Player name = " .. Net:GetNameFromPeerID(id), Color.green)
	--managers.chat:_receive_message(1, "PrivateMessage", "Player id = " .. peer:id(), Color.green)
	managers.hud:set_chat_focus(true)
	--if self._key_pressed == Idstring("enter") then
		--local text = self._input_panel:child("input_text")
		--local message = text:text()
		--managers.chat:_receive_message(1, "PrivateMessage", "PrivateMessage sended to " .. Net:GetNameFromPeerID(id), Color.green)
	--end
end

if Net:IsMultiplayer() and isPlaying() then
	if Net:GetNumberOfPeers() > 0 then
		local peer = managers.network._session:peer(id)
		local menu_options = {}
		for _, peer in pairs(managers.network:session():peers()) do
			menu_options[#menu_options+1] ={text = peer:name(), data = peer:id(), callback = send_Message}
		end
		menu_options[#menu_options+1] = {text = "", is_cancel_button = true}
		menu_options[#menu_options+1] = {text = "Fechar", is_cancel_button = true}
		local privateMenu = QuickMenu:new("Private Message Menu", "Send a Private Message to...", menu_options)
		privateMenu:Show()
	else
		managers.chat:_receive_message(1, "Private Message Menu", "Você está sozinho na sala", Color.red)
	end	
end

if not managers.hud then
_dialog_data = { 
				title = "teste",
				text = "teste",
				button_list = {{ text = "OK", is_cancel_button = true }},
				id = tostring(math.random(0,0xFFFFFFFF))
			}
			end
if managers.system_menu then
	managers.system_menu:show(_dialog_data)
end
