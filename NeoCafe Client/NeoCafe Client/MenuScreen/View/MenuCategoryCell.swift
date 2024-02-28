//
//  MenuCategoryCell.swift
//  NeoCafe Client
//

import UIKit

class MenuCategoryCell: UICollectionViewCell {
    static let identifier = "MenuCategoryCell"

    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .bold)
        label.textColor = .darkBlueCustom
        label.text = "Coffee"
        return label
    }()

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
