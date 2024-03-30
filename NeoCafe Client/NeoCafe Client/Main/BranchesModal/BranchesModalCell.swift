//
//  BranchesModalCell.swift
//  NeoCafe Client
//

import UIKit

class BranchesModalCell: BaseCollectionViewCell {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.branchesModal.name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()

    lazy var branchScheduleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .darkBlueCustom
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.layer.cornerRadius = 8    //14
        label.layer.masksToBounds = true
        return label
    }()


    lazy var branchNameLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var addressLabel = {
        let label = UILabel()
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 16, weight: .regular)
        return label
    }()

    lazy var phoneLabel = {
        let label = UILabel()
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 16, weight: .regular)
        return label
    }()

    lazy var addressIcon: UIImageView = {
        let image = UIImageView(image: Asset.Buttons.location.image.withRenderingMode(.alwaysTemplate))
        image.tintColor = .orangeCustom
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var phoneIcon: UIImageView = {
        let image = UIImageView(image: Asset.Buttons.phoneIcon.image.withRenderingMode(.alwaysTemplate))
        image.tintColor = .orangeCustom
        image.contentMode = .scaleAspectFit
        return image
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
        contentView.addSubview(branchScheduleLabel)
        contentView.addSubview(branchNameLabel)
        contentView.addSubview(addressIcon)
        contentView.addSubview(addressLabel)
        contentView.addSubview(phoneIcon)
        contentView.addSubview(phoneLabel)
    }

    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }

        branchScheduleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(24)
            make.height.equalTo(26)
            make.width.equalTo(177)
        }

        branchNameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(12)
        }

        addressIcon.snp.makeConstraints { make in
            make.top.equalTo(branchNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(17)
            make.width.equalTo(14)
        }

        addressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(addressIcon.snp.centerY)
            make.leading.equalTo(addressIcon.snp.trailing).offset(8)
            //            make.bottom.equalTo(addressIcon.snp.bottom).offset(4)
        }

        phoneIcon.snp.makeConstraints { make in
            make.top.equalTo(addressIcon.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(phoneIcon.snp.centerY)
            make.leading.equalTo(phoneIcon.snp.trailing).offset(8)
        }

    }

    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }

    func hideAddressPhone() {
        addressIcon.isHidden = true
        addressLabel.isHidden = true
        phoneIcon.isHidden = true
        phoneLabel.isHidden = true
    }

    func configureData(_ branch: BranchModel) {
        branchNameLabel.text = branch.branchName
        addressLabel.text = branch.address
        phoneLabel.text = branch.phoneNumber

        if let todayScheduleText = branch.todaySchedule {
            branchScheduleLabel.text = "\(S.todaySchedule) \(todayScheduleText)"
        } else {
            branchScheduleLabel.text = S.scheduleNotAvailanle
        }
    }

    func configureDataModal(branchName: String) {
        branchNameLabel.text = branchName
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
