//
//  ProductView.swift
//  NeoCafe Client
//

import UIKit
import SnapKit
import SwiftUI

class ProductView: UIView {
//    lazy var header = CustomHeaderView()
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.coffeeCupFront.name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.backButton.image, for: .normal)
        return button
    }()

    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Латте"
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Латте — шоколадное пирожное коричневого цвета, прямоугольные куски нарезанного шоколадного пирога."
        label.font = .poppins(ofSize: 15, weight: .regular)
        label.textColor = .blueCustom
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
        collectionView.register(CollectionViewSingleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSingleHeader.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()


    lazy var priceLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 20, weight: .bold)
        label.textColor = .orangeCustom
        label.text = "270 T"
        return label
    }()

    lazy var stepper = CustomStepper()

    lazy var addToCartButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.toTheBasket, backgroundColor: .darkBlueCustom)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setConstraints()
    }

    func addSubviews() {
        addSubview(image)
        image.addSubview(backButton)
        addSubview(productNameLabel)
        addSubview(descriptionLabel)
        addSubview(collectionView)
        addSubview(priceLabel)
        addSubview(stepper)
        addSubview(addToCartButton)
    }

    func setConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.width.equalToSuperview()
            make.height.equalTo(220)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }

        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().offset(16)
            make.height.equalTo(29)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().offset(16)
            //            make.height.width.equalTo(40)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(priceLabel.snp.top).offset(16)
//                        make.height.equalTo(320)
        }

        priceLabel.snp.makeConstraints { make in
            //            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(addToCartButton.snp.top).offset(-7)
            make.height.equalTo(24)
        }

        addToCartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(55)
            make.width.equalTo(203)
        }

        stepper.snp.makeConstraints { make in
            make.trailing.equalTo(addToCartButton.snp.leading).offset(-16)
            make.centerY.equalTo(addToCartButton.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(123)        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ProductView {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(110))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)

    }
}
