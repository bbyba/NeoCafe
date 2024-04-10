//
//  SplashViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol SplashViewModelProtocol {
    var onLoginNavigate: EmptyCompletion? { get set }
    func toLoginNavigate()
}

final class SplashViewModel: NSObject, SplashViewModelProtocol {
    var onLoginNavigate: EmptyCompletion?

    func toLoginNavigate() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100)) {
            self.onLoginNavigate?()
        }
    }
}
