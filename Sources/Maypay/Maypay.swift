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

public func registerFonts() {
    
    registerFont(bundle: .module, fontName: "MavenPro-Medium", fontExtension: "ttf")
    registerFont(bundle: .module, fontName: "MavenPro-Regular", fontExtension: "ttf")
    registerFont(bundle: .module, fontName: "Giorgio", fontExtension: "ttf")

}

fileprivate func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
        fatalError("Couldn't create font from data")
    }
    
    var error: Unmanaged<CFError>?
    
    CTFontManagerRegisterGraphicsFont(font, &error)
}
