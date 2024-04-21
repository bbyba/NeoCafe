//
//  MenuView.swift
//  NeoCafe Client
//

import SnapKit
import SwiftUI
import UIKit

enum MenuSection: String, CaseIterable {
    case category
    case productItem
}

class MenuView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.menu2
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .left
        return label
    }()

    lazy var branchNameLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .ivoryCustom
        label.textAlignment = .left
        return label
    }()

    lazy var headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()

    lazy var headerDropDownButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.dropDownIcon.image, for: .normal)
        return button
    }()

    lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        return searchBar
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(cell: MenuCategoryCell.self)
        collectionView.register(cell: MenuProductCell.self)
        collectionView.register(header: CollectionViewSingleHeader.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView {
    private func generateLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionLayoutKind = MenuSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .category: return self.generateCategoryItemsLayout()
            case .productItem: return self.generateMenuItemsLayout()
            }
        }
        return layout
    }

    private func generateCategoryItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil, top: nil, trailing: .fixed(8), bottom: nil
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(90),
            heightDimension: .absolute(34)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.zIndex = 2
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 12
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 16, bottom: 0, trailing: 16
        )
        section.interGroupSpacing = 8
        return section
    }

    private func generateMenuItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 2.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: 0, bottom: 0, trailing: 11
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.4)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
    }
}

extension MenuView: BaseContentView {
    func setProperties() {
        backgroundColor = .white
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerStack)
        headerStack.addArrangedSubview(headerLabel)
        headerStack.addArrangedSubview(branchNameLabel)
        addSubview(headerDropDownButton)
        addSubview(searchBar)
        addSubview(collectionView)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(70)
        }

        headerDropDownButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(85)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        searchBar.snp.makeConstraints { make in
            make.centerY.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.bottom.width.equalToSuperview()
        }
    }
}
