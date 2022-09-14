//
//  String+.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import Foundation
import UIKit

internal extension String {
    func toSize(with font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}

