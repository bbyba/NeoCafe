//
//  ProductViewController.swift
//  NeoCafe Client
//
import UIKit

class ProductViewController: BaseViewController<ProductViewModel, ProductView> {
    
    var suggestions: [PrItem] = [
        PrItem(image: Asset.coffeeCupTop.name, name: "POP1", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP2", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP3", price: 230)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        addTargets()
    }
    
    func fetchProductData(productId: Int) {
        viewModel.getProductDetails(productId: productId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productData):
                    self?.configureProductData(productData: productData)
                case .failure(let error):
                    print("Error fetching product detail: \(error)")
                }
            }
        }
    }

    func configureProductData(productData: Item) {
        contentView.productNameLabel.text = productData.name
        contentView.descriptionLabel.text = productData.description
        contentView.priceLabel.text = "\(productData.pricePerUnit) с"
        contentView.image.image = UIImage(named: productData.itemImage ?? Asset.coffeeCupFront.name)
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        contentView.stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)

    }

    @objc private func addToCartTapped() {
        viewModel.addToCart()
    }

    @objc private func stepperValueChanged() {
        viewModel.productQuantity = contentView.stepper.currentValue
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigProductCell.identifier, for: indexPath) as? BigProductCell else {
                fatalError("Could not dequeue BigProductCell")
            }
        let suggestion = suggestions[indexPath.row]
//        let suggestion = viewModel.suggestions[indexPath.row]
//        cell.configureData(item: suggestion)
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as? CollectionViewSingleHeader else {
            fatalError("Could not dequeue Header")
        }
        header.configureTitle(title: S.pleasantAddition)
        return header
    }
}
