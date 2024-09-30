//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by Misan on 9/20/24.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
