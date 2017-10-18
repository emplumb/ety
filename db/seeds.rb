ss = Roo::Excelx.new("#{Rails.root}/public/assets/data/oedos.xlsx")

header = ss.row(1)
(2..ss.last_row).each do |row|
  name = ss.cell(row, 'A')
  gender = ss.cell(row, 'B')
  p_s = ss.cell(row, 'C')
  part_of_speech = ss.cell(row, 'D')
  definition = ss.cell(row, 'E')
  etymology1 = ss.cell(row, 'F')
  etymology2 = ss.cell(row, 'G')
  uses = ss.cell(row, 'H')
  variants = ss.cell(row, 'I')
  romance_cognates = ss.cell(row, 'J')
  italic_cognates = ss.cell(row, 'K')
  etruscan = ss.cell(row, 'L')
  celtic_cognates = ss.cell(row, 'M')
  germanic_cognates = ss.cell(row, 'N')
  baltoslavic_cognates = ss.cell(row, 'O')
  albanian_cognates = ss.cell(row, 'P')
  hellenic_cognates = ss.cell(row, 'Q')
  armenian_cognates = ss.cell(row, 'R')
  indoiranian_cognates = ss.cell(row, 'S')
  semitic = ss.cell(row, 'T')
  uralic = ss.cell(row, 'U')
  ne_cauc = ss.cell(row, 'V')
  ie_cognates = ss.cell(row, 'W')
  notes1 = ss.cell(row, 'X')
  notes2 = ss.cell(row, 'Y')

  Term.create!(
    :name => name,
    :gender => gender,
    :p_s => p_s,
    :part_of_speech => part_of_speech,
    :definition => definition,
    :etymology1 => etymology1,
    :etymology2 => etymology2,
    :uses => uses,
    :variants => variants,
    :romance_cognates => romance_cognates,
    :italic_cognates => italic_cognates,
    :etruscan => etruscan,
    :celtic_cognates => celtic_cognates,
    :germanic_cognates => germanic_cognates,
    :baltoslavic_cognates => baltoslavic_cognates,
    :albanian_cognates => albanian_cognates,
    :hellenic_cognates => hellenic_cognates,
    :armenian_cognates => armenian_cognates,
    :indoiranian_cognates => indoiranian_cognates,
    :semitic => semitic,
    :uralic => uralic,
    :ne_cauc => ne_cauc,
    :ie_cognates => ie_cognates,
    :notes1 => notes1,
    :notes2 => notes2
  )

end
