//
//  ProfileViewModel.swift
//  NeoCafe Staff
//

import UIKit
import Moya

protocol ProfileViewModelProtocol {
    var onLogoutNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    var onLogoutNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
//    let provider: MoyaProvider<UserAPI>

//    init(provider: MoyaProvider<UserAPI>) {
//        self.provider = provider
//    }

}
