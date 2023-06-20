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
    do{
        try registerFont(named: "MavenPro-Medium")
        try registerFont(named: "MavenPro-Regular")
        try registerFont(named: "Giorgio")
    }
    catch{
        print("Cannot register fonts")
    }
}

func registerFont(named name: String) throws {
    guard let fontURL = Bundle.module.url(forResource: name, withExtension: "ttf") else {
        fatalError("Couldn't find font \(name)")
    }

    guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
        fatalError("Couldn't load data from the font \(name)")
    }
    guard let font = CGFont(fontDataProvider) else {
        fatalError("Cannot create font")
    }
    
    let registered = CTFontManagerRegisterGraphicsFont(font, nil)
    
    print(registered)
}


public func getBundleModule() -> Bundle {
    
    return Bundle.module
}

public enum FontError: Swift.Error {
   case failedToRegisterFont
}
