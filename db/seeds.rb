# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Term.create!([
  {name: "abajo",
  gender: "",
  part_of_speech: "adv.",
  definition: "\"down,\" \"below\"",
  etymology1: "From Latin <i>a-</i> \"at,\" \"toward\" and <i>bassus</i> \"down.\"",
  etymology2: "",
  uses: "",
  romance_cognates: "Cognate with French <i>à bas</i>, Catalan <i>abaixo</i>, Portuguese <i>abaixo</i>, Galician <i>abaixo</i>.",
  notes1: "Its wide distribution among Romance languages in the west identifies this as a Late Latin phrase, with strongest use in Iberia.",
  notes2: "",
  quote1: "",
  quote2: ""},

  {name: "abuelo, -a",
  gender: "",
  part_of_speech: "n.",
  definition: "\"grandparent\"",
  etymology1: "From Vulgar Latin *<i>aviolus</i>, from Latin <i>avus</i> and diminutive suffix <i>-olus</i>.",
  etymology2: "",
  uses: "",
  romance_cognates:"Cognates in Asturian <i>güelu</i> and French <i>aïeul</i> prove that the Vulgar Latin term was widespread in Western Romance. Cognates like Portuguese <i>avô</i> derive directly from <i>avus</i>.",
  notes1: "Latin <i>avus</i>, without the <i>-olus</i> suffix, became Spanish <i>ayo</i> \"tutor.\"",
  notes2: "",
  quote1: "\"Quien no sabe de abuelo, no sabe de bueno.\" He who does not know their grandfather, does not know what is good. Spanish proverb.",
  quote2: "\"Ay, abuelo, sembráste alazor, y naciónos anapelo.\" 18th century proverb. The origin, Stevens (1725) recounts, comes from \"a grandfather who marry'd a granddaughter to one he had great conceit of, and he proved a meer rake; whereupon another granddaughter cry'd, \"Grandfather, you sow'd saffron (which is rich and cordial, meaning he thought he had got an excellent son-in-law) and there came up poisonous wolfsbane;\" that is, he proved a vile husband.\" This popular etymology is echoed in Caro y Cejudo (1792)."},

  {name: "bajo",
  gender: "",
  part_of_speech: "adj.; adv.",
  definition: "\"short,\" \"low\"",
  etymology1: "From Latin <i>bassus</i> \"base;\" \"fat.\"",
  etymology2: "",
  uses: "",
  romance_cognates: "Asturian <i>baxu</i>, Portuguese <i>baixo</i>, Galician <i>baixo</i>, Catalan <i>baix</i>, French <i>bas</i>, Italian <i>basso</i>.",
  notes1: "A Western Romance term as it is absent in Eastern Romance and Sardinian.",
  notes2: "",
  quote1: "",
  quote2: ""},

  # {name: "",
  # gender: "",
  # part_of_speech: "",
  # definition: "",
  # etymology1: "",
  # etymology2: "",
  # uses: "",
  # romance_cognates: "",
  # notes1: "",
  # notes2: "",
  # quote1: "",
  # quote2: ""},

  # {name: "",
  # gender: "",
  # part_of_speech: "",
  # definition: "",
  # etymology1: "",
  # etymology2: "",
  # uses: "",
  # romance_cognates: "",
  # notes1: "",
  # notes2: "",
  # quote1: "",
  # quote2: ""},


])
