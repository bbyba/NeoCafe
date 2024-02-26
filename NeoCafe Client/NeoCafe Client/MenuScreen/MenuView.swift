////
////  MenuView.swift
////  NeoCafe Client
////
//
//import UIKit
//import SnapKit
//import SwiftUI
//
//class MenuView: UIView {
//    lazy var header = CustomHeaderView()
//
//    lazy var headerLabel: UILabel = {
//        let label = UILabel()
//        label.text = S.goodMorning
//        label.font = .poppins(ofSize: 32, weight: .bold)
//        label.textColor = .ivoryCustom
//        label.textAlignment = .left
//        return label
//    }()
//
//    lazy var searchBar: CustomSearchBar = {
//        let searchBar = CustomSearchBar()
//        return searchBar
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
//        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
//        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: "PopularCell")
//        collectionView.register(CollectionViewSingleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSingleHeader.identifier)
//        collectionView.backgroundColor = .clear
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        return collectionView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white
//        addSubviews()
//        setupConstraints()
//    }
//
//    func addSubviews() {
//        addSubview(header)
//        header.addSubview(headerLabel)
//        addSubview(searchBar)
//        addSubview(collectionView)
//    }
//
//
//    func setupConstraints() {
//        header.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.2)
//        }
//
//        headerLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.centerY.equalToSuperview()
//        }
//
//        searchBar.snp.makeConstraints { make in
//            make.centerY.equalTo(header.snp.bottom).offset(-searchBar.frame.height / 2)
////            make.top.equalTo(header.snp.bottom).inset(8)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.height.equalTo(48)
//        }
//
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom).offset(8)
//            make.bottom.width.equalToSuperview()
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//extension MenuView {
//    private func generateLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            let sectionLayoutKind = Section.allCases[sectionIndex]
//            switch (sectionLayoutKind) {
//            case .category: return self.generateCategoryItemsLayout()
//            case .popular: return self.generatePopularItemsLayout()
//            }
//        }
//        return layout
//    }
//
//    private func generateCategoryItemsLayout() -> NSCollectionLayoutSection {
//        let doubleItemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.5),
//            heightDimension: .fractionalHeight(1.0))
//
//        let doubleItem = NSCollectionLayoutItem(layoutSize: doubleItemSize)
//
//        doubleItem.contentInsets = NSDirectionalEdgeInsets(
//            top: 8,
//            leading: 8,
//            bottom: 8,
//            trailing: 8)
//
//        let doubleGroupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(0.5))
//
//        let doubleGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: doubleGroupSize,
//            repeatingSubitem: doubleItem,
//            count: 2)
//
//        let tripletItem = NSCollectionLayoutItem(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0 / 3.0),
//                heightDimension: .fractionalHeight(1.0)))
//
//        tripletItem.contentInsets = NSDirectionalEdgeInsets(
//            top: 8,
//            leading: 8,
//            bottom: 8,
//            trailing: 8)
//
//        let tripletGroup = NSCollectionLayoutGroup.horizontal(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .fractionalHeight(0.5)),
//            repeatingSubitem: tripletItem,
//            count: 3)
//
//        let nestedGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .fractionalHeight(0.4)),
//            subitems: [doubleGroup, tripletGroup])
//
//        let headerSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .estimated(44))
//
//        let header = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top)
//        header.pinToVisibleBounds = true
//        header.zIndex = 2
//        header.contentInsets = NSDirectionalEdgeInsets(
//                top: 0,
//                leading: 8,
//                bottom: 0,
//                trailing: 8)
//
//        let section = NSCollectionLayoutSection(group: nestedGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
//        section.boundarySupplementaryItems = [header]
//        return section
//}
//
//    private func generateMenuItemsLayout() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0 / 2.0),
//            heightDimension: .fractionalHeight(1.0))
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(110))
//
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
//
////        let headerSize = NSCollectionLayoutSize(
////            widthDimension: .fractionalWidth(1.0),
////            heightDimension: .estimated(44))
////
////        let header = NSCollectionLayoutBoundarySupplementaryItem(
////            layoutSize: headerSize,
////            elementKind: UICollectionView.elementKindSectionHeader,
////            alignment: .top
////        )
////        header.pinToVisibleBounds = true
////        header.zIndex = 2
////        header.contentInsets = NSDirectionalEdgeInsets(
////                top: 0,
////                leading: 8,
////                bottom: 0,
////                trailing: 8)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.boundarySupplementaryItems = [header]
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
//        return section
//    }
//}