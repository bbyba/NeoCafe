//
//  CodeConfirmationViewModel.swift
//  NeoCafe Staff
//
import UIKit
import Moya

protocol CodeConfirmationViewModelProtocol {
    var onMainNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
    func authenticateUser(email: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class CodeConfirmationViewModel: NSObject, CodeConfirmationViewModelProtocol {
    var onMainNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
//    let provider: MoyaProvider<UserAPI>

//    init(provider: MoyaProvider<UserAPI>) {
//        self.provider = provider
//    }

    func authenticateUser(email: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        provider.request(.checkEmailLogin(email: email)) { result in
//            self.handleResult(result, completion: completion)
//        }
    }


    //    private func handleResult(_ result: Result<Response, MoyaError>, completion: @escaping (Result<Void, Error>) -> Void) {
    //        switch result {
    //        case .success(let response):
    //            if (200...299).contains(response.statusCode) {
    //                completion(.success(()))
    //            } else {
    //                let errorResponse = NSError(domain: "neocafe.client.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code: \(response.statusCode)"])
    //                completion(.failure(errorResponse))
    //            }
    //        case .failure(let error):
    //            completion(.failure(error))
    //        }
//}


    private func handleResult(_ result: Result<Response, MoyaError>, completion: @escaping (Result<Void, Error>) -> Void) {
        switch result {
        case .success(let response):
            if (200...299).contains(response.statusCode) {
                print("Request succeeded with status code: \(response.statusCode)")
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.success(()))
            } else {
                print("Request completed with error status code: \(response.statusCode)")
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("Error response data: \(responseString)")
                }
                let errorResponse = NSError(domain: "com.neocafe.client.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code: \(response.statusCode)"])
                completion(.failure(errorResponse))
            }

        case .failure(let error):
            print("Networking request failed with error: \(error.localizedDescription)")
            if let response = error.response {
                print("Error status code: \(response.statusCode)")
                if let errorResponseString = String(data: response.data, encoding: .utf8) {
                    print("Error response data: \(errorResponseString)")
                }
            }
            completion(.failure(error))
        }
    }
}
