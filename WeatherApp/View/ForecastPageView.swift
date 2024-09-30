//
//  ForecastPageView.swift
//  WeatherApp
//
//  Created by Misan on 9/12/24.
//

import SwiftUI

struct ForecastPageView: View {
    @Binding var weather: ResponseBody
    @Binding var forecast: ForecastBody
    var unit: String
    
    private func groupedForecasts() -> [String: [ForecastBody.WeatherEntry]] {
            var grouped = [String: [ForecastBody.WeatherEntry]]()
            
            for item in forecast.list {
                let date = formatDate(TimeInterval(item.dt), timezoneOffset: TimeInterval(weather.timezone))
                
                if grouped[date] != nil {
                    grouped[date]?.append(item)
                } else {
                    grouped[date] = [item]
                }
            }
            
            return grouped
        }
    
    
    private func dateComponents(for dateString: String) -> (month: Int, day: Int) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Ensure consistent timezone
            
            if let date = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                return (month, day)
            }
            return (0, 0) // Default fallback
        }
        
    
    private var now: String {
        let currentTimestamp = Date().timeIntervalSince1970
        return formatDate(currentTimestamp, timezoneOffset: TimeInterval(TimeZone.current.secondsFromGMT()))
    }
    
    private var tomorrow: String {
        let tomorrowTimestamp = Date().addingTimeInterval(86400).timeIntervalSince1970 // 86400 seconds in a day
        return formatDate(tomorrowTimestamp, timezoneOffset: TimeInterval(TimeZone.current.secondsFromGMT()))
    }
    
    func formatDate(_ timestamp: TimeInterval, timezoneOffset: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp + timezoneOffset)
        
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" // Format for full date, e.g., Sep 15, 2024
        
        // Set the time zone to GMT 0 (Accra time)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Format the date
        return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack() {
                
                VStack(alignment: .leading) {
                    
                    Text("5-day Forecast for, " ).font(.footnote).bold().foregroundColor(Color("headerText"))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 0){
                        Text(weather.name).font(.largeTitle).foregroundColor(Color("headerText"))
                            .bold()
                        
                        Text(", " + weather.sys.country).font(.title3).foregroundColor(Color("headerText"))
                            .bold()
                    }
                    
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                WeatherNowView(weather: $weather, unit: unit).padding(.bottom, 10)
                
                ForEach(Array(groupedForecasts().keys).sorted {
                                   let date1 = dateComponents(for: $0)
                                   let date2 = dateComponents(for: $1)
                                   if date1.month == date2.month {
                                       return date1.day < date2.day
                                   } else {
                                       return date1.month < date2.month
                                   }
                               }, id: \.self) { date in
                                   VStack(alignment: .leading) {
                                       Text(now == date ? "Today" : tomorrow == date ? "Tomorrow" : date)
                                           .bold()
                                           .foregroundColor(.white)
                                           .padding(.horizontal)
                                           .padding(.vertical, 4)
                                           .background(Color("olive"))
                                           .cornerRadius(10)
                                           .padding(.horizontal)
                                           .padding(.top)
                                       
                                       ForEach(groupedForecasts()[date] ?? [], id: \.dt_txt) { item in
                                           ForecastItem(item: item, weather: $weather, unit: unit)
                                               .padding(.bottom, 4)
                                       }
                                   }
                               }
                
            }
            .padding(.bottom, 50)
        }
    }
    
    
}



struct ForecastPageView_Previews: PreviewProvider {
    @State static var weather: ResponseBody = previewWeather
    @State static var forecast: ForecastBody = previewForecast
    static var previews: some View {
        ForecastPageView(weather: $weather, forecast: $forecast, unit: "Metric")
        
        ForecastPageView(weather: $weather, forecast: $forecast, unit: "Metric")
            .previewDisplayName("Dark Mode")
            //.environment(\.colorScheme, .dark)
    }
}
