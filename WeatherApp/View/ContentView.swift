//
//  ContentView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 18/12/2022.
//

import SwiftUI
//import CoreLocation

struct ContentView: View {
    
    var weatherManager = WeatherManager()
    
    @State var weather: ResponseBody
    @State var showingAlert: Bool = false
    
    
    @State private var location: String = ""
    
    @State private var savedLocation: String = UserDefaults.standard.string(forKey: "LoctionKey") ?? "New York"
    
    @FocusState private var locationIsFocused: Bool
    
    var body: some View {
        
        if weather.name == "DefaultWeatherValue" {
            
            ActivityIndicator()
                .frame(width: 100, height: 100)
                .onAppear(perform: {
                location = savedLocation
                    update()
                })
            
        } else {
        
        ZStack {
            Color("bgColor").ignoresSafeArea()
            
            VStack {
                
                // header
                HStack {
                    
                    Image(systemName: "safari").font(.system(size: 24)).foregroundColor(.accentColor)
                    
                    /*Button(action: {
                        
                    }) {
                        Label("", systemImage: "safari").font(.system(size: 24))
                    }*/
                    
                    TextField("Search Location...", text: $location).textInputAutocapitalization(.words)
                        .padding(8)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                        .submitLabel(.done)
                        .focused($locationIsFocused)
                        .onSubmit {
                            update()
                            locationIsFocused = false
                        }
                    
                    Button(action: {
                        update()
                        //searchPressed()
                        locationIsFocused = false
                    }) {
                        Label("", systemImage: "magnifyingglass").font(.system(size: 24))
                    }
                }.padding() // nav bar
                
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .firstTextBaseline, spacing: 0){
                        Text(weather.name).font(.largeTitle).foregroundColor(Color("headerText"))
                            .bold()
                        
                        Text(", " + weather.sys.country).font(.title3).foregroundColor(Color("headerText"))
                            .bold()
                    }
                    
                    Text("Today, \(Date().formatted(.dateTime.day().month().hour().minute()))").font(.footnote).foregroundColor(Color("headerText"))
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)//header
                
                ScrollView {
                    WeatherView(weather: $weather)
                    
                    StatsView(weather: $weather)
                }
                
            } // main vstack
            // geo reader
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Location not found "),
                message: Text("Please try again"),
                dismissButton: .default(Text("Got it!")))
        } // zstack
        
        }
    }//main view
    
    func searchPressed() async {
        do {
            if location != "" {
                
                var checkWeather = try await weatherManager.getCurrentManager(location: location.trimmingCharacters(in: .punctuationCharacters).replacingOccurrences(of: " ", with: "%20"))
                
                if checkWeather.name == "Error Message"  {
                    showingAlert = true
                } else {
                    weather = checkWeather
                }
                
                UserDefaults.standard.set(location, forKey: "LoctionKey")
                savedLocation = location
                print($location)
                location = ""
            } else {
                return
            }
        } catch {
            print("error")
        }
    }
    
    
    
    func update() {
        if (weather.name == "Error Message") {
            showingAlert = true
        } else {
        Task {
            do {
                try await
                searchPressed()
            } catch {
                print("error")
            }
        }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weather: previewWeather)
            .previewDevice("iPhone 13")
        ContentView(weather: previewWeather)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone SE")
    }
}
