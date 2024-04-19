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
    }
    
    func handleOrder() {
        existingOrder != nil ? patchOrder() : makeOrder()
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

    func patchOrder() {
        guard var existingOrder = existingOrder else {
            print("No existing order found.")
            return
        }

        let itoArray: [ITO] = Cart.shared.createOrderListForSubmission()
        existingOrder.ito = itoArray

        networkService.sendRequest(successModelType: String.self,
                                   endpoint: MultiTarget(UserAPI.patchOrder(order: existingOrder)))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                print("Request Successful")
                self.onOrderNavigate?()
                Cart.shared.removeAllItems()
            case .failure(let error):
                print("Handle error: \(error)")
            }
        }
    }

    private func createOrderList() -> MakeNewOrderModel {
        let branch = UserDefaultsService.shared.branchID
        let orderType = "В заведении"
        let itoArray: [ITO] = Cart.shared.createOrderListForSubmission()
        let orderModel = MakeNewOrderModel(table: selectedTable, branch: branch, orderType: orderType, ito: itoArray)
        return orderModel
    }
}
