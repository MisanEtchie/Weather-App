//
//  ModelData.swift
//  WeatherApp
//
//  Created by Misan Etchie on 19/12/2022.
//

import Foundation

var previewWeather: ResponseBody = load("WeatherData.json")
var errorWeather: ResponseBody = load("ErrorData.json")
//
var previewForecast: ForecastBody = load("ForecastData.json")
var errorForecast: ForecastBody = load("ErrorForecast.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
