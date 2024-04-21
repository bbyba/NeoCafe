//
//  NotificationsView.swift
//  NeoCafe Staff
//

import SnapKit
import UIKit

class NotificationView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.notifications
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var backButton = CustomRoundButton(withImage: Asset.Images.arrowBack.image,
                                            backgroundColor: .lightBlueCustom)

    lazy var clearAllButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppins(ofSize: 16, weight: .semibold),
            .foregroundColor: UIColor.lightBlueCustom,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        let attributedTitle = NSAttributedString(string: S.clearAll, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: NotificationsCell.self)
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

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotificationView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(clearAllButton)
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
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        clearAllButton.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(40)
            make.height.equalTo(19)
            make.trailing.equalToSuperview().offset(-24)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(clearAllButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
