//
//  SecondaryPlaceholderScreen.swift
//  Hubmee
//
//  Created by Vasyl Khmil on 03.12.2023.
//

import UIKit

class SecondaryPlaceholderScreen: BaseScreen {
    
    var placeholder: String? {
        didSet {
            afterViewLoaded { [weak self] in
                self?.textLabel.text = self?.placeholder
            }
        }
    }
    
    @IBOutlet private var textLabel: UILabel!
}
