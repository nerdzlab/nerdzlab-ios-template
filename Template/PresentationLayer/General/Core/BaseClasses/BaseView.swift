//
//  BaseView.swift
//  Template
//
//  Created by NerdzLab
//

import UIKit
import Reusable

class BaseView: UIView, NibOwnerLoadable {

    override init(frame: CGRect) {
        super.init(frame: frame)

        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        loadNibContent()
    }
}
