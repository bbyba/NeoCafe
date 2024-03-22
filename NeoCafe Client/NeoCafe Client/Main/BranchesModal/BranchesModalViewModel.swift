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
    var onBranchesSelectedNavigate: ((Int, String) -> Void)?
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
                    self.branchesList = try JSONDecoder().decode([BranchModel].self, from: response.data)
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
        onBranchesSelectedNavigate?(branchID, branchName)
    }
}

