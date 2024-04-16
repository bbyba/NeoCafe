//
//  ErrorViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol ErrorViewModelProtocol {
    var onPreviousViewNavigate: EmptyCompletion? { get set }
}

class ErrorViewModel: NSObject, ErrorViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onPreviousViewNavigate: EmptyCompletion?
}
