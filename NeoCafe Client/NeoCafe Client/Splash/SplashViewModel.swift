//
//  SplashViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol SplahViewModel {
    var onLoginNavigate: EmptyCompletion? { get set }
}

final class SplahViewModelImpl: SplahViewModel {
    var onLoginNavigate: EmptyCompletion?
}
