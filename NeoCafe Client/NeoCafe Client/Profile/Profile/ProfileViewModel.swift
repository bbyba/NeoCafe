//
//  ProfileViewModel.swift
//  NeoCafe Client
//
import UIKit
import Moya

protocol ProfileViewModelProtocol {
    var onEditProfileNavigate: EmptyCompletion? { get set }
//    var onSearchNavigate: EmptyCompletion? { get set }
    var personalData: [BranchModel]  { get }
//    func getPersonalData(completion: @escaping (Result<[BranchModel], Error>) -> Void)
}


class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    var onEditProfileNavigate: EmptyCompletion?
    var personalData: [BranchModel]
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        self.personalData = []
    }

//    func getPersonalData(completion: @escaping (Result<[BranchModel], Error>) -> Void) {
//        provider.request(.get) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    self.branchesList = try JSONDecoder().decode([BranchModel].self, from: response.data)
//                    print("Received JSON: \(String(data: response.data, encoding: .utf8) ?? "Invalid JSON")")
//                    completion(.success(self.branchesList))
//                } catch {
//                    completion(.failure(error))
//                    print("Error decoding: \(error)")
//                }
//            case .failure(let error):
//                completion(.failure(error))
//
//            }
//        }
//    }
}



