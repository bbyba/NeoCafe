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
    case getOrdersAll(branchID: Int)
    case makeOrder(order: MakeNewOrderModel)
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
        case .getOrdersAll(let branchID):
            "/orders/all/\(branchID)/"
        case .makeOrder:
            "/orders/add/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .requestConfirmationCode,
                .login,
                .makeOrder:
            return .post
        case .getProfile,
                .getCategories,
                .getMenuItems,
                .getTablesByBranch,
                .getOrdersAll:
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
        case .makeOrder(let order):
            return .requestJSONEncodable(order)
        case .getProfile,
                .getCategories,
                .getMenuItems,
                .getTablesByBranch,
                .getOrdersAll:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getOrdersAll,
                .makeOrder:
            if let accessToken = UserDefaultsService.shared.accessToken {
                return ["Authorization": "Bearer \(accessToken)",
                        "Content-Type": "application/json"]
            } else {
                return nil
            }
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
