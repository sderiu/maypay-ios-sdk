// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import SwiftUI
import UIKit
import CoreGraphics
import CoreText

public func canOpenMaypay() -> Bool {
    
    let url = URL(string: "maypay://")
    
    if let url = url {
        return UIApplication.shared.canOpenURL(url)
    }
    else{
        return false
    }
    
}

public func openMaypay(requestId: String) {
    if let url = URL(string: "maypay://paymentRequest?id=\(requestId)") {
        if(UIApplication.shared.canOpenURL(url)){
            UIApplication.shared.open(url)
        }
        else{
            if let appStoreUrl = URL(string: "https://apps.apple.com/app/maypay/id1625065819") {
                UIApplication.shared.open(appStoreUrl)
            }
        }
    }
}

public func registerFonts(){
    let fontFolderName = "Resources" // Il nome della cartella che contiene i font
    
    guard let fontFolderURL = Bundle.main.url(forResource: fontFolderName, withExtension: nil) else {
        fatalError("Impossibile trovare la cartella dei font")
    }
    
    
    let fontFileURLs = try? FileManager.default.contentsOfDirectory(at: fontFolderURL, includingPropertiesForKeys: nil)
    
    if let fontFileURLs = fontFileURLs{
        for fontFileURL in fontFileURLs {
            guard let fontData = try? Data(contentsOf: fontFileURL) else {
                fatalError("Impossibile caricare i dati del font: \(fontFileURL.lastPathComponent)")
            }
            
            guard let provider = CGDataProvider(data: fontData as CFData) else {
                fatalError("Impossibile creare il provider dei dati del font: \(fontFileURL.lastPathComponent)")
            }
            
            guard let font = CGFont(provider) else {
                fatalError("Impossibile creare il font: \(fontFileURL.lastPathComponent)")
            }
            
            CTFontManagerRegisterGraphicsFont(font, nil)
        }
    }
    
}
