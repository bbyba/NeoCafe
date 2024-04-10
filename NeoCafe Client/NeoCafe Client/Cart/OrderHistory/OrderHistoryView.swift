//
//  OrderHistoryView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class OrderHistoryView: UIView {

    lazy var header = CustomHeaderView()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.backButton.image, for: .normal)
        return button
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.orderHistory
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: BigProductCell.self)
        collectionView.register(header: CollectionViewSingleHeader.self)
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
        setProperties()
        addSubviews()
        setupConstraints()
    }

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
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderHistoryView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(collectionView)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
