//
//  CategoryCell.swift
//  NeoCafe Staff
//
import UIKit

class CategoryCell: BaseCollectionViewCell {
    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .medium)
        label.textColor = .darkBlueCustom
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
        setProperties()
        addSubviews()
        setupConstraints()
    }

    func configureData(name: String) {
        titleLabel.text = name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CategoryCell: BaseContentView {
    func setProperties() {
        backgroundColor = .greyCustom
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }

    func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
