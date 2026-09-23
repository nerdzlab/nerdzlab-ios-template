//
//  View+Toastable.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI
import NerdzInject

extension View {
    func toastable() -> some View {
        @ForceInject var toastManager: ToastManager
        return modifier(ToastableModifier(toastManager: toastManager))
    }
}
