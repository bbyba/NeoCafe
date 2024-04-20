import UIKit
import Moya

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
//    var suggestions: [Item] = []
    var suggestions: [Item] = [
        Item( id: 31,
              name: "Пирожок с капустой",
              description: "Традиционное блюдо",
              itemImage: nil,
              pricePerUnit: 120,
              branch: nil,
              category: Category(id: 1, name: "Выпечка"),
              ingredients: nil),
        Item( id: 27,
              name: "Смузи с ягодами",
              description: "Освежающий напиток",
              itemImage: nil,
              pricePerUnit: 160,
              branch: nil,
              category: Category(id: 5, name: "Напитки"),
              ingredients: nil),
        Item( id: 32,
              name: "Суп грибной",
              description: "Ароматный и сытный",
              itemImage: nil,
              pricePerUnit: 180,
              branch: nil,
              category: Category(id: 7, name: "Супы"),
              ingredients: nil)]
    var productQuantity: Int = 1

    func getProductDetails(productId: Int) {
        networkService.sendRequest(successModelType: Item.self,
                                   endpoint: MultiTarget(UserAPI.getProductDetails(productId: productId))) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.productDetail = response
                    self.onProductDetailUpdate?(response)
                case .failure(let error):
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
