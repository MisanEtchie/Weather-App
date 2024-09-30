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
    @State var forecast: ForecastBody
    @State var showingAlert: Bool = false
    
    @State var showingPanel: Bool = false
    
    
    @State private var location: String = ""
    
    @State private var savedLocation: String = UserDefaults.standard.string(forKey: "LoctionKey") ?? "New York"
    
    @State private var savedUnit: String = UserDefaults.standard.string(forKey: "UnitKey") ?? "Imperial"
    
    
    @State private var isChanging: Bool = false
    
    @FocusState private var locationIsFocused: Bool
    
    //@State private var selectedUnit: String = "Metric"
    
    //@EnvironmentObject var settings: Settings
    
//    init(weather: ResponseBody = previewWeather, forecast: ForecastBody = previewForecast) {
//            self._weather = State(initialValue: weather)
//            self._forecast = State(initialValue: forecast)
//            // Retrieve the selected unit from UserDefaults when the view is initialized
//            settings.selectedUnit = UserDefaults.standard.string(forKey: "UnitKey") ?? "Metric" // Default to Metric
//        }
    
    
    var body: some View {
        
        if weather.name == "DefaultWeatherValue" {
            
            ActivityIndicator()
                .frame(width: 100, height: 100)
                .onAppear(perform: {
                    location = savedLocation
                    update(unit: savedUnit.lowercased())
                })
            
        } else {
            
            ZStack {
                Color("bgColor").ignoresSafeArea()
                
                VStack {
                    
                    // header
                    HStack {
                        
                        Button(action: {
                                                    showingPanel = true // Show the alert when button is pressed
                                                }) {
                                                    Text(savedUnit == "Metric" ? "°C" : "°F")
                                                        .fontWeight(.heavy)
                                                        .font(.headline)
                                                        .padding(8)
                                                        
                                                        .frame(width: 46)
                                                        .background(Color.gray.opacity(0.2))
                                                        .cornerRadius(8)
                                                }
                                                .alert("Select Unit", isPresented: $showingPanel) {
                                                    Button("Metric") {
                                                        savedUnit = "Metric"
                                                                                        UserDefaults.standard.set("Metric", forKey: "UnitKey")
                                                        update(unit: "Metric")
                                                        
                                                    }
                                                    Button("Imperial") {
                                                        savedUnit = "Imperial"
                                                                                        UserDefaults.standard.set("Imperial", forKey: "UnitKey")
                                                        update(unit: "Imperial")
                                                        print("dd")
                                                    }
                                                    Button("Cancel", role: .cancel) { }
                                                }
                        
                        
                        
//                        Image(systemName: "safari").font(.system(size: 24)).foregroundColor(.accentColor)
//                        
//                        /*Button(action: {
//                         
//                         }) {
//                         Label("", systemImage: "safari").font(.system(size: 24))
//                         }*/
                        
                        TextField("Search Location...", text: $location).textInputAutocapitalization(.words)
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                            .submitLabel(.done)
                            .focused($locationIsFocused)
                            .onSubmit {
                                update(unit: savedUnit.lowercased())
                                locationIsFocused = false
                            }
                        
                        Button(action: {
                            update(unit: savedUnit.lowercased())
                            //searchPressed()
                            locationIsFocused = false
                        }) {
                            Label("", systemImage: "magnifyingglass").font(.system(size: 24))
                        }
                    }
                    //.padding()
                    .padding(.top)
                    .padding(.horizontal)
                    // nav bar
                    
                    
                    
                    TabView {
                        WeatherPageView(weather: $weather, unit: savedUnit)
                            .refreshable {
                                refreshWeather()
                            }
                        ForecastPageView(weather: $weather, forecast: $forecast, unit: savedUnit)
                            .refreshable {
                                refreshWeather()
                            }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .onAppear {
                          setupAppearance()
                        }
                    
                    
                    
                }.ignoresSafeArea(edges: .bottom) // main vstack
                // geo reader
            }.alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Location not found "),
                    message: Text("Please try again"),
                    dismissButton: .default(Text("Got it!")))
            } // zstack
            
        }
        
    }//main view
    
    func setupAppearance() {
        if let accentColor = UIColor(named: "AccentColor") {
                    UIPageControl.appearance().currentPageIndicatorTintColor = accentColor
                }
      }
    
    func searchPressed(unit: String) async {
        print("Search pressed with unit: \(unit)") // Debug line
        do {
            // Check if the trimmed location is empty
            let trimmedLocation = location.trimmingCharacters(in: .punctuationCharacters).replacingOccurrences(of: " ", with: "%20")
            
            // If the trimmed location is empty, use the saved location
            if trimmedLocation.isEmpty {
                location = UserDefaults.standard.string(forKey: "LoctionKey") ?? "New York" // Default fallback if UserDefaults value is also nil
            }

            // Now use the updated location
            let finalLocation = location.trimmingCharacters(in: .punctuationCharacters).replacingOccurrences(of: " ", with: "%20")
            
            // Continue with your API calls
            var checkWeather = try await weatherManager.getCurrentManager(location: finalLocation, unit: unit)
            var checkForecast = try await weatherManager.getCurrentForecast(location: finalLocation, unit: unit)
            
            if checkWeather.name == "Error Message" || checkForecast.message == 1234567890 {
                showingAlert = true
            } else {
                weather = checkWeather
                forecast = checkForecast
                print("successful") // This should now print if everything works
            }
            
            UserDefaults.standard.set(location, forKey: "LoctionKey")
            savedLocation = location
            print(savedLocation) // Use savedLocation for clarity
            location = ""
        } catch {
            print("error")
        }
    }

    
    
    
    func update(unit: String) {
        //isChanging = true
        if (weather.name == "Error Message") {
            showingAlert = true
        } else {
            Task {
                do {
                    try await
                    searchPressed(unit: unit)
                    print("is done")
                    //isChanging = false
                } catch {
                    print("error")
                    
                   // isChanging = false
                }
                //isChanging = false
            }
        }
    }
    
    private func refreshWeather() {
            Task {
                await update(unit: savedUnit)
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weather: previewWeather, forecast: previewForecast)
            .previewDevice("iPhone 13")
        ContentView(weather: previewWeather, forecast: previewForecast)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone SE")
    }
}
