local ec = EventCallback

ec.onTurn = function(self, direction)
    if self:getGroup():getAccess() and self:getDirection() == direction then
        local nextPosition = self:getPosition()
        nextPosition:getNextPosition(direction)

        self:teleportTo(nextPosition, true)
    end
	return true
end

ec:register()
