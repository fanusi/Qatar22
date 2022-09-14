//
//  UIView+.swift
//  ForwardPlus
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func updateHeightConstraint(newHeight: CGFloat, identifier: String) {
        
        for constraint in self.constraints {
            if constraint.identifier == identifier {
               constraint.constant = newHeight
            }
        }
        self.layoutIfNeeded()
        
    }
    
    func insertLabel1(text: String, font: String, fontsize: CGFloat, middle: Bool) {
        
        let newLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        newLabel.font = UIFont(name: font1, size: fontsize)
        newLabel.text = text
        newLabel.adjustsFontSizeToFitWidth = true
        newLabel.layer.opacity = 1
        
        if middle {
            newLabel.textAlignment = .center
        }
        
        self.addSubview(newLabel)
    
    }
    
    func backgroundColorSubViews(BackColor: UIColor) {
        
        self.subviews.forEach { (item) in
            item.subviews.forEach { (item2) in
                item2.subviews.forEach { (item3) in
                    item3.subviews.forEach { (item4) in
                        item4.backgroundColor = BackColor
                    }
                }
            }
        }
        
    }
    
}
