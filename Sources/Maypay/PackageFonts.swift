//
//  File.swift
//  
//
//  Created by Simone Deriu on 19/06/23.
//

import Foundation
import CoreGraphics
import CoreText

public struct PackageFonts {
    public static func registerFonts() {
        // Ottieni il percorso del bundle del tuo package
        guard let resourcesURL = Bundle.main.resourceURL?.appendingPathComponent("YourPackageBundle.bundle") else {
            fatalError("Bundle del package non trovato")
        }

        let fontURLs = try! FileManager.default.contentsOfDirectory(at: resourcesURL, includingPropertiesForKeys: nil, options: [])

        for fontURL in fontURLs {
            guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
                fatalError("Impossibile caricare il font: \(fontURL.lastPathComponent)")
            }

            guard let font = CGFont(fontDataProvider) else {
                fatalError("Impossibile creare il font: \(fontURL.lastPathComponent)")
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                let errorDescription = CFErrorCopyDescription(error!.takeUnretainedValue())
                fatalError("Impossibile registrare il font: \(fontURL.lastPathComponent). Errore: \(String(describing: errorDescription))")
            }
        }
    }
}
