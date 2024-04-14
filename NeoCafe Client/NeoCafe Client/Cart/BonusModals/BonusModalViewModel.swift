//
//  BonusModalViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol BonusModalViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion? { get set }
}

class BonusModalViewModel: NSObject, BonusModalViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion?
}
