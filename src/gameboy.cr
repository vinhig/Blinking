require "../src/ram.cr"
require "../src/cpu.cr"

class GameBoy
  @rom : Slice(UInt8)
  @ram : Ram
  @cpu : Cpu
  @p : Int32
  @j : Bool

  def initialize(@rom)
    @ram = Ram.new
    @cpu = Cpu.new(@ram)
    @p = 0
    @j = true
  end

  def run
    output = ""
    while @p < @rom.size
      current = Instruction.new(@rom[@p], 1)
      output += execute(current, @p) + "\n"
      if @j != true
        @p += current.step
      else
        @j = false
      end
    end
    File.write("./Tetris.z80", output)
  end

  def execute(instruction : Instruction, p : Int32) : String
    opcode = Int32.new(instruction.opcode)
    case opcode
    when 0
      "nop"
    when 1
      @cpu.ld("BC", @rom[p + 1].to_u16 + @rom[p + 2].to_u16 * 0x100)
      instruction.step = 3
      ######
      "ld BC,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
      ######
    when 2
      @cpu.ld_f("BC", "A")
      ######
      "ld (BC),A"
      ######
    when 3
      @cpu.add("BC", 1_u8)
      ######
      "inc BC"
      ######
    when 4
      @cpu.add("B", 1_u8)
      ######
      "inc B"
      ######
    when 5
      @cpu.add("B", Int8.new(-1))
      ######
      "dec B"
      ######
    when 6
      @cpu.ld("B", @rom[p + 1])
      instruction.step = 2
      ######
      "ld B,n;n = #{@rom[p + 1]} as immediate value"
      ######
    when 7
      "rlc A"
    when 8
      instruction.step = 3
      "ld (nn),SP;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 9
      "add HL,BC"
    when 10
      "ld A,(BC)"
    when 11
      "dec BC"
    when 12
      "inc C"
    when 13
      "dec C"
    when 14
      instruction.step = 2
      "ld C,nn;nn = #{@rom[p + 1]} as immediate value"
    when 15
      "rrc A"
    when 16
      "stop"
    when 17
      instruction.step = 3
      "ld DE,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 18
      "ld (DE),A"
    when 19
      "inc DE"
    when 20
      "inc D"
    when 21
      "dec D"
    when 22
      instruction.step = 2
      "ld D,n;n = #{@rom[p + 1]} as immediate value"
    when 23
      "rl A"
    when 24
      instruction.step = 2
      "jr n;n = #{@rom[p + 1]} as immediate value"
    when 25
      "add HL,DE"
    when 26
      "ld A,(DE)"
    when 27
      "dec DE"
    when 28
      "inc E"
    when 29
      "dec E"
    when 30
      instruction.step = 2
      "ld E,n;n = #{@rom[p + 1]} as immediate value"
    when 31
      "rr A"
    when 32
      instruction.step = 2
      "jr NZ,n;n = #{@rom[p + 1]} as immediate value"
    when 33
      instruction.step = 3
      "ld HL,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 34
      "ldi (HL),A"
    when 35
      "inc HL"
    when 36
      "inc H"
    when 37
      "dec H"
    when 38
      instruction.step = 2
      "ld H,n;n = #{@rom[p + 1]} as immediate value"
    when 39
      "DAA"
    when 40
      instruction.step = 2
      "jr Z,n;n = #{@rom[p + 1]} as immediate value"
    when 41
      "add HL,HL"
    when 42
      "ldi A,(HL)"
    when 43
      "dec HL"
    when 44
      "inc L"
    when 45
      "dec L"
    when 46
      instruction.step = 2
      "ld L,n;n = #{@rom[p + 1]} as immediate value"
    when 47
      "cpl"
    when 48
      instruction.step = 2
      "jr NC,n;n = #{@rom[p + 1]} as immediate value"
    when 49
      instruction.step = 3
      "ld SP,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 50
      "ldd (HL),A"
    when 51
      "inc SP"
    when 52
      "inc (HL)"
    when 53
      "dec (HL)"
    when 54
      instruction.step = 2
      "ld (HL),n;n = #{@rom[p + 1]} as immediate value"
    when 55
      "scf"
    when 56
      instruction.step = 2
      "jr C,n;n = #{@rom[p + 1]} as immediate value"
    when 57
      "add HL,SP"
    when 58
      "ldd A,(HL)"
    when 59
      "dec SP"
    when 60
      "inc A"
    when 61
      "dec A"
    when 62
      instruction.step = 2
      "ld A,n;n = #{@rom[p + 1]} as immediate value"
    when 63
      "ccf"
    when 64
      "ld B,B"
    when 65
      "ld B,C"
    when 66
      "ld B,D"
    when 67
      "ld B,E"
    when 68
      "ld B,H"
    when 69
      "ld B,L"
    when 70
      "ld B,(HL)"
    when 71
      "ld B,A"
    when 72
      "ld C,B"
    when 73
      "ld C,C"
    when 74
      "ld C,D"
    when 75
      "ld C,E"
    when 76
      "ld C,H"
    when 77
      "ld C,L"
    when 78
      "ld C,(HL)"
    when 79
      "ld C,A"
    when 80
      "ld D,B"
    when 81
      "ld D,C"
    when 82
      "ld D,D"
    when 83
      "ld D,E"
    when 84
      "ld D,H"
    when 85
      "ld D,L"
    when 86
      "ld D,(HL)"
    when 87
      "ld D,A"
    when 88
      "ld E,B"
    when 89
      "ld E,C"
    when 90
      "ld E,D"
    when 91
      "ld E,E"
    when 92
      "ld E,H"
    when 93
      "ld E,L"
    when 94
      "ld E,(HL)"
    when 95
      "ld E,A"
    when 96
      "ld H,B"
    when 97
      "ld H,C"
    when 98
      "ld H,D"
    when 99
      "ld H,E"
    when 100
      "ld H,H"
    when 101
      "ld H,L"
    when 102
      "ld H,(HL)"
    when 103
      "ld H,A"
    when 104
      "ld L,B"
    when 105
      "ld L,C"
    when 106
      "ld L,D"
    when 107
      "ld L,E"
    when 108
      "ld L,H"
    when 109
      "ld L,L"
    when 110
      "ld L,(HL)"
    when 111
      "ld L,A"
    when 112
      "ld (HL),B"
    when 113
      "ld (HL),C"
    when 114
      "ld (HL),D"
    when 115
      "ld (HL),E"
    when 116
      "ld (HL),H"
    when 117
      "ld (HL),L"
    when 118
      "halt"
    when 119
      "ld (HL),A"
    when 120
      "ld A,B"
    when 121
      "ld A,C"
    when 122
      "ld A,D"
    when 123
      "ld A,E"
    when 124
      "ld A,H"
    when 125
      "ld A,L"
    when 126
      "ld A,(HL)"
    when 127
      "ld A,A"
    when 128
      "add A,B"
    when 129
      "add A,C"
    when 130
      "add A,D"
    when 131
      "add A,E"
    when 132
      "add A,H"
    when 133
      "add A,L"
    when 134
      "add A,(HL)"
    when 135
      "add A,A"
    when 136
      "adc A,B"
    when 137
      "adc A,C"
    when 138
      "adc A,D"
    when 139
      "adc A,E"
    when 140
      "adc A,H"
    when 141
      "adc A,L"
    when 142
      "adc A,(HL)"
    when 143
      "adc A,A"
    when 144
      "sub A,B"
    when 145
      "sub A,C"
    when 146
      "sub A,D"
    when 147
      "sub A,E"
    when 148
      "sub A,H"
    when 149
      "sub A,L"
    when 150
      "sub A,(HL)"
    when 151
      "sub A,A"
    when 152
      "sbc A,B"
    when 153
      "sbc A,C"
    when 154
      "sbc A,D"
    when 155
      "sbc A,E"
    when 156
      "sbc A,H"
    when 157
      "sbc A,L"
    when 158
      "sbc A,(HL)"
    when 159
      "sbc A,A"
    when 160
      "and B"
    when 161
      "and C"
    when 162
      "and D"
    when 163
      "and E"
    when 164
      "and H"
    when 165
      "and L"
    when 166
      "and (HL)"
    when 167
      "and A"
    when 168
      "xor B"
    when 169
      "xor C"
    when 170
      "xor D"
    when 171
      "xor E"
    when 172
      "xor H"
    when 173
      "xot L"
    when 174
      "xor (HL)"
    when 175
      "xor A"
    when 176
      "or B"
    when 177
      "or C"
    when 178
      "or D"
    when 179
      "or E"
    when 180
      "or H"
    when 181
      "or L"
    when 182
      "or (HL)"
    when 183
      "or A"
    when 184
      "cp B"
    when 185
      "cp C"
    when 186
      "cp D"
    when 187
      "cp E"
    when 188
      "cp H"
    when 189
      "cp L"
    when 190
      "cp (HL)"
    when 191
      "cp A"
    when 192
      "ret nz"
    when 193
      "pop bc"
    when 194
      instruction.step = 3
      "jp NZ,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 195
      instruction.step = 3
      "jp nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 196
      instruction.step = 3
      "call NZ,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 197
      "push BC"
    when 198
      instruction.step = 2
      "add A,n;n = #{@rom[p + 1]} as immediate value"
    when 199
      "rst 0"
    when 200
      "ret Z"
    when 201
      "ret"
    when 202
      instruction.step = 3
      "jp Z,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 203
      "ext ops"
    when 204
      instruction.step = 3
      "call Z,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 205
      instruction.step = 3
      "call nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 206
      instruction.step = 2
      "adc A,n;n = #{@rom[p + 1]} as immediate value"
    when 207
      "rst 8"
    when 208
      "ret NC"
    when 209
      "pop DE"
    when 210
      instruction.step = 3
      "jp NC,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 211
      "nop ;Operation removed on this cpu #{opcode}"
    when 212
      instruction.step = 3
      "call NC,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 213
      "push DE"
    when 214
      instruction.step = 2
      "sub A,n;n = #{@rom[p + 1]} as immediate value"
    when 215
      "rst 10"
    when 216
      "ret c"
    when 217
      "reti"
    when 218
      instruction.step = 3
      "jp C,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 219
      "nop ;Operation removed on this cpu #{opcode}"
    when 220
      instruction.step = 3
      "call C,nn;nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 221
      "nop ;Operation removed on this cpu #{opcode}"
    when 222
      instruction.step = 2
      "sbc A,n;n = #{@rom[p + 1]} as immediate value"
    when 223
      "rst 18"
    when 224
      instruction.step = 2
      "ldh (n),A;n = #{@rom[p + 1]} as immediate value"
    when 225
      "pop HL"
    when 226
      "ldh (C),A"
    when 227
      "nop ;Operation removed on this cpu #{opcode}"
    when 228
      "nop ;Operation removed on this cpu #{opcode}"
    when 229
      "push HL"
    when 230
      instruction.step = 2
      "and n;n = #{@rom[p + 1]} as immediate value"
    when 231
      "rst 20"
    when 232
      "add SP,d"
    when 233
      "jp (HL)"
    when 234
      "ld (nn),A"
    when 235
      "nop ;Operation removed on this cpu #{opcode}"
    when 236
      "nop ;Operation removed on this cpu #{opcode}"
    when 237
      "nop ;Operation removed on this cpu #{opcode}"
    when 238
      instruction.step = 2
      "xor n;n = #{@rom[p + 1]} as immediate value"
    when 239
      "rst 28"
    when 240
      instruction.step = 2
      "ldh A,(n);n = #{@rom[p + 1]} as immediate value"
    when 241
      "pop AF"
    when 242
      "nop ;Operation removed on this cpu #{opcode}"
    when 243
      "di"
    when 244
      "nop ;Operation removed on this cpu #{opcode}"
    when 245
      "push AF"
    when 246
      instruction.step = 2
      "or n;n = #{@rom[p + 1]} as immediate value"
    when 247
      "rst 30"
    when 248
      "ldhl SP,d"
    when 249
      "ld SP,HL"
    when 250
      instruction.step = 3
      "ld A,(nn);nn = #{@rom[p + 1]} and #{@rom[p + 2]} as immediate values"
    when 251
      "ei"
    when 252
      "nop ;Operation removed on this cpu #{opcode}"
    when 253
      "nop ;Operation removed on this cpu #{opcode}"
    when 254
      instruction.step = 2
      "cp n;n = #{@rom[p + 1]} as immediate value"
    when 255
      "rst 38"
    else
      puts "Unimplemented instruction :-/"
      ""
    end
  end
end
