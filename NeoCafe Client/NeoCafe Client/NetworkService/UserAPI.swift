//
//  NetworkService.swift
//  NeoCafe Client

import Foundation
import Moya

enum UserAPI {
    // Auth
    case registerUser(email: String, confirmationCode: String)
    case loginUser(email: String, confirmationCode: String)
    case checkEmailRegister(email: String)
    case checkEmailLogin(email: String)

    // Main & Menu
    case getCategories
    case getPopularItems(branchID: Int)
    case getAllCategories
    case getProductDetails(productId: Int)
    case getMenuItemsAll

    // Cart
    case makeOrder(order: NewOrderModelFinal)
    case getOrderHistoryNow
    case getOrderHistoryPast

    // Branch
    case getBranches

    // Profile
    case getProfile(userID: Int)
    case getProfileEdit(userID: Int)
    case patchProfile(userID: Int, firstName: String)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://tokyo-backender.org.kg")!
    }

    var path: String {
        switch self {
            // Auth
        case .checkEmailRegister(_):
            return "/customer/check-email-register/"
        case .checkEmailLogin(_):
            return "/customer/check-email-login/"
        case .registerUser(_, _):
            return "/customer/register/"
        case .loginUser(_, _):
            return "/customer/login/"

            // Main & Menu
        case .getCategories:
            return "/menu/category/all/"
        case .getPopularItems(let branchID):
            return "/branch/\(branchID)/top-selling-menu-items/"
        case .getAllCategories:
            return "/menu/item/all/"
            //        case .getMenuItemsByBranchCategory(let branchID):
            //            return "/branch-menu/\(branchID)/"
        case .getMenuItemsAll:
            return "/menu/item/all/"
        case .getProductDetails(let productId):
            return "/menu/item/\(productId)/"

            // Cart
        case .makeOrder:
            return "/orders-online/add/"
        case .getOrderHistoryNow:
            return "/customer/orders/now/"
        case .getOrderHistoryPast:
            return "/customer/orders/past/"

            // Branches
        case .getBranches:
            return "/branch/all/"

            // Profile
        case .getProfile(let userID):
            return "/profile/customer/\(userID)/"
        case .getProfileEdit(let userID):
            return "/profile/customer/\(userID)/edit/"
        case .patchProfile(let userId, _):
            return "/profile/customer/\(userId)/edit/"
        }
    }


    var method: Moya.Method {
        switch self {
        case .checkEmailRegister,
                .checkEmailLogin,
             .registerUser,
             .loginUser,
             .makeOrder:
            return .post

        case .getCategories,
                .getAllCategories,
             .getProductDetails,
             .getBranches,
             .getProfile, 
             .getProfileEdit,
             .getMenuItemsAll, 
             .getPopularItems,
             .getOrderHistoryNow,
             .getOrderHistoryPast:
            return .get

        case .patchProfile:
            return .patch
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
        case .makeOrder(let order):
            return .requestJSONEncodable(order)
        case .patchProfile(_, let firstName):
            let parameters = ["first_name": firstName]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .makeOrder,
                .getOrderHistoryNow,
                .getOrderHistoryPast:
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
