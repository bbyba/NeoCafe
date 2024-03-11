//
//  NetworkService.swift
//  NeoCafe Client

import Foundation
import Moya

enum UserAPI {
    case registerUser(email: String, confirmationCode: String) // Register customer by adding to the database after providing email and confirmation code.
    case loginUser(email: String, confirmationCode: String)    // Authenticate customer after providing email and confirmation code.
    case checkEmailRegister(email: String)  // Check if customer's email is in the database and send a verification code.
    case checkEmailLogin(email: String) // Check if customer's email is in the database and send a new verification code.
//    case getCategories(id: Int, email: String, image: String)
    case getCategories
    case getAllCategories
    case getProductDetails(productId: Int)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://tokyo-backender.org.kg")!
    }
    
    var path: String {
        switch self {
        case .checkEmailRegister(_):
            return "/customer/check-email-register/"
        case .checkEmailLogin(_):
            return "/customer/check-email-login/"
        case .registerUser(_, _):
            return "/customer/register/"
        case .loginUser(_, _):
            return "/customer/login/"
        case .getCategories:
            return "/menu/category/all/"
        case .getAllCategories:
            return "/menu/item/all/"
        case .getProductDetails(let productId):
            return "/menu/item/\(productId)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .checkEmailRegister(_),
                 .checkEmailLogin(_):
                return .post
            case .registerUser(_, _),
                 .loginUser(_, _):
                return .post
        case .getCategories, .getAllCategories, .getProductDetails:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .checkEmailRegister(let email),
             .checkEmailLogin(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .registerUser(let email, let confirmationCode),
             .loginUser(let email, let confirmationCode):
            return .requestParameters(parameters: ["email": email, "confirmation_code": confirmationCode], encoding: JSONEncoding.default)
        case .getCategories, .getAllCategories, .getProductDetails:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
