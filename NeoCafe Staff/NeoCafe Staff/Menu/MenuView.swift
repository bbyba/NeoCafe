//
//  MenuView.swift
//  NeoCafe Staff
//

import UIKit
import SnapKit

class MenuView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.menu
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var profileButton = CustomRoundButton(withImage: Asset.Images.account.image,
                                               backgroundColor: .lightBlueCustom)

    lazy var notificationsButton = CustomRoundButton(withImage: Asset.Images.bell.image,
                                                     backgroundColor: .lightBlueCustom)

    lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        return searchBar
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(cell: CategoryCell.self)
        collectionView.register(cell: MenuCell.self)
        collectionView.register(header: CollectionViewHeader.self)
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


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MenuView {
    private func generateLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionLayoutKind = MenuSection.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .category: return self.generateCategoryItemsLayout()
            case .productItem: return self.generateMenuItemsLayout()
            }
        }
        return layout
    }

    private func generateCategoryItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil, top: nil, trailing: .fixed(8), bottom: nil)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(90),
            heightDimension: .absolute(34))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 16,
                                                        bottom: 0,
                                                        trailing: 16)
        section.interGroupSpacing = 8
        return section

}

    private func generateMenuItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: 11)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight( 1.0 / 8.0 ))


        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                      leading: 16,
                                                      bottom: 12,
                                                      trailing: 16)

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(top:16,
                                                        leading: 0,
                                                        bottom: 0,
                                                        trailing: 0)
        return section
    }
}


extension MenuView: BaseContentView {

    func setProperties() {
        backgroundColor = .white
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(profileButton)
        header.addSubview(headerLabel)
        header.addSubview(notificationsButton)
        addSubview(searchBar)
        addSubview(collectionView)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        profileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileButton.snp.centerY)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        notificationsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(header.snp.bottom).offset(-24)
            make.centerY.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.bottom.width.equalToSuperview()
        }
    }
}
