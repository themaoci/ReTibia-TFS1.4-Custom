local log_slow_exec_startExecProg = os.clock()
local log_slow_exec_currExecProg = ""
local log_slow_exec_currGetInfo = {}
local log_slow_exec_ReportTime = 0.05 -- where 1 is 1 second and 0.005 is 5 ms

-- enable disable this logger
local ExtendedDebug = true 

debug.sethook(function(event, line)
    if ExtendedDebug and log_slow_exec_currExecProg ~= debug.getinfo(2).source then
      if log_slow_exec_currExecProg ~= "" then
        local execTime = os.clock() - log_slow_exec_startExecProg
        if execTime > log_slow_exec_ReportTime then
          print(string.format(">>> long file %s at line %s executed in %.3f ms", log_slow_exec_currGetInfo.source, log_slow_exec_currGetInfo.currentline, execTime*1000))
        end
      end
    end
    if ExtendedDebug and log_slow_exec_currExecProg ~= debug.getinfo(2).source then
      -- init file changed
      log_slow_exec_startExecProg = os.clock()
      log_slow_exec_currExecProg = debug.getinfo(2).source
      log_slow_exec_currGetInfo = debug.getinfo(2)
      -- print ("source changed: " .. log_slow_exec_currExecProg) -- display source file changed for debugging only
    end
end, "l")