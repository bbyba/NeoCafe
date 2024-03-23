//
//  ProfileViewModel.swift
//  NeoCafe Client
//
import UIKit
import Moya

protocol ProfileViewModelProtocol {
    var onEditProfileNavigate: EmptyCompletion? { get set }
    var personalData: CustomerProfile?  { get }
    var orders: [Order]?  { get }
    func getPersonalData(completion: @escaping (Result<CustomerProfile, Error>) -> Void)
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    var onEditProfileNavigate: EmptyCompletion?
    var personalData: CustomerProfile?
    var orders: [Order]?
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        self.personalData = nil
    }

    func getPersonalData(completion: @escaping (Result<CustomerProfile, Error>) -> Void) {
        provider.request(.getProfile(userID: 13)) { result in
            switch result {
            case .success(let response):
                do {
                    self.personalData = try JSONDecoder().decode(CustomerProfile.self, from: response.data)
                    print("Received JSON: \(String(data: response.data, encoding: .utf8) ?? "Invalid JSON")")
                    completion(.success(self.personalData!))
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



