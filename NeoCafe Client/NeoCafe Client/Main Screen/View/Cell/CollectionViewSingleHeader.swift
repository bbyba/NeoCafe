//
//  CollectionViewSingleHeader.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

class CollectionViewSingleHeader: UICollectionReusableView {
    static let identifier = "CollectionViewSingleHeader"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    func configureTitle(title: String) {
            titleLabel.text = title
        }

    private func addSubviews() {
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
