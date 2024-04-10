//
//  UserAPI.swift
//  NeoCafe Staff
//

import Foundation
import Moya

enum UserAPI  {
    case requestConfirmationCode(username: String, password: String)
    case login(email: String, confirmation_code: String)
    case getProfile(userID: Int)
    case getCategories
    case getMenuItems
    case getTablesByBranch(branchID: Int)
}

extension UserAPI: TargetType {


    var baseURL: URL {
        return URL(string: "https://tokyo-backender.org.kg")!
    }

    var path: String {
        switch self {
        case .requestConfirmationCode:
            "/waiter/check-username-login/"
        case .login:
            "/waiter/login/"
        case .getProfile(let userID):
            "/profile/waiter/\(userID)/"
        case .getCategories:
            "/menu/category/all/"
        case .getMenuItems:
            "/menu/item/all/"
        case .getTablesByBranch(let branchID):
            "/tables/branch/\(branchID)/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .requestConfirmationCode,
                .login:
            return .post
        case .getProfile,
                .getCategories,
                .getMenuItems,
                .getTablesByBranch:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .requestConfirmationCode(let username, let password):
            return .requestParameters(parameters: ["username": username, 
                                                   "password": password],
                                      encoding: JSONEncoding.default)

        case .login(let email, let confirmation_code):
            return .requestParameters(parameters: ["email": email, 
                                                   "confirmation_code": confirmation_code],
                                      encoding: JSONEncoding.default)

        case .getProfile,
                .getCategories,
                .getMenuItems,
                .getTablesByBranch:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .requestConfirmationCode, 
                .login,
                .getProfile,
                .getCategories,
                .getMenuItems,
                .getTablesByBranch:
            return ["Content-Type": "application/json"]
        }
    }
}
