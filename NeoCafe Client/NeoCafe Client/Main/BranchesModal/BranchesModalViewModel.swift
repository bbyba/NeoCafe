//
//  BranchesModalViewModel.swift
//  NeoCafe Client

import UIKit
import Moya

protocol BranchesModalViewModelProtocol {
    var branchesList: [BranchModel]  { get }
    func branchDidSelect(branchID: Int, branchName: String)
}

class BranchesModalViewModel: NSObject, BranchesModalViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBranchesFetched: EmptyCompletion?
    var onBranchSelectedNavigate: ((Int, String) -> Void)?
    var branchesList: [BranchModel]

    override init() {
        self.branchesList = []
    }
    
    func getBranches() {
        networkService.sendRequest(successModelType: BranchesResponse.self,
                                   endpoint: MultiTarget(UserAPI.getBranches))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.branchesList = response.results
                    self.onBranchesFetched?()
                }
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }

    func branchDidSelect(branchID: Int, branchName: String) {
        UserDefaultsService.shared.branchID = branchID
        UserDefaultsService.shared.branchName = branchName
        onBranchSelectedNavigate?(branchID, branchName)
    }
}

