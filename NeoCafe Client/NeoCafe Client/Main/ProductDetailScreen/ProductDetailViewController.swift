//
//  ProductDetailViewController.swift
//  NeoCafe Client
//
import UIKit

class ProductDetailViewController: BaseViewController<ProductDetailViewModel, ProductDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        Loader.shared.showLoader(view: view)
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    func configureProductData(productData: Item) {
        contentView.productNameLabel.text = productData.name
        contentView.descriptionLabel.text = productData.description
        contentView.priceLabel.text = "\(productData.pricePerUnit) с"
        contentView.image.image = UIImage(named: productData.itemImage ?? Asset.coffeeCupFront.name)
        Loader.shared.hideLoader(view: view)
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

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        let suggestion = viewModel.suggestions[indexPath.row]
        cell.configureData(item: suggestion)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)
        header.configureTitle(title: S.pleasantAddition)
        return header
    }
}
