local Net = _G.LuaNetworking

function isPlaying()
	if not BaseNetworkHandler then return false end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end

function send_Message(id)
	managers.chat:_receive_message(1, "PrivateMessage", "Player name = " .. Net:GetNameFromPeerID(id), Color.green)
	managers.chat:_receive_message(1, "PrivateMessage", "Player id = " .. peer:id(), Color.green)
	ChatGui:input_focus()
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
		local privateMenu = QuickMenu:new("PrivateMessage", "PrivateMessage to...", menu_options)
		privateMenu:Show()
	else
		managers.chat:_receive_message(1, "PrivateMessage", "Você está sozinho na sala", Color.red)
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
