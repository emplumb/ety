

terms = [
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

  {name: "baño",
  gender: "m.",
  part_of_speech: "n.",
  definition: "\"bath\"",
  etymology1: "From Vulgar Latin <i>baneum</i> \'id.,\' from Latin <i>balneum</i> - a variant of the more conservative <i>balineum</i> - borrowed from Greek <i>βαλανεῖον (balaneîon)</i> \"bath,\" \"bathing room.\"",
  etymology2: "",
  uses: "Asturian <i>bañu</i>, Portuguese <i>banho</i>, Galician <i>baño</i>, Catalan <i>bany</i>, French <i>bain</i>, Italian <i>bagno</i>, Romanian <i>baie</i>.",
  romance_cognates: "N/A",
  notes1: "",
  notes2: "",
  quote1: "",
  quote2: ""},

  {name: "cabeza",
  gender: "f.",
  part_of_speech: "n.",
  definition: "\"head\"",
  etymology1: "From Vulgar Latin <i>*capitia</i> \'id.,\' a feminine singular taken from the neuter plural of <i>capitium</i> (whence <i>cabezo</i> \"mountain peak\"), diminutive of <i>caput</i>.",
  etymology2: "",
  uses: "",
  romance_cognates: "Asturian <i>cabeza</i>, Portuguese <i>cabeça</i>, Galician <i>cabeza</i>, Italian <i>cavezza</i>.  Western Vulgar Latin reanalyzed the neuter plural as a feminine singular noun (see <b><a href='/directory/term/arma'>arma</a></b> and <b><a href='/directory/term/hoja'>hoja</a></b>).",
  notes1: "Similar to other rogue colloquialisms in Vulgar Latin like <b><a href='/directory/term/buscar'>buscar</a></b>, cabeza is present only in Iberian Romance languages and Italian. Its absence in other branches is conspicuous.",
  notes2: "",
  quote1: "",
  quote2: ""},

  {name: "buscar",
  gender: "",
  part_of_speech: "",
  definition: "",
  etymology1: "",
  etymology2: "",
  uses: "",
  romance_cognates: "",
  notes1: "",
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

]

terms.each do |term|
  term[:first] = term[:name][0]
end

Term.create!(terms)




