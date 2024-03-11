//
//  NotificationsCell.swift
//  NeoCafe Client
//

import UIKit


class NotificationsCell: UICollectionViewCell {
    static let identifier = "NotificationsCell"

    lazy var orderStatusLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.text = "Ваш заказ готов"
        return label
    }()

    lazy var orderDetailsLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = "Капучино x1, Американо x2, Багровай зКапучино x1, Американо x2, Багровай за"
        return label
    }()

    lazy var timeLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.text = "19:02"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
        addSubviews()
        setupConstraints()
        setBorder()
    }

    private func addSubviews() {
        contentView.addSubview(orderStatusLabel)
        contentView.addSubview(orderDetailsLabel)
        contentView.addSubview(timeLabel)
    }

    func setupConstraints() {
        orderStatusLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }

        orderDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(orderStatusLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(16)

        }

        timeLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
    }


    func configureData(status: String, details: String, time: String) {
        orderStatusLabel.text = status
        orderDetailsLabel.text = details
        timeLabel.text = time
    }

    func setBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkBlueCustom.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
