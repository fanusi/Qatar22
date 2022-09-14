//
//  UILabel+.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func customLabel1(yvalue: CGFloat, height: CGFloat, width: CGFloat, fontsize: CGFloat, text: String) {
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        //self.lineBreakMode = .byWordWrapping
        self.frame = CGRect(x: 10, y: yvalue, width: width - 20, height: height)
        self.numberOfLines = 2
        self.font = UIFont(name: font1, size: fontsize)
        //self.backgroundColor = .white
        self.text = text
        self.adjustsFontSizeToFitWidth = true
        //self.layer.opacity = 0.95

    }

}
