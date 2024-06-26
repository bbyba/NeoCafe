//
//  NetworkService.swift
//  NeoCafe Client

import Foundation
import Moya

enum UserAPI {
    // Auth
    case registerUser(email: String, confirmationCode: String) // Register customer by adding to the database after providing email and confirmation code.
    case loginUser(email: String, confirmationCode: String)    // Authenticate customer after providing email and confirmation code.
    case checkEmailRegister(email: String)  // Check if customer's email is in the database and send a verification code.
    case checkEmailLogin(email: String) // Check if customer's email is in the database and send a new verification code.

    // Main & Menu
    case getCategories
    case getPopularItems(branchID: Int)
    case getAllCategories
    case getProductDetails(productId: Int)
//    case getMenuItemsByBranchCategory(branchID: Int, categoryID: Int)
        case getMenuItemsByBranchCategory(branchID: Int)


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
        case .getMenuItemsByBranchCategory(let branchID):
            return "/branch-menu/\(branchID)/"
        case .getProductDetails(let productId):
            return "/menu/item/\(productId)/"

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
        case .checkEmailRegister(_),
                .checkEmailLogin(_):
            return .post
        case .registerUser(_, _),
                .loginUser(_, _):
            return .post
        case .getCategories,
                .getAllCategories,
                .getProductDetails,
                .getBranches,
                .getProfile,
                .getProfileEdit,
                .getMenuItemsByBranchCategory,
                .getPopularItems:
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
        case .getCategories,
                .getAllCategories,
                .getProductDetails,
                .getBranches,
                .getProfile,
                .getProfileEdit,
                .getMenuItemsByBranchCategory,
                .getPopularItems:
            return .requestPlain
        case .patchProfile(_, let firstName):
            let parameters = ["first_name": firstName]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)

        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
