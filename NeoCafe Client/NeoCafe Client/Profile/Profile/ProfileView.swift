//
//  ProfileView.swift
//  NeoCafe Client
//

import UIKit
import SnapKit
import SwiftUI

class ProfileView: UIView, BaseContentView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.profile
        label.font = .poppins(ofSize: 32, weight: .semibold)
        label.textColor = .ivoryCustom
        label.textAlignment = .left
        return label
    }()

    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.logoutButton.image, for: .normal)
        return button
    }()

    lazy var nameFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .greyCustom
        view.layer.cornerRadius = 40
        return view
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jane"
        label.font = .poppins(ofSize: 24, weight: .medium)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .darkBlueCustom
        return button
    }()

    lazy var bonusImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.bonusImage.name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()

    lazy var bonusHeaderTitle: UILabel = {
        let label = UILabel()
        label.text = "Бонусы"
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var totalBonusPointsNumber: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = .poppins(ofSize: 32, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var bonusPointsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerLabel)
        addSubview(logoutButton)
        addSubview(nameFieldView)
        nameFieldView.addSubview(nameLabel)
        nameFieldView.addSubview(editButton)
        addSubview(bonusImageView)
        bonusImageView.addSubview(bonusPointsStack)
        bonusPointsStack.addArrangedSubview(bonusHeaderTitle)
        bonusPointsStack.addArrangedSubview(totalBonusPointsNumber)
        addSubview(collectionView)
    }


    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(70)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(40)
            make.height.width.equalTo(40)
        }

        nameFieldView.snp.makeConstraints { make in
            make.centerY.equalTo(header.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(78)
        }

        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }

        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(24)
        }

        bonusImageView.snp.makeConstraints { make in
            make.top.equalTo(nameFieldView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(110)
        }

        bonusPointsStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(23)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bonusImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
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

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
