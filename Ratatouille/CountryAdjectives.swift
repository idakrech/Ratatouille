//
//  CountryCode.swift
//  Ratatouille
//
//
//

import Foundation

// based on areas available in TheMealDB
enum CountryAdjectives: String {
    case american = "American"
       case british = "British"
       case canadian = "Canadian"
       case chinese = "Chinese"
       case croatian = "Croatian"
       case dutch = "Dutch"
       case egyptian = "Egyptian"
       case filipino = "Filipino"
       case french = "French"
       case greek = "Greek"
       case indian = "Indian"
       case irish = "Irish"
       case italian = "Italian"
       case jamaican = "Jamaican"
       case japanese = "Japanese"
       case kenyan = "Kenyan"
       case malaysian = "Malaysian"
       case mexican = "Mexican"
       case moroccan = "Moroccan"
       case polish = "Polish"
       case portuguese = "Portuguese"
       case russian = "Russian"
       case spanish = "Spanish"
       case thai = "Thai"
       case tunisian = "Tunisian"
       case turkish = "Turkish"
       case unknown = "Unknown"
       case vietnamese = "Vietnamese"

       var countryCode: String {
           switch self {
           case .american: return "US"
           case .british: return "GB"
           case .canadian: return "CA"
           case .chinese: return "CN"
           case .croatian: return "HR"
           case .dutch: return "NL"
           case .egyptian: return "EG"
           case .filipino: return "PH"
           case .french: return "FR"
           case .greek: return "GR"
           case .indian: return "IN"
           case .irish: return "IE"
           case .italian: return "IT"
           case .jamaican: return "JM"
           case .japanese: return "JP"
           case .kenyan: return "KE"
           case .malaysian: return "MY"
           case .mexican: return "MX"
           case .moroccan: return "MA"
           case .polish: return "PL"
           case .portuguese: return "PT"
           case .russian: return "RU"
           case .spanish: return "ES"
           case .thai: return "TH"
           case .tunisian: return "TN"
           case .turkish: return "TR"
           case .unknown: return "XX"
           case .vietnamese: return "VN"
           }
       }
}
