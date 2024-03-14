//
//  EditProfileViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol EditProfileViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var branch: BranchModel? { get }
}

class EditProfileViewModel: NSObject, EditProfileViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var branch: BranchModel?
}
