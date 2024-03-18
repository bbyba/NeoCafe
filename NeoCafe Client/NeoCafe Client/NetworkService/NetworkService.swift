//
//  NetworkService.swift
//  NeoCafe Client
//
import Foundation
import Moya

class NetworkService {
    // Moya provider initialized with your UserAPI enum
    private let provider = MoyaProvider<UserAPI>()

    // Generic function to perform a request and decode the response
    func performRequest<T: Decodable>(for target: UserAPI, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                    DispatchQueue.main.async {
                        completion(.success(decodedResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
