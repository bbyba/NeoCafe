//
//  NetworkService.swift
//  NeoCafe Client

import Foundation
import Moya

enum UserService {
    case registerUser(email: String, confirmationCode: Int)
    case loginUser(email: String, confirmationCode: Int)
    case checkEmailRegister(email: String)
    case checkEmailLogin(email: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "https://tokyo-backender.org.kg/schema/swagger/#/")!
    }
    
    var path: String {
        switch self {
        case .checkEmailRegister(email: let email):
            return "/customer/check-email-register/"
        case .checkEmailLogin(email: let email):
            return "/customer/check-email-login/"
        case .registerUser(email: let email, confirmationCode: let confirmationCode):
            return "/customer/register/"
        case .loginUser(email: let email, confirmationCode: let confirmationCode):
            return "/customer/register/"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .checkEmailRegister(_),
                 .checkEmailLogin(_):
                return .post
            case .registerUser(let email, let confirmationCode),
                 .loginUser(let email, let confirmationCode):
                return .post
            }
    }

    var task: Task {
        switch self {
        case .checkEmailRegister(let email),
                .checkEmailLogin(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)

        case .registerUser(let email, let confirmationCode),
                .loginUser(let email, let confirmationCode):
            return .requestParameters(parameters: ["email": email, "confirmationCode": confirmationCode], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application-json"]
    }
}
