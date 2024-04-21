//
//  UserAPI.swift
//  NeoCafe Staff
//

import Foundation
import Moya

enum UserAPI {
    case requestConfirmationCode(username: String, password: String)
    case login(email: String, confirmationCode: String)
    case getProfile(userID: Int)
    case getCategories
    case getMenuItems
    case getTablesByBranch(branchID: Int)
    case getOrdersAll(branchID: Int)
    case makeOrder(order: MakeNewOrderModel)
    case patchOrder(order: OrderDetailsModel)
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
        case let .getProfile(userID):
            "/profile/waiter/\(userID)/"
        case .getCategories:
            "/menu/category/all/"
        case .getMenuItems:
            "/menu/item/all/"
        case let .getTablesByBranch(branchID):
            "/tables/branch/\(branchID)/"
        case let .getOrdersAll(branchID):
            "/orders/all/\(branchID)/"
        case .makeOrder:
            "/orders/add/"
        case let .patchOrder(order):
            "/orders/\(order.orderNumber)/"
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
        case .patchOrder:
            return .patch
        }
    }

    var task: Moya.Task {
        switch self {
        case let .requestConfirmationCode(username, password):
            return .requestParameters(parameters: ["username": username,
                                                   "password": password],
                                      encoding: JSONEncoding.default)

        case let .login(email, confirmationCode):
            return .requestParameters(parameters: ["email": email,
                                                   "confirmationCode": confirmationCode],
                                      encoding: JSONEncoding.default)
        case let .patchOrder(order):
            return .requestCompositeParameters(bodyParameters: ["order": order],
                                               bodyEncoding: JSONEncoding.default,
                                               urlParameters: ["orderId": order.orderNumber])
        case let .makeOrder(order):
            return .requestJSONEncodable(order)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getOrdersAll,
             .makeOrder,
             .patchOrder:
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
