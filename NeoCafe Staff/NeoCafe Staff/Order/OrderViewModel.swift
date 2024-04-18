//
//  OrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol OrderViewModelProtocol {
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onTableOrdersNavigate: EmptyCompletion? { get set }
    var onProfileNavigate: EmptyCompletion? { get set }

    var tables: [TableModel] { get set }
    var ordersList: [OrderDetailsModel] {  get set }
}

class OrderViewModel: NSObject, OrderViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onOrderDetailsNavigate: ((OrderDetailsModel) -> Void)?
    var onNotificationsNavigate: EmptyCompletion?
    var onTableOrdersNavigate: EmptyCompletion?
    var onAllOrdersFetched: EmptyCompletion?
    var onProfileNavigate: EmptyCompletion?

    var filteredOrders: [OrderDetailsModel] = []
//    var ordersList: [OrderDetailsModel] = []
    var tables: [TableModel]  = []
    var statusList: [String] = [S.all,
                                S.newStatus,
                                S.processingStatus,
                                S.readyStatus, 
                                S.doneStatus,
                                S.cancelledStatus]


    func filterOrders(byStatus status: String) {
        if status == S.all {
            filteredOrders = ordersList
        } else {
            filteredOrders = ordersList.filter { $0.orderStatus == status }
        }
    }

    var ordersList: [OrderDetailsModel] = [
        OrderDetailsModel(
            id: 61,
            orderNumber: 3001,
            table: TableModel(
                id: 2,
                tableNumber: 2,
                isAvailable: false,
                branch: 1
            ),
            orderStatus: "В процессе",
            createdAt: "05:05",
            updatedAt: "05:56",
            completedAt: nil,
            branch: 1,
            orderType: "In Venue",
            totalSum: 440,
            employeeProfile: EmployeeProfile(
                id: 1,
                user: User(
                    id: 1,
                    username: "vlad",
                    password: "Neobis1!",
                    firstName: "Влад",
                    lastName: nil,
                    email: "vlad@vlad.kg",
                    userType: "Waiter",
                    branch: 1,
                    branchName: "Backend",
                    employeeSchedules: [
                        EmployeeSchedule(day: "Пн", startTime: "08:00", endTime: "18:00"),
                        EmployeeSchedule(day: "Вт", startTime: "08:00", endTime: "18:00"),
                        EmployeeSchedule(day: "Ср", startTime: "08:00", endTime: "18:00"),
                        EmployeeSchedule(day: "Чт", startTime: "08:00", endTime: "18:00"),
                        EmployeeSchedule(day: "Пт", startTime: "08:00", endTime: "17:00"),
                        EmployeeSchedule(day: "Сб", startTime: "09:00", endTime: "18:00"),
                        EmployeeSchedule(day: "Вс", startTime: "10:00", endTime: "19:00")
                    ]
                )
            ),
            ito: [
                ITO(
                    id: 40,
                    item: 1,
                    itemName: "Шоколадный круассан",
                    quantity: 2,
                    totalPrice: 440
                )
            ]
        )
    ]


//    func getAllOrders() {
//        networkService.sendRequest(
//            successModelType: [OrderDetailsModel].self,
//            endpoint: MultiTarget(UserAPI.getOrdersAll(branchID: UserDefaultsService.shared.branchID))
//        ) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    self.ordersList = response
//                    self.onAllOrdersFetched?()
//                }
//            case .failure(let error):
//                print("handle error: \(error)")
//            }
//        }
//    }
}
