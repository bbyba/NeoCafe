//
//  ErrorViewModel.swift
//  NeoCafe Client
//

import Moya
import UIKit

protocol ErrorViewModelProtocol {
    var onPreviousViewNavigate: EmptyCompletion? { get set }
}

class ErrorViewModel: NSObject, ErrorViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onPreviousViewNavigate: EmptyCompletion?
}
