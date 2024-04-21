//
//  NewOrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onMakeNewOrderNavigate: ((TableModel) -> Void)? { get set }
}

class NewOrderViewModel: NSObject, NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onMakeNewOrderNavigate: ((TableModel) -> Void)?
    var selectedTable: TableModel?
}
