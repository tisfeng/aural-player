//
//  LanguageMap.swift
//  Aural
//
//  Copyright © 2024 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Foundation

///
/// A mapping of language codes to user-friendly human-readable strings.
///
class LanguageMap {
    
    private init() {}
    
    static func forCode(_ code: String) -> String? {
        return map[code]
    }
    
    private static let map: [String: String] = {
        
        var map: [String: String] = [:]
        
        map["aa"] = "Afar"
        map["aar"] = "Afar"
        map["ab"] = "Abkhazian"
        map["abk"] = "Abkhazian"
        map["ace"] = "Achinese"
        map["ach"] = "Acoli"
        map["ada"] = "Adangme"
        map["ady"] = "Adyghe; Adygei"
        map["ae"] = "Avestan"
        map["af"] = "Afrikaans"
        map["afa"] = "Afro-Asiatic languages"
        map["afh"] = "Afrihili"
        map["afr"] = "Afrikaans"
        map["ain"] = "Ainu"
        map["ak"] = "Akan"
        map["aka"] = "Akan"
        map["akk"] = "Akkadian"
        map["alb"] = "Albanian"
        map["ale"] = "Aleut"
        map["alg"] = "Algonquian languages"
        map["alt"] = "Southern Altai"
        map["am"] = "Amharic"
        map["amh"] = "Amharic"
        map["an"] = "Aragonese"
        map["ang"] = "English, Old (ca.450-1100)"
        map["anp"] = "Angika"
        map["apa"] = "Apache languages"
        map["ar"] = "Arabic"
        map["ar-ae"] = "Arabic (U.A.E.)"
        map["ar-bh"] = "Arabic (Kingdom of Bahrain)"
        map["ar-dz"] = "Arabic (Algeria)"
        map["ar-eg"] = "Arabic (Egypt)"
        map["ar-iq"] = "Arabic (Iraq)"
        map["ar-jo"] = "Arabic (Jordan)"
        map["ar-kw"] = "Arabic (Kuwait)"
        map["ar-lb"] = "Arabic (Lebanon)"
        map["ar-ly"] = "Arabic (Libya)"
        map["ar-ma"] = "Arabic (Morocco)"
        map["ar-om"] = "Arabic (Oman)"
        map["ar-qa"] = "Arabic (Qatar)"
        map["ar-sa"] = "Arabic (Saudi Arabia)"
        map["ar-sy"] = "Arabic (Syria)"
        map["ar-tn"] = "Arabic (Tunisia)"
        map["ar-ye"] = "Arabic (Yemen)"
        map["ara"] = "Arabic"
        map["arc"] = "Official Aramaic (700-300 BCE); Imperial Aramaic (700-300 BCE)"
        map["arg"] = "Aragonese"
        map["arm"] = "Armenian"
        map["arn"] = "Mapudungun; Mapuche"
        map["arp"] = "Arapaho"
        map["art"] = "Artificial languages"
        map["arw"] = "Arawak"
        map["as"] = "Assamese"
        map["asm"] = "Assamese"
        map["ast"] = "Asturian; Bable; Leonese; Asturleonese"
        map["ath"] = "Athapascan languages"
        map["aus"] = "Australian languages"
        map["av"] = "Avaric"
        map["ava"] = "Avaric"
        map["ave"] = "Avestan"
        map["awa"] = "Awadhi"
        map["ay"] = "Aymara"
        map["aym"] = "Aymara"
        map["az"] = "Azerbaijani"
        map["aze"] = "Azerbaijani"
        map["ba"] = "Bashkir"
        map["bad"] = "Banda languages"
        map["bai"] = "Bamileke languages"
        map["bak"] = "Bashkir"
        map["bal"] = "Baluchi"
        map["bam"] = "Bambara"
        map["ban"] = "Balinese"
        map["baq"] = "Basque"
        map["bas"] = "Basa"
        map["bat"] = "Baltic languages"
        map["be"] = "Belarusian"
        map["bej"] = "Beja; Bedawiyet"
        map["bel"] = "Belarusian"
        map["bem"] = "Bemba"
        map["ben"] = "Bengali"
        map["ber"] = "Berber languages"
        map["bg"] = "Bulgarian"
        map["bh"] = "Bihari languages"
        map["bho"] = "Bhojpuri"
        map["bi"] = "Bislama"
        map["bih"] = "Bihari languages"
        map["bik"] = "Bikol"
        map["bin"] = "Bini; Edo"
        map["bis"] = "Bislama"
        map["bla"] = "Siksika"
        map["bm"] = "Bambara"
        map["bn"] = "Bengali"
        map["bnt"] = "Bantu languages"
        map["bo"] = "Tibetan"
        map["bod"] = "Tibetan"
        map["bos"] = "Bosnian"
        map["br"] = "Breton"
        map["bra"] = "Braj"
        map["bre"] = "Breton"
        map["bs"] = "Bosnian"
        map["btk"] = "Batak languages"
        map["bua"] = "Buriat"
        map["bug"] = "Buginese"
        map["bul"] = "Bulgarian"
        map["bur"] = "Burmese"
        map["byn"] = "Blin; Bilin"
        map["ca"] = "Catalan; Valencian"
        map["cad"] = "Caddo"
        map["cai"] = "Central American Indian languages"
        map["car"] = "Galibi Carib"
        map["cat"] = "Catalan; Valencian"
        map["cau"] = "Caucasian languages"
        map["ce"] = "Chechen"
        map["ceb"] = "Cebuano"
        map["cel"] = "Celtic languages"
        map["ces"] = "Czech"
        map["ch"] = "Chamorro"
        map["cha"] = "Chamorro"
        map["chb"] = "Chibcha"
        map["che"] = "Chechen"
        map["chg"] = "Chagatai"
        map["chi"] = "Chinese"
        map["chk"] = "Chuukese"
        map["chm"] = "Mari"
        map["chn"] = "Chinook jargon"
        map["cho"] = "Choctaw"
        map["chp"] = "Chipewyan; Dene Suline"
        map["chr"] = "Cherokee"
        map["chu"] = "Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic"
        map["chv"] = "Chuvash"
        map["chy"] = "Cheyenne"
        map["cmc"] = "Chamic languages"
        map["cnr"] = "Montenegrin"
        map["co"] = "Corsican"
        map["cop"] = "Coptic"
        map["cor"] = "Cornish"
        map["cos"] = "Corsican"
        map["cpe"] = "Creoles and pidgins, English based"
        map["cpf"] = "Creoles and pidgins, French-based"
        map["cpp"] = "Creoles and pidgins, Portuguese-based"
        map["cr"] = "Cree"
        map["cre"] = "Cree"
        map["crh"] = "Crimean Tatar; Crimean Turkish"
        map["crp"] = "Creoles and pidgins"
        map["cs"] = "Czech"
        map["csb"] = "Kashubian"
        map["cu"] = "Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic"
        map["cus"] = "Cushitic languages"
        map["cv"] = "Chuvash"
        map["cy"] = "Welsh"
        map["cym"] = "Welsh"
        map["cze"] = "Czech"
        map["da"] = "Danish"
        map["dak"] = "Dakota"
        map["dan"] = "Danish"
        map["dar"] = "Dargwa"
        map["day"] = "Land Dayak languages"
        map["de"] = "German"
        map["de-at"] = "German (Austria)"
        map["de-ch"] = "German (Switzerland)"
        map["de-li"] = "German (Liechtenstein)"
        map["de-lu"] = "German (Luxembourg)"
        map["del"] = "Delaware"
        map["den"] = "Slave (Athapascan)"
        map["deu"] = "German"
        map["dgr"] = "Dogrib"
        map["din"] = "Dinka"
        map["div"] = "Divehi; Dhivehi; Maldivian"
        map["doi"] = "Dogri"
        map["dra"] = "Dravidian languages"
        map["dsb"] = "Lower Sorbian"
        map["dua"] = "Duala"
        map["dum"] = "Dutch, Middle (ca.1050-1350)"
        map["dut"] = "Dutch; Flemish"
        map["dv"] = "Divehi; Dhivehi; Maldivian"
        map["dyu"] = "Dyula"
        map["dz"] = "Dzongkha"
        map["dzo"] = "Dzongkha"
        map["ee"] = "Ewe"
        map["efi"] = "Efik"
        map["egy"] = "Egyptian (Ancient)"
        map["eka"] = "Ekajuk"
        map["el"] = "Greek, Modern (1453-)"
        map["ell"] = "Greek, Modern (1453-)"
        map["elx"] = "Elamite"
        map["en"] = "English"
        map["en-au"] = "English (Australia)"
        map["en-bz"] = "English (Belize)"
        map["en-ca"] = "English (Canada)"
        map["en-gb"] = "English (United Kingdom)"
        map["en-ie"] = "English (Ireland)"
        map["en-jm"] = "English (Jamaica)"
        map["en-nz"] = "English (New Zealand)"
        map["en-ph"] = "English (Philippines)"
        map["en-tt"] = "English (Trinidad)"
        map["en-us"] = "English (United States)"
        map["en-za"] = "English (South Africa)"
        map["en-zw"] = "English (Zimbabwe)"
        map["eng"] = "English"
        map["enm"] = "English, Middle (1100-1500)"
        map["eo"] = "Esperanto"
        map["epo"] = "Esperanto"
        map["es"] = "Spanish; Castilian"
        map["es-ar"] = "Spanish (Argentina)"
        map["es-bo"] = "Spanish (Bolivia)"
        map["es-cl"] = "Spanish (Chile)"
        map["es-co"] = "Spanish (Colombia)"
        map["es-cr"] = "Spanish (Costa Rica)"
        map["es-do"] = "Spanish (Dominican Republic)"
        map["es-ec"] = "Spanish (Ecuador)"
        map["es-gt"] = "Spanish (Guatemala)"
        map["es-hn"] = "Spanish (Honduras)"
        map["es-mx"] = "Spanish (Mexico)"
        map["es-ni"] = "Spanish (Nicaragua)"
        map["es-pa"] = "Spanish (Panama)"
        map["es-pe"] = "Spanish (Peru)"
        map["es-pr"] = "Spanish (Puerto Rico)"
        map["es-py"] = "Spanish (Paraguay)"
        map["es-sv"] = "Spanish (El Salvador)"
        map["es-us"] = "Spanish (United States)"
        map["es-uy"] = "Spanish (Uruguay)"
        map["es-ve"] = "Spanish (Venezuela)"
        map["est"] = "Estonian"
        map["et"] = "Estonian"
        map["eu"] = "Basque"
        map["eus"] = "Basque"
        map["ewe"] = "Ewe"
        map["ewo"] = "Ewondo"
        map["fa"] = "Persian"
        map["fan"] = "Fang"
        map["fao"] = "Faroese"
        map["fas"] = "Persian"
        map["fat"] = "Fanti"
        map["ff"] = "Fulah"
        map["fi"] = "Finnish"
        map["fij"] = "Fijian"
        map["fil"] = "Filipino; Pilipino"
        map["fin"] = "Finnish"
        map["fiu"] = "Finno-Ugrian languages"
        map["fj"] = "Fijian"
        map["fo"] = "Faroese"
        map["fon"] = "Fon"
        map["fr"] = "French"
        map["fr-be"] = "French (Belgium)"
        map["fr-ca"] = "French (Canada)"
        map["fr-ch"] = "French (Switzerland)"
        map["fr-lu"] = "French (Luxembourg)"
        map["fr-mc"] = "French (Monaco)"
        map["fra"] = "French"
        map["fre"] = "French"
        map["frm"] = "French, Middle (ca.1400-1600)"
        map["fro"] = "French, Old (842-ca.1400)"
        map["frr"] = "Northern Frisian"
        map["frs"] = "Eastern Frisian"
        map["fry"] = "Western Frisian"
        map["ful"] = "Fulah"
        map["fur"] = "Friulian"
        map["fy"] = "Western Frisian"
        map["ga"] = "Irish"
        map["gaa"] = "Ga"
        map["gay"] = "Gayo"
        map["gba"] = "Gbaya"
        map["gd"] = "Gaelic; Scottish Gaelic"
        map["gem"] = "Germanic languages"
        map["geo"] = "Georgian"
        map["ger"] = "German"
        map["gez"] = "Geez"
        map["gil"] = "Gilbertese"
        map["gl"] = "Galician"
        map["gla"] = "Gaelic; Scottish Gaelic"
        map["gle"] = "Irish"
        map["glg"] = "Galician"
        map["glv"] = "Manx"
        map["gmh"] = "German, Middle High (ca.1050-1500)"
        map["gn"] = "Guarani"
        map["goh"] = "German, Old High (ca.750-1050)"
        map["gon"] = "Gondi"
        map["gor"] = "Gorontalo"
        map["got"] = "Gothic"
        map["grb"] = "Grebo"
        map["grc"] = "Greek, Ancient (to 1453)"
        map["gre"] = "Greek, Modern (1453-)"
        map["grn"] = "Guarani"
        map["gsw"] = "Swiss German; Alemannic; Alsatian"
        map["gu"] = "Gujarati"
        map["guj"] = "Gujarati"
        map["gv"] = "Manx"
        map["gwi"] = "Gwich'in"
        map["ha"] = "Hausa"
        map["hai"] = "Haida"
        map["hat"] = "Haitian; Haitian Creole"
        map["hau"] = "Hausa"
        map["haw"] = "Hawaiian"
        map["he"] = "Hebrew"
        map["heb"] = "Hebrew"
        map["her"] = "Herero"
        map["hi"] = "Hindi"
        map["hil"] = "Hiligaynon"
        map["him"] = "Himachali languages; Western Pahari languages"
        map["hin"] = "Hindi"
        map["hit"] = "Hittite"
        map["hmn"] = "Hmong; Mong"
        map["hmo"] = "Hiri Motu"
        map["ho"] = "Hiri Motu"
        map["hr"] = "Croatian"
        map["hrv"] = "Croatian"
        map["hsb"] = "Upper Sorbian"
        map["ht"] = "Haitian; Haitian Creole"
        map["hu"] = "Hungarian"
        map["hun"] = "Hungarian"
        map["hup"] = "Hupa"
        map["hy"] = "Armenian"
        map["hye"] = "Armenian"
        map["hz"] = "Herero"
        map["ia"] = "Interlingua (International Auxiliary Language Association)"
        map["iba"] = "Iban"
        map["ibo"] = "Igbo"
        map["ice"] = "Icelandic"
        map["id"] = "Indonesian"
        map["ido"] = "Ido"
        map["ie"] = "Interlingue; Occidental"
        map["ig"] = "Igbo"
        map["ii"] = "Sichuan Yi; Nuosu"
        map["iii"] = "Sichuan Yi; Nuosu"
        map["ijo"] = "Ijo languages"
        map["ik"] = "Inupiaq"
        map["iku"] = "Inuktitut"
        map["ile"] = "Interlingue; Occidental"
        map["ilo"] = "Iloko"
        map["ina"] = "Interlingua (International Auxiliary Language Association)"
        map["inc"] = "Indic languages"
        map["ind"] = "Indonesian"
        map["ine"] = "Indo-European languages"
        map["inh"] = "Ingush"
        map["io"] = "Ido"
        map["ipk"] = "Inupiaq"
        map["ira"] = "Iranian languages"
        map["iro"] = "Iroquoian languages"
        map["is"] = "Icelandic"
        map["isl"] = "Icelandic"
        map["it"] = "Italian"
        map["it-ch"] = "Italian (Switzerland)"
        map["ita"] = "Italian"
        map["iu"] = "Inuktitut"
        map["ja"] = "Japanese"
        map["jav"] = "Javanese"
        map["jbo"] = "Lojban"
        map["jpn"] = "Japanese"
        map["jpr"] = "Judeo-Persian"
        map["jrb"] = "Judeo-Arabic"
        map["jv"] = "Javanese"
        map["ka"] = "Georgian"
        map["kaa"] = "Kara-Kalpak"
        map["kab"] = "Kabyle"
        map["kac"] = "Kachin; Jingpho"
        map["kal"] = "Kalaallisut; Greenlandic"
        map["kam"] = "Kamba"
        map["kan"] = "Kannada"
        map["kar"] = "Karen languages"
        map["kas"] = "Kashmiri"
        map["kat"] = "Georgian"
        map["kau"] = "Kanuri"
        map["kaw"] = "Kawi"
        map["kaz"] = "Kazakh"
        map["kbd"] = "Kabardian"
        map["kg"] = "Kongo"
        map["kha"] = "Khasi"
        map["khi"] = "Khoisan languages"
        map["khm"] = "Central Khmer"
        map["kho"] = "Khotanese; Sakan"
        map["ki"] = "Kikuyu; Gikuyu"
        map["kik"] = "Kikuyu; Gikuyu"
        map["kin"] = "Kinyarwanda"
        map["kir"] = "Kirghiz; Kyrgyz"
        map["kj"] = "Kuanyama; Kwanyama"
        map["kk"] = "Kazakh"
        map["kl"] = "Kalaallisut; Greenlandic"
        map["km"] = "Central Khmer"
        map["kmb"] = "Kimbundu"
        map["kn"] = "Kannada"
        map["ko"] = "Korean"
        map["kok"] = "Konkani"
        map["kom"] = "Komi"
        map["kon"] = "Kongo"
        map["kor"] = "Korean"
        map["kos"] = "Kosraean"
        map["kpe"] = "Kpelle"
        map["kr"] = "Kanuri"
        map["krc"] = "Karachay-Balkar"
        map["krl"] = "Karelian"
        map["kro"] = "Kru languages"
        map["kru"] = "Kurukh"
        map["ks"] = "Kashmiri"
        map["ku"] = "Kurdish"
        map["kua"] = "Kuanyama; Kwanyama"
        map["kum"] = "Kumyk"
        map["kur"] = "Kurdish"
        map["kut"] = "Kutenai"
        map["kv"] = "Komi"
        map["kw"] = "Cornish"
        map["ky"] = "Kirghiz; Kyrgyz"
        map["kz"] = "Kyrgyz"
        map["la"] = "Latin"
        map["lad"] = "Ladino"
        map["lah"] = "Lahnda"
        map["lam"] = "Lamba"
        map["lao"] = "Lao"
        map["lat"] = "Latin"
        map["lav"] = "Latvian"
        map["lb"] = "Luxembourgish; Letzeburgesch"
        map["lez"] = "Lezghian"
        map["lg"] = "Ganda"
        map["li"] = "Limburgan; Limburger; Limburgish"
        map["lim"] = "Limburgan; Limburger; Limburgish"
        map["lin"] = "Lingala"
        map["lit"] = "Lithuanian"
        map["ln"] = "Lingala"
        map["lo"] = "Lao"
        map["lol"] = "Mongo"
        map["loz"] = "Lozi"
        map["lt"] = "Lithuanian"
        map["ltz"] = "Luxembourgish; Letzeburgesch"
        map["lu"] = "Luba-Katanga"
        map["lua"] = "Luba-Lulua"
        map["lub"] = "Luba-Katanga"
        map["lug"] = "Ganda"
        map["lui"] = "Luiseno"
        map["lun"] = "Lunda"
        map["luo"] = "Luo (Kenya and Tanzania)"
        map["lus"] = "Lushai"
        map["lv"] = "Latvian"
        map["mac"] = "Macedonian"
        map["mad"] = "Madurese"
        map["mag"] = "Magahi"
        map["mah"] = "Marshallese"
        map["mai"] = "Maithili"
        map["mak"] = "Makasar"
        map["mal"] = "Malayalam"
        map["man"] = "Mandingo"
        map["mao"] = "Maori"
        map["map"] = "Austronesian languages"
        map["mar"] = "Marathi"
        map["mas"] = "Masai"
        map["may"] = "Malay"
        map["mdf"] = "Moksha"
        map["mdr"] = "Mandar"
        map["men"] = "Mende"
        map["mg"] = "Malagasy"
        map["mga"] = "Irish, Middle (900-1200)"
        map["mh"] = "Marshallese"
        map["mi"] = "Maori"
        map["mic"] = "Mi'kmaq; Micmac"
        map["min"] = "Minangkabau"
        map["mis"] = "Uncoded languages"
        map["mk"] = "Macedonian"
        map["mkd"] = "Macedonian"
        map["mkh"] = "Mon-Khmer languages"
        map["ml"] = "Malayalam"
        map["mlg"] = "Malagasy"
        map["mlt"] = "Maltese"
        map["mn"] = "Mongolian"
        map["mnc"] = "Manchu"
        map["mni"] = "Manipuri"
        map["mno"] = "Manobo languages"
        map["moh"] = "Mohawk"
        map["mon"] = "Mongolian"
        map["mos"] = "Mossi"
        map["mr"] = "Marathi"
        map["mri"] = "Maori"
        map["ms"] = "Malay"
        map["msa"] = "Malay"
        map["mt"] = "Maltese"
        map["mul"] = "Multiple languages"
        map["mun"] = "Munda languages"
        map["mus"] = "Creek"
        map["mwl"] = "Mirandese"
        map["mwr"] = "Marwari"
        map["my"] = "Burmese"
        map["mya"] = "Burmese"
        map["myn"] = "Mayan languages"
        map["myv"] = "Erzya"
        map["na"] = "Nauru"
        map["nah"] = "Nahuatl languages"
        map["nai"] = "North American Indian languages"
        map["nap"] = "Neapolitan"
        map["nau"] = "Nauru"
        map["nav"] = "Navajo; Navaho"
        map["nb"] = "Bokmål, Norwegian; Norwegian Bokmål"
        map["nb-no"] = "Norwegian (Bokmal)"
        map["nbl"] = "Ndebele, South; South Ndebele"
        map["nd"] = "Ndebele, North; North Ndebele"
        map["nde"] = "Ndebele, North; North Ndebele"
        map["ndo"] = "Ndonga"
        map["nds"] = "Low German; Low Saxon; German, Low; Saxon, Low"
        map["ne"] = "Nepali"
        map["nep"] = "Nepali"
        map["new"] = "Nepal Bhasa; Newari"
        map["ng"] = "Ndonga"
        map["nia"] = "Nias"
        map["nic"] = "Niger-Kordofanian languages"
        map["niu"] = "Niuean"
        map["nl"] = "Dutch; Flemish"
        map["nl-be"] = "Dutch (Belgium)"
        map["nld"] = "Dutch; Flemish"
        map["nn"] = "Norwegian Nynorsk; Nynorsk, Norwegian"
        map["nn-no"] = "Norwegian (Nynorsk)"
        map["nno"] = "Norwegian Nynorsk; Nynorsk, Norwegian"
        map["no"] = "Norwegian"
        map["nob"] = "Bokmål, Norwegian; Norwegian Bokmål"
        map["nog"] = "Nogai"
        map["non"] = "Norse, Old"
        map["nor"] = "Norwegian"
        map["nqo"] = "N'Ko"
        map["nr"] = "Ndebele, South; South Ndebele"
        map["nso"] = "Pedi; Sepedi; Northern Sotho"
        map["nub"] = "Nubian languages"
        map["nv"] = "Navajo; Navaho"
        map["nwc"] = "Classical Newari; Old Newari; Classical Nepal Bhasa"
        map["ny"] = "Chichewa; Chewa; Nyanja"
        map["nya"] = "Chichewa; Chewa; Nyanja"
        map["nym"] = "Nyamwezi"
        map["nyn"] = "Nyankole"
        map["nyo"] = "Nyoro"
        map["nzi"] = "Nzima"
        map["oc"] = "Occitan (post 1500)"
        map["oci"] = "Occitan (post 1500)"
        map["oj"] = "Ojibwa"
        map["oji"] = "Ojibwa"
        map["om"] = "Oromo"
        map["or"] = "Oriya"
        map["ori"] = "Oriya"
        map["orm"] = "Oromo"
        map["os"] = "Ossetian; Ossetic"
        map["osa"] = "Osage"
        map["oss"] = "Ossetian; Ossetic"
        map["ota"] = "Turkish, Ottoman (1500-1928)"
        map["oto"] = "Otomian languages"
        map["pa"] = "Panjabi; Punjabi"
        map["paa"] = "Papuan languages"
        map["pag"] = "Pangasinan"
        map["pal"] = "Pahlavi"
        map["pam"] = "Pampanga; Kapampangan"
        map["pan"] = "Panjabi; Punjabi"
        map["pap"] = "Papiamento"
        map["pau"] = "Palauan"
        map["peo"] = "Persian, Old (ca.600-400 B.C.)"
        map["per"] = "Persian"
        map["phi"] = "Philippine languages"
        map["phn"] = "Phoenician"
        map["pi"] = "Pali"
        map["pl"] = "Polish"
        map["pli"] = "Pali"
        map["pol"] = "Polish"
        map["pon"] = "Pohnpeian"
        map["por"] = "Portuguese"
        map["pra"] = "Prakrit languages"
        map["pro"] = "Provençal, Old (to 1500);Occitan, Old (to 1500)"
        map["ps"] = "Pushto; Pashto"
        map["pt"] = "Portuguese"
        map["pt-br"] = "Portuguese (Brazil)"
        map["pus"] = "Pushto; Pashto"
        map["qaa-qtz"] = "Reserved for local use"
        map["qu"] = "Quechua"
        map["que"] = "Quechua"
        map["raj"] = "Rajasthani"
        map["rap"] = "Rapanui"
        map["rar"] = "Rarotongan; Cook Islands Maori"
        map["rm"] = "Romansh"
        map["rn"] = "Rundi"
        map["ro"] = "Romanian; Moldavian; Moldovan"
        map["ro-md"] = "Romanian (Moldova)"
        map["roa"] = "Romance languages"
        map["roh"] = "Romansh"
        map["rom"] = "Romany"
        map["ron"] = "Romanian; Moldavian; Moldovan"
        map["ru"] = "Russian"
        map["ru-md"] = "Russian (Moldova)"
        map["rum"] = "Romanian; Moldavian; Moldovan"
        map["run"] = "Rundi"
        map["rup"] = "Aromanian; Arumanian; Macedo-Romanian"
        map["rus"] = "Russian"
        map["rw"] = "Kinyarwanda"
        map["sa"] = "Sanskrit"
        map["sad"] = "Sandawe"
        map["sag"] = "Sango"
        map["sah"] = "Yakut"
        map["sai"] = "South American Indian languages"
        map["sal"] = "Salishan languages"
        map["sam"] = "Samaritan Aramaic"
        map["san"] = "Sanskrit"
        map["sas"] = "Sasak"
        map["sat"] = "Santali"
        map["sb"] = "Sorbian"
        map["sc"] = "Sardinian"
        map["scn"] = "Sicilian"
        map["sco"] = "Scots"
        map["sd"] = "Sindhi"
        map["se"] = "Northern Sami"
        map["sel"] = "Selkup"
        map["sem"] = "Semitic languages"
        map["sg"] = "Sango"
        map["sga"] = "Irish, Old (to 900)"
        map["sgn"] = "Sign Languages"
        map["shn"] = "Shan"
        map["si"] = "Sinhala; Sinhalese"
        map["sid"] = "Sidamo"
        map["sin"] = "Sinhala; Sinhalese"
        map["sio"] = "Siouan languages"
        map["sit"] = "Sino-Tibetan languages"
        map["sk"] = "Slovak"
        map["sl"] = "Slovenian"
        map["sla"] = "Slavic languages"
        map["slk"] = "Slovak"
        map["slo"] = "Slovak"
        map["slv"] = "Slovenian"
        map["sm"] = "Samoan"
        map["sma"] = "Southern Sami"
        map["sme"] = "Northern Sami"
        map["smi"] = "Sami languages"
        map["smj"] = "Lule Sami"
        map["smn"] = "Inari Sami"
        map["smo"] = "Samoan"
        map["sms"] = "Skolt Sami"
        map["sn"] = "Shona"
        map["sna"] = "Shona"
        map["snd"] = "Sindhi"
        map["snk"] = "Soninke"
        map["so"] = "Somali"
        map["sog"] = "Sogdian"
        map["som"] = "Somali"
        map["son"] = "Songhai languages"
        map["sot"] = "Sotho, Southern"
        map["spa"] = "Spanish; Castilian"
        map["sq"] = "Albanian"
        map["sqi"] = "Albanian"
        map["sr"] = "Serbian"
        map["srd"] = "Sardinian"
        map["srn"] = "Sranan Tongo"
        map["srp"] = "Serbian"
        map["srr"] = "Serer"
        map["ss"] = "Swati"
        map["ssa"] = "Nilo-Saharan languages"
        map["ssw"] = "Swati"
        map["st"] = "Sotho, Southern"
        map["su"] = "Sundanese"
        map["suk"] = "Sukuma"
        map["sun"] = "Sundanese"
        map["sus"] = "Susu"
        map["sux"] = "Sumerian"
        map["sv"] = "Swedish"
        map["sv-fi"] = "Swedish (Finland)"
        map["sw"] = "Swahili"
        map["swa"] = "Swahili"
        map["swe"] = "Swedish"
        map["sx"] = "Sutu"
        map["syc"] = "Classical Syriac"
        map["syr"] = "Syriac"
        map["ta"] = "Tamil"
        map["tah"] = "Tahitian"
        map["tai"] = "Tai languages"
        map["tam"] = "Tamil"
        map["tat"] = "Tatar"
        map["te"] = "Telugu"
        map["tel"] = "Telugu"
        map["tem"] = "Timne"
        map["ter"] = "Tereno"
        map["tet"] = "Tetum"
        map["tg"] = "Tajik"
        map["tgk"] = "Tajik"
        map["tgl"] = "Tagalog"
        map["th"] = "Thai"
        map["tha"] = "Thai"
        map["ti"] = "Tigrinya"
        map["tib"] = "Tibetan"
        map["tig"] = "Tigre"
        map["tir"] = "Tigrinya"
        map["tiv"] = "Tiv"
        map["tk"] = "Turkmen"
        map["tkl"] = "Tokelau"
        map["tl"] = "Tagalog"
        map["tlh"] = "Klingon; tlhIngan-Hol"
        map["tli"] = "Tlingit"
        map["tmh"] = "Tamashek"
        map["tn"] = "Tswana"
        map["to"] = "Tonga (Tonga Islands)"
        map["tog"] = "Tonga (Nyasa)"
        map["ton"] = "Tonga (Tonga Islands)"
        map["tpi"] = "Tok Pisin"
        map["tr"] = "Turkish"
        map["ts"] = "Tsonga"
        map["tsi"] = "Tsimshian"
        map["tsn"] = "Tswana"
        map["tso"] = "Tsonga"
        map["tt"] = "Tatar"
        map["tuk"] = "Turkmen"
        map["tum"] = "Tumbuka"
        map["tup"] = "Tupi languages"
        map["tur"] = "Turkish"
        map["tut"] = "Altaic languages"
        map["tvl"] = "Tuvalu"
        map["tw"] = "Twi"
        map["twi"] = "Twi"
        map["ty"] = "Tahitian"
        map["tyv"] = "Tuvinian"
        map["udm"] = "Udmurt"
        map["ug"] = "Uighur; Uyghur"
        map["uga"] = "Ugaritic"
        map["uig"] = "Uighur; Uyghur"
        map["uk"] = "Ukrainian"
        map["ukr"] = "Ukrainian"
        map["umb"] = "Umbundu"
        map["und"] = "Undetermined"
        map["ur"] = "Urdu"
        map["urd"] = "Urdu"
        map["uz"] = "Uzbek"
        map["uzb"] = "Uzbek"
        map["vai"] = "Vai"
        map["ve"] = "Venda"
        map["ven"] = "Venda"
        map["vi"] = "Vietnamese"
        map["vie"] = "Vietnamese"
        map["vo"] = "Volapük"
        map["vol"] = "Volapük"
        map["vot"] = "Votic"
        map["wa"] = "Walloon"
        map["wak"] = "Wakashan languages"
        map["wal"] = "Wolaitta; Wolaytta"
        map["war"] = "Waray"
        map["was"] = "Washo"
        map["wel"] = "Welsh"
        map["wen"] = "Sorbian languages"
        map["wln"] = "Walloon"
        map["wo"] = "Wolof"
        map["wol"] = "Wolof"
        map["xal"] = "Kalmyk; Oirat"
        map["xh"] = "Xhosa"
        map["xho"] = "Xhosa"
        map["yao"] = "Yao"
        map["yap"] = "Yapese"
        map["yi"] = "Yiddish"
        map["yid"] = "Yiddish"
        map["yo"] = "Yoruba"
        map["yor"] = "Yoruba"
        map["ypk"] = "Yupik languages"
        map["za"] = "Zhuang; Chuang"
        map["zap"] = "Zapotec"
        map["zbl"] = "Blissymbols; Blissymbolics; Bliss"
        map["zen"] = "Zenaga"
        map["zgh"] = "Standard Moroccan Tamazight"
        map["zh"] = "Chinese"
        map["zh-cn"] = "Chinese (China)"
        map["zh-hk"] = "Chinese (Hong Kong SAR)"
        map["zh-mo"] = "Chinese (Macao SAR)"
        map["zh-sg"] = "Chinese (Singapore)"
        map["zh-tw"] = "Chinese (Taiwan)"
        map["zha"] = "Zhuang; Chuang"
        map["zho"] = "Chinese"
        map["znd"] = "Zande languages"
        map["zu"] = "Zulu"
        map["zul"] = "Zulu"
        map["zun"] = "Zuni"
        map["zza"] = "Zaza; Dimili; Dimli; Kirdki; Kirmanjki; Zazaki"
        
        return map
        
    }()
}