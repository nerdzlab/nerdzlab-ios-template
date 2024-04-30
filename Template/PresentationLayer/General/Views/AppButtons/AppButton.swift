//
//  AppButton.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit
import NerdzUtils

class AppButton: LoadableButton {
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
