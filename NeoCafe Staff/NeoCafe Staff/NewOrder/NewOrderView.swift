//
//  NewOrderView.swift
//  NeoCafe Staff
//

import UIKit
import SnapKit

class NewOrderView: UIView, BaseContentView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.newOrder
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var collectionViewHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = S.chooseTheTable
        label.font = .poppins(ofSize: 16, weight: .semibold)
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

    lazy var grayCircle: UIView = {
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
        let stackView = UIStackView(arrangedSubviews: [grayCircle, busyLabel])
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

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(TablesCollectionViewCell.self, forCellWithReuseIdentifier: "TablesCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(profileButton)
        header.addSubview(headerLabel)
        header.addSubview(notificationsButton)
        addSubview(collectionViewHeaderLabel)
        addSubview(statusStackView)
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

        collectionViewHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(16)
        }

        statusStackView.snp.makeConstraints { make in
            make.top.equalTo(collectionViewHeaderLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }

        grayCircle.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }

        greenCircle.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(statusStackView.snp.bottom).offset(32)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
