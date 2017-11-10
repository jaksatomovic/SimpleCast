//
//  Forecast.swift
//  SimpleCast
//
//  Created by Jakša Tomović on 08/11/2017.
//  Copyright © 2017 Jakša Tomović. All rights reserved.
//

import Foundation


struct Forecast: Codable {
    
//    let coord : Coord?
    let weather : [Weather]?
//    let base : String?
    let main : Main?
    let wind : Wind?
//    let clouds : Clouds?
//    let dt : Int?
    let sys : Sys?
    let id : Int?
    let name : String?
//    let cod : Int?

    
    enum CodingKeys: String, CodingKey {
        
//        case coord
        case weather = "weather"
//        case base = "base"
        case main
        case wind
//        case clouds
//        case dt = "dt"
        case sys
        case id = "id"
        case name = "name"
//        case cod = "cod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        coord = try Coord(from: decoder)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
//        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
//        clouds = try Clouds(from: decoder)
//        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
//        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
    }
}


struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
    
}


struct Main : Codable {
    let temp : Double?
    let pressure : Double?
    let humidity : Int?
    let temp_min : Double?
    let temp_max : Double?
    let sea_level : Double?
    let grnd_level : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
        sea_level = try values.decodeIfPresent(Double.self, forKey: .sea_level)
        grnd_level = try values.decodeIfPresent(Double.self, forKey: .grnd_level)
    }
    
}



struct Wind : Codable {
    let speed : Double?
    let deg : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case deg = "deg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Int.self, forKey: .deg)
    }
    
}

struct Sys : Codable {
    let message : Double?
    let country : String?
    let sunrise : Int?
    let sunset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(Double.self, forKey: .message)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
    }
    
}

//struct Coord : Codable {
//    let lon : Double?
//    let lat : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case lon = "lon"
//        case lat = "lat"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
//        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
//    }
//
//}


//struct Clouds : Codable {
//    let all : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case all = "all"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        all = try values.decodeIfPresent(Int.self, forKey: .all)
//    }
//
//}



