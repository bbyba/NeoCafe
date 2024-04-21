//
//  BranchesModalView.swift
//  NeoCafe Client
//

import SnapKit
import SwiftUI
import UIKit

class BranchesModalView: UIView {
    lazy var blurredBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .whiteCustom
        button.backgroundColor = .coralCustom
        button.layer.cornerRadius = 14
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        return button
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.chooseBranch
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: BranchesModalCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            heightDimension: .fractionalHeight(0.32)
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

extension BranchesModalView: BaseContentView {
    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(headerLabel)
        contentView.addSubview(collectionView)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom)
            make.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
