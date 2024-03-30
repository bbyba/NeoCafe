//
//  BranchDetailViewModel.swift
//  NeoCafe Client
//

import Foundation
import Moya

protocol BranchesDetailViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onMenuNavigate: EmptyCompletion? { get set }
    var branch: BranchModel? { get }
    var suggestionItems: [Item] { get }
    func getSuggestionItems(branchID: Int, completion: @escaping (Result<[Item], Error>) -> Void)
}

class BranchDetailViewModel: NSObject, BranchesDetailViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onMenuNavigate: EmptyCompletion?
    var branch: BranchModel?
    var suggestionItems: [Item] = []
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
    }

    func getSuggestionItems(branchID: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
        provider.request(.getPopularItems(branchID: branchID)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let suggestionItems = try JSONDecoder().decode([Item].self, from: response.data)
                        self?.suggestionItems = suggestionItems
                        completion(.success(suggestionItems))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

}
