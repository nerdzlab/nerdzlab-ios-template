//
//  OnboardingStartScreen.swift
//  SwiftUIProjectTemplate
//
//  Created by Roman Kovalchuk on 18.03.2026.
//

import SwiftUI

struct OnboardingStartScreen<ViewModel: OnboardingStartViewModelType>: View {
    
    // MARK: - Aliases
    
    typealias ViewModelCreateAction = () -> ViewModel
    
    // MARK: - Properties(public)
    
    var body: some View {
        Text("OnboardingStartScreen")
    }
    
    // MARK: - Properties(private)
    
    @State private var viewModel: ViewModel
    
    // MARK: - Initializers
    
    init(viewModelCreateAction: @autoclosure @escaping ViewModelCreateAction) {
        self._viewModel = .init(wrappedValue: viewModelCreateAction())
    }
}

#Preview {
    OnboardingStartScreen(viewModelCreateAction: OnboardingStartViewModel())
}
