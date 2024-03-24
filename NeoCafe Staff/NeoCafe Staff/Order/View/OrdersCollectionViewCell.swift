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
        label.text = S.tableNo
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
        label.text = "№"
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
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
        //        updateCellAppearanceByStatus(status: String)
    }

    func configureData(orderData: OrderModel) {
        tableNumber.text = "Стол №\(orderData.tableNumber)"
        orderNumber.text = "№\(orderData.orderNumber)"
        timeLabel.text = orderData.time
        updateCellAppearanceByStatus(status: orderData.status)
    }

    func updateCellAppearanceByStatus(status: String) {
        switch status {
        case "Новый":
            statusCircle.backgroundColor = .skyBlueCustom
            statusLabel.text = S.newOrder
        case "В процессе":
            statusCircle.backgroundColor = .yellowCustom
            statusLabel.text = S.processingStatus
        case "Готово":
            statusCircle.backgroundColor = .systemGreen
            statusLabel.text = S.readyStatus
        case "Завершено":
            statusCircle.backgroundColor = .greyCustom
            statusLabel.text = S.doneStatus
//        case "Отменено":
//            statusCircle.backgroundColor = .darkGreyCustom
//            statusLabel.text = S.cancelledStatus
        default:
            statusCircle.backgroundColor = .darkGreyCustom
            statusLabel.text = S.cancelledStatus
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrdersCollectionViewCell: BaseContentView {
    func setProperties() {
        backgroundColor = .greenTableCustom
        layer.cornerRadius = 14
    }

    func addSubviews() {
        contentView.addSubview(tableNumber)
        contentView.addSubview(statusStack)
        contentView.addSubview(orderNumber)
        contentView.addSubview(timeLabel)
    }

    func setupConstraints() {
        tableNumber.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }

        statusStack.snp.makeConstraints { make in
            make.top.equalTo(tableNumber.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
        }

        orderNumber.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(orderNumber.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
