//
//  CoffeeDetailsViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol CoffeeDetailsViewModelProtocol {
    var onMilkSyrupSelectedNavigate: EmptyCompletion? { get set }
    var onSaveNavigate: EmptyCompletion? { get set }

}

class CoffeeDetailsViewModel: NSObject, CoffeeDetailsViewModelProtocol {
    var onMilkSyrupSelectedNavigate: EmptyCompletion?
    var onSaveNavigate: EmptyCompletion?

    func selectMilkOption(index: Int) {

    }

    func selectSyrupOption(index: Int) {

    }

}
