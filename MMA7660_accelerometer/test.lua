dofile("MMA7660.lua")
MMA7660.init(7,8)  -- refer nodemcu pin map for gpio definitions
tmr.alarm(0, 100, tmr.ALARM_AUTO,function() print(MMA7660.getXYZ()) end)
