#!/usr/bin/env ruby

def to_binary(src)
  lookup = {
    '0' => '0000',
    '1' => '0001',
    '2' => '0010',
    '3' => '0011',
    '4' => '0100',
    '5' => '0101',
    '6' => '0110',
    '7' => '0111',
    '8' => '1000',
    '9' => '1001',
    'A' =>  '1010',
    'B' =>  '1011',
    'C' =>  '1100',
    'D' =>  '1101',
    'E' =>  '1110',
    'F' =>  '1111'
  }
  src.split('').inject('') do |acc, c|
    acc += lookup[c]
  end
end

def parse_package(package)
  types_lookup = {
    '100' => :literal,
  }
  version = package[0..2].to_i(2)
  type_id = package[3..5]
  body = package[6..-1]
  n = ''
  size = 0
  subpkgs = []

  if types_lookup[type_id] == :literal
    chunks_read = 0
    read_more=true
    while read_more
      chunk = body[0..4]
      chunks_read += 1
      n += chunk[1..-1]
      body = body[5..-1]
      read_more = false if chunk[0] == '0'
    end
    size = chunks_read + 6 + n.size
  else
    mode = body[0]
    body = body[1..-1]
    bits_read = 0

    if mode == '0'
      bits_to_be_read = body[0..14].to_i(2)
      subpackage = body[15...15+bits_to_be_read]
      while bits_read < bits_to_be_read
        pkg = parse_package(subpackage)
        subpkgs << pkg
        bits_read += pkg[:read]
        subpackage = subpackage[pkg[:read]..-1]
      end
      size = bits_read + 22

    else
      subpackages = body[0..10].to_i(2)
      subpackage = body[11..-1]
      for i in 1..subpackages
        pkg = parse_package(subpackage)
        subpkgs << pkg
        bits_read += pkg[:read]
        subpackage = subpackage[pkg[:read]..-1]
      end
      size = bits_read + 18
    end
  end

  return {
    version: version,
    literal: n.empty? ? nil : n.to_i(2),
    type_id: type_id,
    read: size,
    packages: subpkgs
  }
end

def sum_version(pkg)
  sum = pkg[:version]
  pkg[:packages].each do |p|
    sum += sum_version(p)
  end
  sum
end

def operate(pkg)
  return pkg[:literal] unless pkg[:literal].nil?

  mapping = pkg[:packages].map { |p| operate(p) }
  pkg_type = pkg[:type_id].to_i(2)

  case pkg_type
  when 0
    return mapping.sum
  when 1
    return mapping.reduce(&:*)
  when 2
    return mapping.min
  when 3
    return mapping.max
  when 5
    return mapping[0] > mapping[1] ? 1 : 0
  when 6
    return mapping[0] < mapping[1] ? 1 : 0
  when 7
    return mapping[0] == mapping[1] ? 1 : 0
  end
end

# parsed = parse_package(to_binary('D2FE28'))
# parsed = parse_package(to_binary('38006F45291200'))
# parsed = parse_package(to_binary('EE00D40C823060'))
# parsed = parse_package(to_binary('8A004A801A8002F478'))
# parsed = parse_package(to_binary('620080001611562C8802118E34'))
# parsed = parse_package(to_binary('C0015000016115A2E0802F182340'))
# parsed = parse_package(to_binary('A0016C880162017C3686B18A3D4780'))
parsed = parse_package(to_binary('005173980232D7F50C740109F3B9F3F0005425D36565F202012CAC0170004262EC658B0200FC3A8AB0EA5FF331201507003710004262243F8F600086C378B7152529CB4981400B202D04C00C0028048095070038C00B50028C00C50030805D3700240049210021C00810038400A400688C00C3003E605A4A19A62D3E741480261B00464C9E6A5DF3A455999C2430E0054FCBE7260084F4B37B2D60034325DE114B66A3A4012E4FFC62801069839983820061A60EE7526781E513C8050D00042E34C24898000844608F70E840198DD152262801D382460164D9BCE14CC20C179F17200812785261CE484E5D85801A59FDA64976DB504008665EB65E97C52DCAA82803B1264604D342040109E802B09E13CBC22B040154CBE53F8015796D8A4B6C50C01787B800974B413A5990400B8CA6008CE22D003992F9A2BCD421F2C9CA889802506B40159FEE0065C8A6FCF66004C695008E6F7D1693BDAEAD2993A9FEE790B62872001F54A0AC7F9B2C959535EFD4426E98CC864801029F0D935B3005E64CA8012F9AD9ACB84CC67BDBF7DF4A70086739D648BF396BFF603377389587C62211006470B68021895FCFBC249BCDF2C8200C1803D1F21DC273007E3A4148CA4008746F8630D840219B9B7C9DFFD2C9A8478CD3F9A4974401A99D65BA0BC716007FA7BFE8B6C933C8BD4A139005B1E00AC9760A73BA229A87520C017E007C679824EDC95B732C9FB04B007873BCCC94E789A18C8E399841627F6CF3C50A0174A6676199ABDA5F4F92E752E63C911ACC01793A6FB2B84D0020526FD26F6402334F935802200087C3D8DD0E0401A8CF0A23A100A0B294CCF671E00A0002110823D4231007A0D4198EC40181E802924D3272BE70BD3D4C8A100A613B6AFB7481668024200D4188C108C401D89716A080'))
puts sum_version(parsed)
puts operate(parsed)
