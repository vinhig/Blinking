require "colorize"

class Ram
  # 8bit register
  property a : UInt8
  property b : UInt8
  property c : UInt8 # It's a flag too
  property d : UInt8
  property e : UInt8
  property f : UInt8
  property h : UInt8
  property l : UInt8
  property z : UInt8   # It's a flag too
  property n : UInt8   # It's a flag too
  property p_v : UInt8 # It's a truc too

  # 16bit register
  property af : UInt16
  property bc : UInt16
  property de : UInt16
  property hl : UInt16

  # Memory map
  property memory : Hash(UInt16, UInt8)

  def initialize
    # 8bit register
    @a = 0_u8
    @b = 0_u8
    @c = 0_u8
    @d = 0_u8
    @e = 0_u8
    @f = 0_u8
    @h = 0_u8
    @l = 0_u8
    @z = 0_u8
    @n = 0_u8
    @p_v = 0_u8
    # 16bit register
    @af = 0_u16
    @bc = 0_u16
    @de = 0_u16
    @hl = 0_u16
    # memory
    @memory = Hash(UInt16, UInt8).new
  end

  # Get the value of a specific register.
  def get_value(register : String) : UInt16 | UInt8
    case register
    when "A"
      @a
    when "B"
      @b
    when "C"
      @c
    when "D"
      @d
    when "E"
      @e
    when "F"
      @f
    when "H"
      @h
    when "L"
      @l
    when "Z"
      @z
    when "N"
      @n
    when "PV"
      @p_v
    when "AF"
      @af
    when "BC"
      @bc
    when "DE"
      @de
    when "HL"
      @hl
    else
      raise "Unknown register '#{register}''. :-/"
    end
  end

  # Set the value of a specific register.
  def set_value(register : String, value : UInt8 | UInt16)
    puts "  value set : #{value.colorize(:green)}".colorize(:yellow)
    case register
    when "A"
      @a = UInt8.new(value)
    when "B"
      @b = UInt8.new(value)
    when "C"
      @c = UInt8.new(value)
    when "D"
      @d = UInt8.new(value)
    when "E"
      @e = UInt8.new(value)
    when "F"
      @f = UInt8.new(value)
    when "H"
      @h = UInt8.new(value)
    when "L"
      @l = UInt8.new(value)
    when "Z"
      @z = UInt8.new(value)
    when "N"
      @n = UInt8.new(value)
    when "PV"
      @p_v = UInt8.new(value)
    when "AF"
      @af = UInt16.new(value)
    when "BC"
      @bc = UInt16.new(value)
    when "DE"
      @de = UInt16.new(value)
    when "HL"
      @hl = UInt16.new(value)
    end
  end

  # Set the value of a register as the value of a specified register.
  def set_value_f(address : String, register : String)
    # Set value in the memory at the specified address
    set_value(register, get_value(address))
    puts "  (#{register} copied from *#{address})"
  end

  # Get the value at specified memory map address.
  def set_value_f(address : UInt16)
  end
end
