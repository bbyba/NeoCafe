//
//  CategoryCell.swift
//  NeoCafe Client
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellowCustom
        layer.cornerRadius = 14
        setupConstraints()
    }

    func setupConstraints() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)

        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
            make.height.equalTo(56.6)
            make.width.equalTo(56)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(8)
        }
    }

//    func configureData(name: String, image: String) {
//        image.image = UIImage(named: image)
//        titleLabel.text = name
//    }
    func configureData(name: String, imageName: String) {
        image.image = UIImage(named: imageName)
        titleLabel.text = name
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
