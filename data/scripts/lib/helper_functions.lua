Helpers = {}

Helpers.logCommand = function(player, words, param)
  local logFormat = "[%s] %s %s"
  local file = io.open("data/logs/player/" .. player:getName() .. " commands.log", "a")
	if not file then
		return
	end

	io.output(file)
	io.write(logFormat:format(os.date("%d/%m/%Y %H:%M"), words, param):trim() .. "\n")
	io.close(file)
	return
end