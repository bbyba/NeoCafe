//
//  SuccessfulOrderViewModel.swift
//  NeoCafe Staff
//


import Foundation

protocol SuccessfulOrderViewModelProtocol {
    var ongoToOrderNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
}

final class SuccessfulOrderViewModel: SuccessfulOrderViewModelProtocol {
    var ongoToOrderNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
}
