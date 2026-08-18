//
//  Widgets.swift
//  weather-macos
//
//  Created by Sebastian Tran on 8/17/26.
//
import SwiftUI

struct WeatherWidget: View {
    
    var temperature: Int?
    
    var body: some View {
        if let temperature {
            let formated = Measurement(value: Double(temperature), unit: UnitTemperature.fahrenheit).formatted()
            
            Text("\(formated)")
                .font(.custom("new york small", size: 50, relativeTo: .body))
                .frame(width: 150, height: 150)
                .background(Color.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.white, lineWidth: 2)
                    
                })
        } else {
            Text("Unknown")
                .frame(width: 150, height: 150)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.white, lineWidth: 2)
                    
                })
        }
    }
}

struct ClockWidget: View {
    
    var body: some View {
        VStack {
            Text(Date.now, format: .dateTime.hour().minute())
                .font(.custom("new york small", size: 25, relativeTo: .body))
                
            
            HStack(alignment: .center) {
                
                Text("1:00")
                    .font(.custom("new york small", size: 35, relativeTo: .body))
                
                Button(action: {
                    print("hi")
                }, label: {
                    Image(systemName: "play")
                        .padding(5)
                        .background(Color.green)
                        .clipShape(.circle)
                    
                })
                .buttonStyle(.plain)
                

            }
        }
            .frame(width: 150, height: 150)
            .background(Color.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.white, lineWidth: 2)
            })
            
    }
}

#Preview {
    HStack{
        WeatherWidget(temperature: 70)
        ClockWidget()
    }
}
