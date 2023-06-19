// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import SwiftUI
import UIKit

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
