//
//  OrderDetailsViewModel.swift
//  NeoCafe Client
//
import Foundation

protocol OrderDetailsViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onCartNavigate: EmptyCompletion? { get set }
}

class OrderDetailsViewModel: NSObject, OrderDetailsViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBackNavigate: EmptyCompletion?
    var onCartNavigate: EmptyCompletion?
    var orderDetails: OrderHistoryModel
    var itemDetails: [Item] = []

    init(orderDetails: OrderHistoryModel) {
        self.orderDetails = orderDetails
        super.init()
    }

    func fetchProductDetails(completion: @escaping () -> Void) {
        var remainingRequests = orderDetails.ito.count

        for ito in orderDetails.ito {
            getProductDetails(productId: ito.id) {
                remainingRequests -= 1
                if remainingRequests == 0 {
                    completion()
                }
            }
        }
    }

    func getProductDetails(productId: Int, completion: @escaping () -> Void) {
        networkService.sendRequest(successModelType: Item.self,
                                   endpoint: MultiTarget(UserAPI.getProductDetails(productId: productId)))
        { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.itemDetails.append(response)
                    completion()
                case let .failure(error):
                    print("handle error: \(error)")
                    completion()
                }
            }
        }
    }
}
