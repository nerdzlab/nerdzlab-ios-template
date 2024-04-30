//
//  SignInWithEmailScreenType.swift
//  Template
//
//  Created by Vasyl Khmil on 17.03.2024.
//

import UIKit

protocol SignInWithEmailScreenType: BaseScreenType {
    typealias SignInEvent = (_ email: String, _ password: String) -> Void
    
    var onSignIn: SignInEvent? { get set }
    
    @MainActor
    func setData(_ isLoggedInBefore: Bool)
}
