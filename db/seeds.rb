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
  notes1 = ss.cell(row, 'I')
  notes2 = ss.cell(row, 'J')

  Term.create!(:name => name, :gender => gender, :p_s => p_s, :part_of_speech => part_of_speech, :definition => definition, :etymology1 => etymology1, :etymology2 => etymology2, :uses => uses, :notes1 => notes1, :notes2 => notes2)

end
