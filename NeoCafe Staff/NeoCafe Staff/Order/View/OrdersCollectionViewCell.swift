//
//  OrdersCollectionViewCell.swift
//  NeoCafe Staff
//

import UIKit

enum TableStatus {
    case new, processing, ready, done, cancelled
}

class OrdersCollectionViewCell: BaseCollectionViewCell {
    lazy var tableNumber: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var orderNumber: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .blueCustom
        return label
    }()

    lazy var statusCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    lazy var statusStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusCircle, statusLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
        setBorder()
        //        updateCellAppearanceByStatus(status: String)
    }

    func configureData(orderData: OrderDetailsModel) {
        tableNumber.text = S.tableNo(orderData.table.tableNumber)
        orderNumber.text = S.numberSymbol(orderData.orderNumber)
        updateTimeByStatus(orderData: orderData)
        updateCellAppearanceByStatus(status: orderData.orderStatus)
    }

    func updateTimeByStatus(orderData: OrderDetailsModel) {
        switch orderData.orderStatus {
        case "Новый":
            timeLabel.text = orderData.createdAt
        case "Завершено":
            timeLabel.text = orderData.completedAt
        default:
            timeLabel.text = orderData.updatedAt
        }
    }

    func updateCellAppearanceByStatus(status: String) {
        switch status {
        case "Новый":
            statusCircle.backgroundColor = .skyBlueCustom
            statusLabel.text = S.newStatus
        case "В процессе":
            statusCircle.backgroundColor = .yellowCustom
            statusLabel.text = S.processingStatus
        case "Готово":
            statusCircle.backgroundColor = .systemGreen
            statusLabel.text = S.readyStatus
        case "Завершено":
            statusCircle.backgroundColor = .greyCustom
            statusLabel.text = S.doneStatus
        default:
            statusCircle.backgroundColor = .darkGreyCustom
            statusLabel.text = S.cancelledStatus
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrdersCollectionViewCell: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
        layer.cornerRadius = 14
    }

    func setBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.greyCustom.cgColor
    }

    func addSubviews() {
        contentView.addSubview(tableNumber)
        contentView.addSubview(statusStack)
        contentView.addSubview(orderNumber)
        contentView.addSubview(timeLabel)
    }

    func setupConstraints() {
        tableNumber.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(14)
        }

        statusStack.snp.makeConstraints { make in
            make.top.equalTo(tableNumber.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(16)
        }

        orderNumber.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(orderNumber.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }

        statusCircle.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
    }
}
