//
//  BranchesModalViewModel.swift
//  NeoCafe Client

import UIKit
import Moya

protocol BranchesModalViewModelProtocol {
    var branchesList: [BranchModel]  { get }
    func getBranches(completion: @escaping (Result<[BranchModel], Error>) -> Void)
    func branchDidSelect(branchID: Int, branchName: String)
}

class BranchesModalViewModel: NSObject, BranchesModalViewModelProtocol {
    var onBranchSelectedNavigate: ((Int, String) -> Void)?
    var branchesList: [BranchModel]
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        self.branchesList = []
    }

    func getBranches(completion: @escaping (Result<[BranchModel], Error>) -> Void) {
        provider.request(.getBranches) { result in
            switch result {
            case .success(let response):
                do {
                    let branchesResponse = try JSONDecoder().decode(BranchesResponse.self, from: response.data)
                    self.branchesList = branchesResponse.results
                    completion(.success(self.branchesList))
                } catch {
                    completion(.failure(error))
                    print("Error decoding: \(error)")
                }
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }

    func branchDidSelect(branchID: Int, branchName: String) {
        onBranchSelectedNavigate?(branchID, branchName)
    }
}

