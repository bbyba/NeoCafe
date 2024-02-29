//
//  BranchesModalCell.swift
//  NeoCafe Client
//
import UIKit

class BranchesModalCell: UICollectionViewCell {
    static let identifier = "BranchesModalCell"

    lazy var image: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: Asset.branchesModal.name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()

    lazy var titleLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.text = "NeoCafe Dzerzhinka"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubviews()
        setupConstraints()
        setupShadow()
    }

    private func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(12)
        }
    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }

    func configureData(name: String, imageName: String) {
        image.image = UIImage(named: imageName)
        titleLabel.text = name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
