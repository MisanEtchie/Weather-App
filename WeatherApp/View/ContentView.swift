//
//  ContentView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 18/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var location: String = ""
    @FocusState private var locationIsFocused: Bool
    
    var body: some View {
        
        ZStack {
            Color("bgColor").ignoresSafeArea()
        
            
            VStack {
                
                // header
                HStack {
                    Button(action: {
                        print("Refresh")
                    }) {
                        Label("", systemImage: "safari").font(.system(size: 24))
                    }
                    
                    TextField("Search Location...", text: $location).textInputAutocapitalization(.words)
                        .padding(8)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                        .submitLabel(.done)
                        .focused($locationIsFocused)
                        .onSubmit {
                            searchPressed()
                                    }
                    
                    Button(action: {
                        searchPressed()
                        locationIsFocused = false
                    }) {
                        Label("", systemImage: "magnifyingglass").font(.system(size: 24))
                    }
                }.padding() // nav bar
        
                HStack{ Text("Lagos").font(.largeTitle).foregroundColor(Color("headerText"))
                    .bold()
                    
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)//header
                
                ScrollView {
                WeatherView()
                
                StatsView()
                }
                
        } // main vstack
         // geo reader
        } // zstack
    }//main view
    
    func searchPressed() {
        if location != "" {
            print($location)
            location = ""
        } else {
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
        ContentView()
            .previewDevice("iPhone SE")
    }
}
