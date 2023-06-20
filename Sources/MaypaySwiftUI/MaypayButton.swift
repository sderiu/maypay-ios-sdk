//
//  File.swift
//
//
//  Created by Simone Deriu on 19/06/23.
//

import Foundation
import SwiftUI
import Maypay

@available(iOS 13.0.0, *)
public struct MaypayButton: View {
    
    public init(requestId : String) {
        
        self.requestId = requestId
        
        registerFonts()
        
    }
    
    var requestId: String
    
    public var body: some View {
        
        Button(action: {
            openMaypay(requestId: self.requestId)
        }, label: {
            HStack(alignment: .center){
                Image("maypay-logo", bundle: Maypay.getBundleModule())
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("Vinci o paga")
                    .foregroundColor(.white)
                    .font(.custom("Giorgio", size: 20))
                    .offset(y: 2)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(
                LinearGradient(colors: [Color.hex("00E091"), Color.hex("00A2E0")], startPoint: .bottom, endPoint: .top)
            )
            .clipShape(RoundedRectangle(cornerRadius: 50))
        })
        
    }
}

extension Color {
    static func hex(_ hex: String) -> Color  {
        var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "")
        
        if colorString.count != 6 {
            return .clear
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        return Color(red: red, green: green, blue: blue)
    }
}
