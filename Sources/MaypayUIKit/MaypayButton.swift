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
    
    public init(requestId: String) {
        self.requestId = requestId
        super.init(frame: .zero)
        commonInit()
        registerFonts()
    }
    
    required init?(coder: NSCoder) {
        self.requestId = ""
        super.init(coder: coder)
        commonInit()
        registerFonts()
    }
    
    var requestId: String
    
    
    private func commonInit() {
                
        addTarget(self, action: #selector(openMaypay), for: .touchUpInside)
    
        let logoImage = UIImage(named: "maypay-logo")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = logoImage?.imageResized(to: CGSize(width: 40, height: 40))
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        setImage(resizedImage, for: .normal)
        
        setTitle("Vinci o paga", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Giorgio", size: 20)
        titleEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .red
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Imposta le dimensioni massime desiderate per il bottone
        let maxWidth: CGFloat = 230
        let maxHeight: CGFloat = 60

        // Limita il frame del bottone alle dimensioni massime
        let constrainedSize = CGSize(width: min(bounds.size.width, maxWidth), height: min(bounds.size.height, maxHeight))
        bounds.size = constrainedSize

        // Centra il contenuto all'interno del bottone
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center

        // Aggiorna il corner radius per renderlo completamente tondo
        layer.cornerRadius = bounds.size.height / 2
        gradientLayer.frame = bounds
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
//        l.frame = self.bounds
        l.colors = [UIColor.hex("00A2E0").cgColor, UIColor.hex("00E091").cgColor]
        l.startPoint = CGPoint(x: 0.5, y: 0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        l.cornerRadius = frame.height / 2
        layer.insertSublayer(l, at: 0)
        return l
    }()
    
    @objc private func openMaypay() {
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
