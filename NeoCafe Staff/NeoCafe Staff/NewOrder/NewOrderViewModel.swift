//
//  NewOrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onMakeNewOrderNavigate: EmptyCompletion? { get set }
}

class NewOrderViewModel: NSObject, NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onMakeNewOrderNavigate: EmptyCompletion?

    var tables: [TableModel]  = [
    ]
}
