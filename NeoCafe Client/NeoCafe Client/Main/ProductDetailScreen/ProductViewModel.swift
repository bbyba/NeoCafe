import UIKit
import Moya

protocol ProductViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onAddToCartNavigate: EmptyCompletion? { get set }
    var productDetail: Item? { get set }
    var suggestions: [Item] { get set }
    func getProductDetails(productId: Int, completion: @escaping (Result<Item, Error>) -> Void)
}

class ProductViewModel: NSObject, ProductViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?
    var productDetail: Item?
    var suggestions: [Item] = []
    let provider: MoyaProvider<UserAPI>

    var productQuantity: Int = 1

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        super.init()
    }

    func getProductDetails(productId: Int, completion: @escaping (Result<Item, Error>) -> Void) {
        provider.request(.getProductDetails(productId: productId)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let productDetail = try JSONDecoder().decode(Item.self, from: response.data)
                        self?.productDetail = productDetail
                        completion(.success(productDetail))
                    } catch {
                        print("Error decoding productDetail: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Error fetching productDetail: \(error)")
                    completion(.failure(error))
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
