//
//  TablesCollectionViewCell.swift
//  NeoCafe Staff
//

import UIKit

class TablesCollectionViewCell: BaseCollectionViewCell {
    lazy var tableNumber: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 48, weight: .regular)
        label.textColor = .whiteCustom
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    func configureData(tableModel: TableModel) {
        tableNumber.text = "\(tableModel.tableNumber)"
        let isAvailable = tableModel.isAvailable

        backgroundColor = isAvailable ? .greenTableCustom : .greyCustom
        tableNumber.textColor = isAvailable ? .whiteCustom : .darkBlueCustom
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TablesCollectionViewCell: BaseContentView {
    func setProperties() {
        backgroundColor = .greenTableCustom
        layer.cornerRadius = 14
    }

    func addSubviews() {
        contentView.addSubview(tableNumber)
    }

    func setupConstraints() {
        tableNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(21)
        }
    }
}
