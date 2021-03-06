ss = Roo::Excelx.new("#{Rails.root}/public/assets/data/2018-10-15_updated_columns.xlsx")

(2..ss.last_row).each do |row|
  Term.create!(
    name: ss.cell(row, 'A'),
    slug: ss.cell(row, 'B'),
    gender: ss.cell(row, 'C'),
    prefix_suffix: ss.cell(row, 'D'),
    part_of_speech: ss.cell(row, 'E'),
    definition: ss.cell(row, 'F'),
    etymology1: ss.cell(row, 'G'),
    etymology2: ss.cell(row, 'H'),
    uses: ss.cell(row, 'I'),
    variants: ss.cell(row, 'J'),
    indo_european_cognates: ss.cell(row, 'K'),
    romance_cognates: ss.cell(row, 'L'),
    italic_cognates: ss.cell(row, 'M'),
    celtic_cognates: ss.cell(row, 'N'),
    germanic_cognates: ss.cell(row, 'O'),
    albanian_cognates: ss.cell(row, 'P'),
    balto_slavic_cognates: ss.cell(row, 'Q'),
    hellenic_cognates: ss.cell(row, 'R'),
    thracian_cognates: ss.cell(row, 'S'),
    phrygian_cognates: ss.cell(row, 'T'),
    messapian_cognates: ss.cell(row, 'U'),
    armenian_cognates: ss.cell(row, 'V'),
    indo_iranian_cognates: ss.cell(row, 'W'),
    tocharian_cognates: ss.cell(row, 'X'),
    anatolian_cognates: ss.cell(row, 'Y'),
    basque_cognates: ss.cell(row, 'Z'),
    tyrsenian_cognates: ss.cell(row, 'AA'),
    uralic_cognates: ss.cell(row, 'AB'),
    sami_cognates: ss.cell(row, 'AC'),
    finnic_cognates: ss.cell(row, 'AD'),
    mordvinic_cognates: ss.cell(row, 'AE'),
    mari_cognates: ss.cell(row, 'AF'),
    mansi_cognates: ss.cell(row, 'AG'),
    khanty_cognates: ss.cell(row, 'AH'),
    northeast_caucasian_cognates: ss.cell(row, 'AI'),
    nakh_cognates: ss.cell(row, 'AJ'),
    lezgic_cognates: ss.cell(row, 'AK'),
    dargwa_cognates: ss.cell(row, 'AL'),
    lak_cognates: ss.cell(row, 'AM'),
    lezghian_cognates: ss.cell(row, 'AN'),
    afro_asiatic_cognates: ss.cell(row, 'AO'),
    egyptian_cognates: ss.cell(row, 'AP'),
    semitic_cognates: ss.cell(row, 'AQ'),
    notes1: ss.cell(row, 'AR'),
    notes2: ss.cell(row, 'AS')
  )
end
  

