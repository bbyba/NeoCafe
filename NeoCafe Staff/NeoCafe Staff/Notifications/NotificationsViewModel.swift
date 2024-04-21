//
//  NotificationsViewModel.swift
//  NeoCafe Staff
//
import UIKit

struct NotificationModel {
    let status: String
    let details: String
    let time: String
}

protocol NotificationsViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
//    var notifications: [Notification] { get set }
    var notificationsList: [NotificationModel] { get set }
}

class NotificationsViewModel: NSObject, NotificationsViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var notificationsList: [NotificationModel] = [
        NotificationModel(status: "Ваш заказ готов", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
        NotificationModel(status: "Вы закрыли счёт", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
        NotificationModel(status: "Ваш заказ оформлен", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
    ]
}
