//
//  BranchesViewModel.swift
//  NeoCafe Client
//

import Moya
import UIKit

protocol BranchesViewModelProtocol {
    var onBranchDetailNavigate: ((Int) -> Void)? { get set }
    var branchesList: [BranchModel] { get }
}

class BranchesViewModel: NSObject, BranchesViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBranchDetailNavigate: ((Int) -> Void)?
    var onBranchesFetched: EmptyCompletion?
    var branchesList: [BranchModel]

    override init() {
        branchesList = []
    }

    func getBranches() {
        networkService.sendRequest(successModelType: BranchesResponse.self,
                                   endpoint: MultiTarget(UserAPI.getBranches))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.branchesList = response.results
                    self.onBranchesFetched?()
                }
            case let .failure(error):
                print("Error fetching menu items: \(error)")
            }
        }
    }
}
