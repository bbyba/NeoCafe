//
//  CartView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class CartView: UIView {

    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.cart
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .left
        return label
    }()

    lazy var orderHistoryButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.orderHistory.image, for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    lazy var nameFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeCustom
        view.layer.cornerRadius = 24
        return view
    }()

    lazy var takeOutLabel: UILabel = {
        let label = UILabel()
        label.text = S.toGoShort
        label.font = .poppins(ofSize: 20, weight: .bold)
        label.textColor = .whiteCustom
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(BigProductCell.self, forCellWithReuseIdentifier: BigProductCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    lazy var addMoreButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.addMore, backgroundColor: .clear, titleColor: .orangeCustom, showBorder: true)
        button.titleLabel?.font = .poppins(ofSize: 16, weight: .medium)
        return button
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = S.total
        label.textAlignment = .center
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "730"
        label.textAlignment = .center
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .orangeCustom
        return label
    }()

    lazy var totalPriceLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()

    lazy var orderButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.order, backgroundColor: Asset.Colors.darkBlue.color)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerLabel)
        header.addSubview(orderHistoryButton)
        addSubview(nameFieldView)
        nameFieldView.addSubview(takeOutLabel)
        addSubview(collectionView)
        addSubview(addMoreButton)
        addSubview(totalPriceLabel)
        totalPriceLabel.addArrangedSubview(totalLabel)
        totalPriceLabel.addArrangedSubview(priceLabel)

        addSubview(orderButton)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(70)
        }

        orderHistoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(40)
            make.height.width.equalTo(40)
        }

        nameFieldView.snp.makeConstraints { make in
            make.centerY.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        takeOutLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameFieldView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addMoreButton.snp.top).offset(-20)
        }

        addMoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(totalPriceLabel.snp.top).offset(-41)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(orderButton.snp.top).offset(-12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        orderButton.snp.makeConstraints { make in
//            make.top.equalTo(textFieldStackView.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
