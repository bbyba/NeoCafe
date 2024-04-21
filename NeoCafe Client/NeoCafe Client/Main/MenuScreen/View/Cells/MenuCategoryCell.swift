//
//  MenuCategoryCell.swift
//  NeoCafe Client
//

import UIKit

class MenuCategoryCell: BaseCollectionViewCell {
    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .medium)
        label.textColor = .darkBlueCustom
        label.text = "Coffee"
        return label
    }()

    var isCategorySelected = false {
        didSet {
            backgroundColor = isCategorySelected ? .orangeCustom : .greyCustom
            titleLabel.textColor = isCategorySelected ? .whiteCustom : .darkBlueCustom
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .greyCustom
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    func configureData(name: String) {
        titleLabel.text = name
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
