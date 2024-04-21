import Moya
import UIKit

protocol ProductDetailViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onAddToCartNavigate: EmptyCompletion? { get set }
    var productDetail: Item? { get set }
    var suggestions: [Item] { get set }
}

class ProductDetailViewModel: NSObject, ProductDetailViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBackNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?
    var onProductDetailUpdate: ((Item) -> Void)?
    var productDetail: Item?
    var suggestions: [Item] = []
    var productQuantity: Int = 1

    func getProductDetails(productId: Int) {
        networkService.sendRequest(successModelType: Item.self,
                                   endpoint: MultiTarget(UserAPI.getProductDetails(productId: productId)))
        { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.productDetail = response
                    self.onProductDetailUpdate?(response)
                case let .failure(error):
                    print("handle error: \(error)")
                }
            }
        }
    }

    func addToCart() {
        guard let product = productDetail else { return }
        Cart.shared.filterItems(newItem: product, quantity: productQuantity)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        onAddToCartNavigate?()
    }

    func updateQuantity(newQuantity: Int) {
        productQuantity = newQuantity
    }
}
