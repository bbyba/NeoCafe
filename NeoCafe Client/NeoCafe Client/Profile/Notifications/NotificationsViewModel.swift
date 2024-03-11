//
//  NotificationsViewModel.swift
//  NeoCafe Client
//

import UIKit

protocol NotificationsViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
//    var notifications: [Notification] { get set }
}
class NotificationsViewModel: NSObject, NotificationsViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    

}
