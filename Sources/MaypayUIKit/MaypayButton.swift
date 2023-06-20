//
//  File.swift
//
//
//  Created by Simone Deriu on 19/06/23.
//

import Foundation
import UIKit
import Maypay

public class MaypayButton: UIButton {
    private let buttonWidth: CGFloat = 240
    private let buttonHeight: CGFloat = 60
    private let bundle: Bundle = Maypay.getBundleModule()
    
    private var requestId: String
    
    // Inizializzatore personalizzato con requestId
    public init(requestId: String) {
        self.requestId = requestId
        
        let screenWidth = UIScreen.main.bounds.width
        super.init(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        
        // Aggiungi l'azione al pulsante
//        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        adjustsImageWhenHighlighted = false

        // Configura l'immagine predefinita del pulsante
        let logoImage = UIImage(named: "maypay-logo", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        let resizedImage = logoImage?.imageResized(to: CGSize(width: 40, height: 40))
        setImage(resizedImage, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        
        // Configura il testo predefinito del pulsante
        setTitle("Vinci o paga", for: .normal)
        
        // Configura le proprietà del pulsante
        setTitleColor(.white, for: .normal)
        if UIFont.registerFont(bundle: bundle, fontName: "Giorgio", fontExtension: "ttf") {
            titleLabel?.font = UIFont(name: "Giorgio", size: 20)
            titleEdgeInsets = UIEdgeInsets(top: 4, left: 5, bottom: 0, right: 0)
        }
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layer.cornerRadius = buttonHeight / 2
        
        
        // Aggiungi il gradiente come sfondo del pulsante
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.hex("00A2E0").cgColor, UIColor.hex("00E091").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.cornerRadius = frame.height / 2
        layer.insertSublayer(gradientLayer, below: imageView?.layer)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.requestId = ""
        super.init(coder: aDecoder)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateOpacity(to: 0.2)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateOpacity(to: 1.0)
        if let touch = touches.first, bounds.contains(touch.location(in: self)) {
            // Il tocco è terminato all'interno dei confini del pulsante
            buttonTapped()
        }
    }
    
    private func animateOpacity(to opacity: CGFloat) {
          UIView.animate(withDuration: 0.2) {
              self.alpha = opacity
          }
      }
    
    // Funzione chiamata quando il pulsante viene premuto
    @objc private func buttonTapped() {
        // Gestisci l'azione del pulsante qui, utilizzando la variabile requestId se necessario
        Maypay.openMaypay(requestId: requestId)
    }
}

extension UIColor {
    static func hex(_ hex: String) -> UIColor {
        var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "")
        
        if colorString.count != 6 {
            return .clear
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIFont {
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }
        
        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }
        
        return true
    }
}
