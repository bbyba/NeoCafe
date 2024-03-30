//
//  OrderView.swift
//  NeoCafe Staff
//
import Foundation
import UIKit
import SnapKit

enum OrderStatus: String, CaseIterable {
    case statusCategory
    case statusOrder
}

class OrderView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.orders
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var busyLabel: UILabel = {
        let label = UILabel()
        label.text = S.busy
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var freeLabel: UILabel = {
        let label = UILabel()
        label.text = S.free
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var greyCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .greyCustom
        return view
    }()

    lazy var greenCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .greenTableCustom
        return view
    }()

    lazy var profileButton = CustomRoundButton(withImage: Asset.Images.account.image, 
                                               backgroundColor: .lightBlueCustom)

    lazy var notificationsButton = CustomRoundButton(withImage: Asset.Images.bell.image, 
                                                     backgroundColor: .lightBlueCustom)

    lazy var busyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greyCircle, busyLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()

    lazy var freeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greenCircle, freeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()

    lazy var statusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [busyStackView, freeStackView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()

    lazy var segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: [S.tables, S.orders])
        segmentedControl.contentMode = .scaleToFill
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    lazy var tablesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: TablesCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    lazy var ordersByStatusCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createOrdersLayout())
        collectionView.register(cell: CategoryCell.self)
        collectionView.register(cell: OrdersCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isHidden = true
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

extension OrderView {

    // MARK: - Tables

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 3.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(110))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return UICollectionViewCompositionalLayout(section: section)
    }


    // MARK: - Orders

    private func createOrdersLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionLayoutKind = OrderStatus.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .statusCategory: return self.generateCategoryItemsLayout()
            case .statusOrder: return self.generateOrdersByStatusLayout()
            }
        }
        return layout
    }

    private func generateCategoryItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil,
                                                         top: nil,
                                                         trailing: .fixed(8),
                                                         bottom: nil)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(90),
            heightDimension: .absolute(34))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, 
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 16,
                                                        bottom: 20,
                                                        trailing: 16)
        section.interGroupSpacing = 8
        return section

}

    private func generateOrdersByStatusLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(110))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, 
                                                      leading: 16,
                                                      bottom: 8,
                                                      trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, 
                                                        leading: 0,
                                                        bottom: 0,
                                                        trailing: 0)
        return section
    }
}

extension OrderView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }
    func addSubviews() {
        addSubview(header)
        header.addSubview(profileButton)
        header.addSubview(headerLabel)
        header.addSubview(notificationsButton)
        addSubview(segmentedControl)
        addSubview(statusStackView)
        addSubview(tablesCollectionView)
        addSubview(ordersByStatusCollectionView)
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

        segmentedControl.snp.makeConstraints { make in
            make.centerY.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        statusStackView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }

        greyCircle.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }

        greenCircle.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }

        tablesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(statusStackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }

        ordersByStatusCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        ordersByStatusCollectionView.isHidden = true
    }
}
