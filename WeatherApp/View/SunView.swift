//
//  SunView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 19/12/2022.
//

import SwiftUI

struct SunView: View {
    @Binding var weather: ResponseBody
    
    
    var body: some View {
        
                        
        
        HStack {
            
            HStack {
                Image(systemName: "sun.min")
                    .font(.system(size: 50)).foregroundColor(.white)
                VStack{
                    
                    var riseDate = Date.init(timeIntervalSinceNow: TimeInterval(weather.sys.sunrise))
                    
                    Text("Sunrise").foregroundColor(.white).bold()
                    Text("\(riseDate.formatted(.dateTime.hour().minute()))").font(.system(size: 15.0)).bold().foregroundColor(.white)
                }
            }.padding()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 130
                )
                .background(Color("orange"))
                .cornerRadius(15)
                //.padding(.trailing, 12)
            
            HStack {
                Image(systemName: "sun.haze")
                    .font(.system(size: 40)).foregroundColor(.white)
                VStack{
                    
                    //var setDate = Date(weather.sys.sunset * 1000)
                    
                    var setDate = Date.init(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
                    
                    Text("Sunset").foregroundColor(.white).bold()
                    Text("\(setDate.formatted(.dateTime.hour().minute()))").font(.system(size: 15.0)).bold().foregroundColor(.white)
                }
            }.padding()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 130
                )
                .background(Color("darkBlue"))
                .cornerRadius(15)
            
        }.padding()
    }
}

struct SunView_Previews: PreviewProvider {
    @State static var weather: ResponseBody = previewWeather
    static var previews: some View {
        SunView(weather: $weather)
    }
}
