//
//  ForceUpdateScreen.swift
//  Hubmee
//
//  Created by Vasyl Khmil on 23.08.2023.
//

import UIKit
import NerdzAppUpdates

#warning("Redesign in the way app need")

final class ForceUpdateScreen: BaseScreen, HardUpdateScreenType {
    var latestVersion: String?
    
    var onUpdateSelected: EmptyAction?
    
    @IBAction func onUpdateButtonDidPressed() {
        onUpdateSelected?()
    }
}
