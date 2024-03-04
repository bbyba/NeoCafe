//
//  SplashViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol SplashViewModel {
    var onLoginNavigate: EmptyCompletion? { get set }
    func toLoginNavigate()
}

final class SplashViewModelImpl: SplashViewModel {
    var onLoginNavigate: EmptyCompletion?

    func toLoginNavigate() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100)) {
            self.onLoginNavigate?()
        }
    }
}
