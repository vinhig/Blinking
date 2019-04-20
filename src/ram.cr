class Ram
  property a : UInt8
  property b : UInt8
  property c : UInt8
  property d : UInt8
  property e : UInt8
  property f : UInt8
  property h : UInt8
  property l : UInt8

  property af : UInt16
  property bc : UInt16
  property de : UInt16
  property hl : UInt16

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
    # 16bit register
    @af = 0_u16
    @bc = 0_u16
    @de = 0_u16
    @hl = 0_u16
    # memory
    @memory = Hash(UInt16, UInt8).new
  end

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

  def set_value(register : String, value : UInt8 | UInt16)
    puts "  (value set : #{value})"
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

  def set_value_f(address : String, register : String)
    # Set value in the memory at the specified address
    set_value(register, get_value(address))
    puts "  (#{register} copied from *#{address})"
  end
end
