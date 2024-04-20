//
//  OrderDetailsView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class OrderDetailsView: UIView {

    lazy var header = CustomHeaderView()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.backButton.image, for: .normal)
        return button
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .center
        return label
    }()

    lazy var availablePointsLabel: UILabel = {
        let label = UILabel()
        label.text = S.availablePoints
        label.textAlignment = .center
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var totalAvailablePoints: UILabel = {
        let label = UILabel()
        label.text = "50"
        label.textAlignment = .center
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .orangeCustom
        return label
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
        label.text = "400 c"
        label.textAlignment = .center
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .orangeCustom
        return label
    }()

    lazy var branchLabel: UILabel = {
        let label = UILabel()
        label.text = "400 c"
        label.textAlignment = .left
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "400 c"
        label.textAlignment = .left
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: BigProductCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    lazy var availablePointsToUseLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()

    lazy var totalPriceLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()

    lazy var branchAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [branchLabel, dateLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    lazy var orderButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.order, backgroundColor: .darkBlueCustom)
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

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)

    }

    func hideElementsByStatus() {
        orderButton.isHidden = true
//        availablePointsToUseLabel.isHidden = true
//        totalPriceLabel.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderDetailsView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(branchAndDateStackView)
        addSubview(collectionView)
        addSubview(availablePointsToUseLabel)
        availablePointsToUseLabel.addArrangedSubview(availablePointsLabel)
        availablePointsToUseLabel.addArrangedSubview(totalAvailablePoints)
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

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
        }

        branchAndDateStackView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(branchAndDateStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(availablePointsToUseLabel.snp.top).offset(-10)
        }

        availablePointsToUseLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totalPriceLabel.snp.top).offset(-16)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(orderButton.snp.top).offset(-12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(40)
            make.height.equalTo(54)
        }
    }
}
