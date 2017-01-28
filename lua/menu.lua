local Net = _G.LuaNetworking

function isPlaying()
	if not BaseNetworkHandler then return false end
	return BaseNetworkHandler._gamestate_filter.any_ingame_playing[ game_state_machine:last_queued_state_name() ]
end

--[[
function ChatGui:enabled()
	return self._enabled
end

function ChatGui:show()
	self._panel:show()
	self:set_enabled(true)
end
]]

function sendMessage(id)
	managers.chat:_receive_message(1, "PrivateMessage", "Player name = " .. Net:GetNameFromPeerID(id), Color.green)
end

if Net:IsMultiplayer() and Net:GetNumberOfPeers() > 0 and isPlaying() then
	local opts = {}
	for id, ply in pairs( Net:GetPeers() ) do
		opts[#opts+1] = { text = Net:GetNameFromPeerID(id), data = peer:id(), callback = sendMessage }
	end
	menuPrivate = QuickMenu:new("PRIVATE MESSAGE TO...", "Por Secco2112 \nVersão 1.0", opts)
	menuPrivate:show()
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