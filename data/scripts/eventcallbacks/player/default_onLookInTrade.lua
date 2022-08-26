local ec = EventCallback

ec.onLookInTrade = function(self, partner, item, distance)
    local description = "You see " .. item:getDescription(distance)
    if self:getGroup():getAccess() then
        description = string.format("%s\nItem ID: %d", description, item:getId())

    end
	--self:sendTextMessage(MESSAGE_INFO_DESCR, description)
    return description
end

ec:register()
