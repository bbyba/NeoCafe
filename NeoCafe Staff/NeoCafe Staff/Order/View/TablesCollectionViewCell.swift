//
//  TablesCollectionViewCell.swift
//  NeoCafe Staff
//

import UIKit

class TablesCollectionViewCell: BaseCollectionViewCell {
    var isBusy: Bool = true

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
        updateCellAppearance()
    }

    func configureData(tableNum: Int, isBusy: Bool) {
        tableNumber.text = "\(tableNum)"
        self.isBusy = isBusy
        updateCellAppearance()
    }

    func updateCellAppearance() {
        if isBusy {
            backgroundColor = .greyCustom
            tableNumber.textColor = .darkBlueCustom
        } else {
            backgroundColor = .greenTableCustom
            tableNumber.textColor = .whiteCustom
        }
    }

    required init?(coder: NSCoder) {
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
