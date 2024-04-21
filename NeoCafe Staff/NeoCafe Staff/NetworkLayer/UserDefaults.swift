//
//  UserDefaults.swift
//  NeoCafe Staff
//
import UIKit

class UserDefaultsService {
    static let shared = UserDefaultsService()
    private init() {}

    enum Token: String {
        case accessToken
        case refreshToken
    }

    enum UserIDData: String {
        case branchID
        case userID
    }

    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: Token.accessToken.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Token.accessToken.rawValue) }
    }

    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: Token.refreshToken.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Token.refreshToken.rawValue) }
    }

    var branchID: Int {
        get { UserDefaults.standard.integer(forKey: UserIDData.branchID.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserIDData.branchID.rawValue) }
    }

    var userID: Int {
        get { UserDefaults.standard.integer(forKey: UserIDData.userID.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserIDData.userID.rawValue) }
    }

    func saveTokensAndIDs(response: AuthenticationResponse) {
        accessToken = response.accessToken
        refreshToken = response.refreshToken
        branchID = response.branchID
        userID = response.userID
    }

    var itemToOrderList: [Item] = []
}
