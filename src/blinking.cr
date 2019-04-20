require "../src/gameboy.cr"

output = ""
# Set up our gameboy
gb : GameBoy

File.open("./Tetris/Tetris.gb") do |io|
  buffer = Bytes.new(2048) # Bytes is an alias for Slice(UInt8)
  bytes_read = io.read(buffer)
  buffer = buffer[0, bytes_read]
  gb = GameBoy.new(buffer)
  gb.run()
end


