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
public struct MaypayButtonBox: View {
    public init(amount: Int, requestId : String) {
        
        self.amount = formatAmount(amount: amount)
        self.requestId = requestId

        try registerFonts()

    }
    
    var amount: String
    var requestId: String
    
    public var body: some View {
        VStack(spacing: 25){
            
            Text("Totale: \(amount) €" )
                .font(.custom("MavenPro-Medium", size: 16))
            
            Image("maypay-logo-png", bundle: Maypay.getBundleModule())
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 190)
            
            VStack(spacing: 2){
                Text("E se fosse gratis?")
                    .font(.custom("MavenPro-Regular", size: 18))
                    .foregroundColor(Color.gray)
                Text("Maypay è l'app per vincere")
                    .font(.custom("MavenPro-Regular", size: 18))
                    .foregroundColor(Color.gray)

                Text("ciò che stai acquistando.")
                    .font(.custom("MavenPro-Regular", size: 18))
                    .foregroundColor(Color.gray)

            }
            
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
        .padding()
    }
}

func formatAmount(amount: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.decimalSeparator = ","
    numberFormatter.groupingSeparator = ""

    if let formattedAmount = numberFormatter.string(from: NSNumber(value: Double(amount) / 100.0)) {
        return formattedAmount
    } else {
        return "--,--"
    }
}
