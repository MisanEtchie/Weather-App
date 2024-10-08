//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Misan Etchie on 29/12/2022.
//

import Foundation
import SwiftUI

struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    //let array = ["Checking the sky...", "Fetching weather data...", "Counting clouds...", "Staring directly at the sun..."]
    
    var body: some View {
        
        //VStack {
            
            GeometryReader { (geometry: GeometryProxy) in
                ForEach(0..<5) { index in
                    Group {
                        Circle().foregroundColor(.accentColor)
                            .frame(width: geometry.size.width / 7, height: geometry.size.height / 7)
                            .scaleEffect(calcScale(index: index))
                            .offset(y: calcYOffset(geometry))
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                        .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                        .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                self.isAnimating = true
            }
            
            //Spacer().frame(height: 20)
            
            //Text(array.randomElement()!).frame(width: UIScreen.main.bounds.size.width)
        //}
    }
    
    func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
    
}
