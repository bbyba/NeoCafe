//
//  BranchesViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol BranchesViewModelProtocol {
    var onBranchesDetailNavigate: EmptyCompletion? { get set }
//    var onSearchNavigate: EmptyCompletion? { get set }
    var branchesList: [BranchModel]  { get }
    func getBranches(completion: @escaping (Result<[BranchModel], Error>) -> Void)
}


class BranchesViewModel: NSObject, BranchesViewModelProtocol {
    var onBranchesDetailNavigate: EmptyCompletion?
    var branchesList: [BranchModel]
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        self.branchesList = []
    }

    func getBranches(completion: @escaping (Result<[BranchModel], Error>) -> Void) {
        provider.request(.getCategories) { result in
            switch result {
            case .success(let response):
                do {
                    self.branchesList = try JSONDecoder().decode([BranchModel].self, from: response.data)
                    print("Received JSON: \(String(data: response.data, encoding: .utf8) ?? "Invalid JSON")")

                    //                    print("Fetched branchesList:")
                    //                    self.branchesList.forEach { branch in
                    //                        // Potentially add more detailed print statements here to log each fetched branch.
                    //                        print(branch.branch_name)
                    //                    }

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
}








//
////
////  BranchesViewModel.swift
////  NeoCafe Client
////
//
//import UIKit
//import Moya
//
//protocol BranchesViewModelProtocol {
//    var onBranchesDetailNavigate: EmptyCompletion? { get set }
////    var onSearchNavigate: EmptyCompletion? { get set }
//    var branchesList: [BranchModel]  { get }
//    func getBranches(completion: @escaping (Result<[BranchModel], Error>) -> Void)
//}
//
//
//class BranchesViewModel: NSObject, BranchesViewModelProtocol {
//    var onBranchesDetailNavigate: EmptyCompletion?
//    var branchesList: [BranchModel]
////    let provider: MoyaProvider<UserAPI>
//    private let networkService: NetworkService
//
//
//    override init() {
//        self.networkService = NetworkService()
//        self.branchesList = []
//    }
//
//    func getBranches(completion: @escaping (Result<[BranchModel], Error>) -> Void) {
//            networkService.performRequest(for: .getCategories) { (result: Result<[BranchModel], Error>) in
//                switch result {
//                case .success(let branches):
//                    self.branchesList = branches
//                    completion(.success(self.branchesList))
//                case .failure(let error):
//                    print("Error fetching: \(error)")
//                    completion(.failure(error))
//                }
//            }
//        }
//}
