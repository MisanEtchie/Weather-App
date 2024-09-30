//
//  SunView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 19/12/2022.
//

import SwiftUI

func convertTimestamp(_ timestamp: TimeInterval, timezoneOffset: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp + timezoneOffset)
        
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        // Set the time zone to GMT 0 (Accra time)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Format the date
        return dateFormatter.string(from: date)
    }


struct SunView: View {
    @Binding var weather: ResponseBody
    
    //@State private var value: CGFloat = 50
    
    
    
    
    
    
    
    var body: some View {
        
        
        
        VStack {
            
            
            
            HStack {
                
                HStack {
                    Image(systemName: "sun.min")
                        .font(.system(size: 30)).foregroundColor(.white)
                    VStack{
                        
                        let riseDate = convertTimestamp(TimeInterval(weather.sys.sunrise), timezoneOffset: TimeInterval(weather.timezone))
                        
                        
                        
                        //Date.init(timeIntervalSinceNow: TimeInterval(weather.sys.sunset))
                        
                        
                        //Text(String(weather.main.feelsLike))
                        
                        
                        Text("Sunrise").foregroundColor(.white).bold()
                        
                        
                        Text(riseDate) .font(.system(size: 15.0))
                            .bold()
                            .foregroundColor(.white)
                    }
                }.padding()
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 100
                    )
                    .background(Color("orange"))
                    .cornerRadius(15)
                    .padding(.trailing, 12)
                
                
                //            SemiCircleView(value: value)
                //                            .frame(width: 200, height: 100)
                //                            .padding()
                
                
                
                HStack {
                    Image(systemName: "sun.haze")
                        .font(.system(size: 25)).foregroundColor(.white)
                    VStack{
                        
                        //var setDate = Date(weather.sys.sunset * 1000)
                        
                        let setDate = convertTimestamp(TimeInterval(weather.sys.sunset), timezoneOffset: TimeInterval(weather.timezone))
                        
                        
                        Text("Sunset").foregroundColor(.white).bold()
                        Text(setDate).font(.system(size: 15.0))
                            .bold()
                            .foregroundColor(.white)
                    }
                }.padding()
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 100
                    )
                    .background(Color("darkBlue"))
                    .cornerRadius(15)
                
            }.padding()
        }
    }
}

struct SemiCircleView: View {
    var value: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let radius = min(width, height) / 2
            let center = CGPoint(x: width / 2, y: height)
            let angle = Angle(degrees: Double(value / 100 * 180))
            let offset = radius * cos(angle.radians)
            
            ZStack {
                // Left side (blue)
                Path { path in
                    path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(180 + Double(value / 100 * 180)), clockwise: false)
                    path.addLine(to: center)
                }
                .fill(Color.blue)
                
                // Right side (orange)
                Path { path in
                    path.addArc(center: center, radius: radius, startAngle: .degrees(180 + Double(value / 100 * 180)), endAngle: .degrees(360), clockwise: false)
                    path.addLine(to: center)
                }
                .fill(Color.orange)
                
                // Line indicating the value
                Path { path in
                    path.move(to: CGPoint(x: center.x - offset, y: height))
                    path.addLine(to: CGPoint(x: center.x + offset, y: height))
                }
                .stroke(Color.black, lineWidth: 2)
            }
        }
    }
}

struct SunView_Previews: PreviewProvider {
    @State static var weather: ResponseBody = previewWeather
    static var previews: some View {
        SunView(weather: $weather)
    }
}
