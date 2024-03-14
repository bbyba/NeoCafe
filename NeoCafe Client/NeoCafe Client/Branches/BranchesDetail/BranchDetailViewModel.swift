//
//  BranchDetailViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol BranchesDetailViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var branch: BranchModel? { get }
    var onMenuNavigate: EmptyCompletion? { get set }

}

class BranchDetailViewModel: NSObject, BranchesDetailViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var branch: BranchModel?
    var onMenuNavigate: EmptyCompletion?
}
