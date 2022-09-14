//
//  Filtering.swift
//  Qatar_1
//
//  Created by Stéphane Trouvé on 09/09/2022.
//

import Foundation
import UIKit

class Filtering {
    public var viewControllers: [UIViewController] = []
    public var titles: [String] = []

    init(items: [TabItem]) {
        split(items: items)
    }

    func split(items: [TabItem]) {
        for item in items {
            viewControllers.append(item.viewController)
            titles.append(item.title)
        }
    }
}
