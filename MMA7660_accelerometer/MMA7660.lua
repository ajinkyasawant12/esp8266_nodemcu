-- ******************************************************
-- MMA7660 module for ESP8266 with nodeMCU
--
-- Written by Swapnil Kashid <swapnil823@gmail.com
--
--
-- GNU LGPL, see https://www.gnu.org/copyleft/lesser.html
-- @TODO : add support for acceleration
--         
-- ******************************************************

MMA7660= {}
--definition of registers
MMA7660.MMA7660_ADDR  = 0x4c

--MMA7660.MMA7660_X     = 0x00
--MMA7660.MMA7660_Y     = 0x01
--MMA7660.MMA7660_Z     = 0x02
MMA7660.MMA7660_TILT  = 0x03
MMA7660.MMA7660_SRST  = 0x04
MMA7660.MMA7660_SPCNT = 0x05
MMA7660.MMA7660_INTSU = 0x06
--  MMA7660.MMA7660_SHINTX = 0x80
--  MMA7660.MMA7660_SHINTY = 0x40
--  MMA7660.MMA7660_SHINTZ = 0x20
--  MMA7660.MMA7660_GINT   = 0x10
--  MMA7660.MMA7660_ASINT  = 0x08
--  MMA7660.MMA7660_PDINT  = 0x04
--  MMA7660.MMA7660_PLINT  = 0x02
--  MMA7660.MMA7660_FBINT  = 0x01
MMA7660.MMA7660_MODE  = 0x07
  MMA7660.MMA7660_STAND_BY = 0x00
  MMA7660.MMA7660_ACTIVE   = 0x01
MMA7660.MMA7660_SR    = 0x08
  MMA7660.AUTO_SLEEP_120  = 0x00
  MMA7660.AUTO_SLEEP_64   = 0x01
  MMA7660.AUTO_SLEEP_32   = 0x02
  MMA7660.AUTO_SLEEP_16   = 0x03
  MMA7660.AUTO_SLEEP_8    = 0x04
  MMA7660.AUTO_SLEEP_4    = 0x05
  MMA7660.AUTO_SLEEP_2    = 0x06
  MMA7660.AUTO_SLEEP_1    = 0x07
--MMA7660.MMA7660_PDET  = 0x09
--MMA7660.MMA7660_PD    = 0x0A

MMA7660.id = 0

function MMA7660.write(register,data)
  i2c.start(MMA7660.id)
  i2c.address(MMA7660.id, MMA7660.MMA7660_ADDR, i2c.TRANSMITTER)
  i2c.write(MMA7660.id, register)
  i2c.write(MMA7660.id, data)
  i2c.stop(MMA7660.id)
end

function MMA7660.read(register)
  i2c.start(MMA7660.id)
  i2c.address(MMA7660.id, MMA7660.MMA7660_ADDR, i2c.TRANSMITTER)
  i2c.write(MMA7660.id, register)
  i2c.stop(MMA7660.id)
  i2c.start(MMA7660.id)
  i2c.address(MMA7660.id, MMA7660.MMA7660_ADDR, i2c.RECEIVER)
  c = i2c.read(MMA7660.id, 1)
  i2c.stop(MMA7660.id)
  return string.byte(c)
end

function MMA7660.mode(mod)
  MMA7660.write(MMA7660.MMA7660_MODE,mod)
end


function MMA7660.setSampleRate(rate)
  MMA7660.write(MMA7660.MMA7660_SR,rate)
end

function MMA7660.init(pinSDA, pinSCL)
  i2c.setup(MMA7660.id,pinSDA, pinSCL, i2c.SLOW)
  MMA7660.mode(MMA7660.MMA7660_STAND_BY)
  MMA7660.setSampleRate(MMA7660.AUTO_SLEEP_32)
  MMA7660.mode(MMA7660.MMA7660_ACTIVE)
end

function MMA7660.getXYZ()
  i2c.start(MMA7660.id)
  i2c.address(MMA7660.id, MMA7660.MMA7660_ADDR, i2c.TRANSMITTER)
  i2c.write(MMA7660.id, MMA7660.MMA7660_X)
  i2c.start(MMA7660.id)
  i2c.address(MMA7660.id, MMA7660.MMA7660_ADDR, i2c.RECEIVER)
  local r=i2c.read(MMA7660.id,3)
  i2c.stop(MMA7660.id)
  local x=string.byte(r,1)
  local y=string.byte(r,2)
  local z=string.byte(r,3)
  if x>31 then x=x-64 end -- negative values if bit 5 is 1
  if y>31 then y=y-64 end
  if z>31 then z=z-64 end
  if false then -- see if alert and go back
    
  else
    return x,y,z
  end
end
