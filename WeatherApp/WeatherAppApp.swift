//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Misan Etchie on 18/12/2022.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weather: previewWeather)
        }
    }
}
