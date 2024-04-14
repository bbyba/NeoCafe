//
//  BranchesViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol BranchesViewModelProtocol {
    var onBranchDetailNavigate: ((Int) -> Void)? { get set }
    var branchesList: [BranchModel]  { get }
}

class BranchesViewModel: NSObject, BranchesViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBranchDetailNavigate: ((Int) -> Void)?
    var onBranchesFetched: EmptyCompletion?
    var branchesList: [BranchModel]

    override init() {
        self.branchesList = []
    }

    func getBranches() {
        networkService.sendRequest(successModelType: BranchesResponse.self,
                                   endpoint: MultiTarget(UserAPI.getBranches))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.branchesList = response.results
                    self.onBranchesFetched?()
                }
            case .failure(let error):
                print("Error fetching menu items: \(error)")
            }
        }
    }
}



