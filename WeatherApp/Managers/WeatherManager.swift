//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Misan Etchie on 19/12/2022.
//

import Foundation
import CoreLocation
import Combine
import SwiftUICore

class Settings: ObservableObject {
    @Published var selectedUnit: String = "Imperial" // Default unit can be "metric" or "imperial"
}

class WeatherManager {
    @EnvironmentObject var settings: Settings
    
    func getCurrentManager (location: String, unit: String) async throws -> ResponseBody {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=ed902f757de14882b8fb44351c118fd5&units=\(unit)&q=\(location)") else {fatalError("Missing Error")}
        
        print("ffff")
        //print(n)
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            //fatalError("Error fetching weather data")
            return errorWeather
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
    
    
    func getCurrentForecast (location: String, unit: String) async throws -> ForecastBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?appid=ed902f757de14882b8fb44351c118fd5&units=\(unit)&q=\(location)") else {fatalError("Missing Error")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            //fatalError("Error fetching weather data")
            //return errorWeather
            return errorForecast
        }
        
        let decodedData = try JSONDecoder().decode(ForecastBody.self, from: data)
        
        return decodedData
    }
    
}

// Model of the response body we get from calling the OpenWeather API

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var visibility: Double
    var wind: WindResponse
    var sys: SysResponse
    var timezone: Int

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
    struct SysResponse: Decodable {
        var sunrise: Int
        var sunset: Int
        var country: String
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

struct ForecastBody: Decodable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [WeatherEntry]
    
    
    struct WeatherEntry: Decodable {
        var dt: Int
        var main: MainWeather
        var weather: [WeatherDescription]
        var clouds: Clouds
        var wind: Wind
        var visibility: Int
        var pop: Double
        var sys: Sys
        var dt_txt: String
    }
    
    struct MainWeather: Codable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var sea_level: Int
        var grnd_level: Int
        var humidity: Int
        var temp_kf: Double
    }
    
    struct WeatherDescription: Codable {
        var id: Int
        var main: String
        var description: String
        var icon: String
    }
    
    struct Clouds: Codable {
        var all: Int
    }
    
    struct Wind: Codable {
        var speed: Double
        var deg: Int
        var gust: Double
    }
    
    struct Sys: Codable {
        let pod: String
    }
    
}

extension ForecastBody.WeatherEntry {
    var dtTxt: String { return dt_txt }
}

extension ForecastBody.MainWeather {
    
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
    var seaLevel: Int{ return sea_level}
    var grndLevel: Int{ return grnd_level}
    var tempKf: Double{ return temp_kf}
}
