//
//  MakeNewOrderViewModel.swift
//  NeoCafe Staff
//
import Foundation

protocol MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onOrderNavigate: EmptyCompletion? { get set }
//    var orderedItems: [WaiterItem] {  get set }
}

class MakeNewOrderViewModel: NSObject, MakeNewOrderViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBackNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?
    var selectedTable: TableModel
    var existingOrder: OrderDetailsModel?

    init(table: TableModel, existingOrder: OrderDetailsModel?) {
        self.selectedTable = table
        self.existingOrder = existingOrder
        super.init()
        if let existingOrder = existingOrder {
            addItemsOfExistingOrderToCart(existingOrderItems: existingOrder)
        }
    }

    func makeOrder() {
        let orderModel = createOrderList()

        networkService.sendRequest(successModelType: String.self,
                                   endpoint: MultiTarget(UserAPI.makeOrder(order: orderModel)))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                print("Request Successful")
                print("\(orderModel)")
                self.onOrderNavigate?()
                Cart.shared.removeAllItems()
            case .failure(let error):
                print("Handle error: \(error)")
                //                showErrorScreen()
            }
        }
    }

    private func createOrderList() -> MakeNewOrderModel {
        let branch = UserDefaultsService.shared.branchID
        let orderType = "In Venue"
        let itoArray: [ITO] = Cart.shared.createOrderListForSubmission()
        let orderModel = MakeNewOrderModel(table: selectedTable, branch: branch, orderType: orderType, ito: itoArray)
        return orderModel
    }

    private func addItemsOfExistingOrderToCart(existingOrderItems: OrderDetailsModel) {
        for itoItem in existingOrderItems.ito {
            if let menuItem = findMenuItem(for: itoItem) {
                Cart.shared.addItem(menuItem, quantity: itoItem.quantity)
            }
        }
    }

    private func findMenuItem(for itoItem: ITO) -> Item? {
        for item in menuItems {
            if item.id == itoItem.item {
                return item
            }
        }
        return nil
    }
}
