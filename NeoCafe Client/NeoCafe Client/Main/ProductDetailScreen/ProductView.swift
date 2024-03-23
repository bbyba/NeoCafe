//
//  ProductView.swift
//  NeoCafe Client
//

import UIKit
import SnapKit
import SwiftUI

class ProductView: UIView, BaseContentView {
    
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
        button.setImage(Asset.Buttons.backButton.image, for: .normal)
        return button
    }()

    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Латте"
        label.font = .poppins(ofSize: 24, weight: .semibold)
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
        collectionView.register(BigProductCell.self, forCellWithReuseIdentifier: BigProductCell.identifier)
        collectionView.register(CollectionViewSingleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSingleHeader.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()


    lazy var priceLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 20, weight: .semibold)
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

    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(image)
        addSubview(backButton)
        addSubview(productNameLabel)
        addSubview(descriptionLabel)
        addSubview(collectionView)
        addSubview(priceLabel)
        addSubview(stack)
        stack.addArrangedSubview(stepper)
        stack.addArrangedSubview(addToCartButton)
    }

    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(230)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
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

        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(55)
        }

        stepper.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(120)
        }

        addToCartButton.snp.makeConstraints { make in
            make.width.equalTo(220)
        }
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
