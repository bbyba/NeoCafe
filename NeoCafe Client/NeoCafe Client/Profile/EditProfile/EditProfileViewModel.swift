//
//  EditProfileViewModel.swift
//  NeoCafe Client
//

import Foundation
import Moya

protocol EditProfileViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onEditCompleted: EmptyCompletion? { get set }
    var personalDataEdit: CustomerProfile?  { get }
    func getPersonalDataEdit(completion: @escaping (Result<CustomerProfile, Error>) -> Void)
}

class EditProfileViewModel: NSObject, EditProfileViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onEditCompleted: EmptyCompletion?
    var personalDataEdit: CustomerProfile?
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        self.personalDataEdit = nil
    }

    func getPersonalDataEdit(completion: @escaping (Result<CustomerProfile, Error>) -> Void) {
        provider.request(.getProfileEdit(userID: 18)) { result in
            switch result {
            case .success(let response):
                do {
                    self.personalDataEdit = try JSONDecoder().decode(CustomerProfile.self, from: response.data)
                    print("Received JSON Edit: \(String(data: response.data, encoding: .utf8) ?? "Invalid JSON")")
                    completion(.success(self.personalDataEdit!))
                } catch {
                    completion(.failure(error))
                    print("Error decoding: \(error)")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func patchProfile(firstName: String, completion: @escaping (Result<CustomerProfile, Error>) -> Void) {
        provider.request(.patchProfile(userID: 18, firstName: firstName)) { result in
            switch result {
            case .success(let response):
                do {
                    let updatedProfile = try JSONDecoder().decode(CustomerProfile.self, from: response.data)
                    completion(.success(updatedProfile))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
