//
//  NotificationView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class NotificationView: UIView {

    lazy var header = CustomHeaderView()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.backButton.image, for: .normal)
        return button
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.notifications
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .center
        return label
    }()

    lazy var clearAllButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppins(ofSize: 16, weight: .semibold),
            .foregroundColor: UIColor.orangeCustom,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedTitle = NSAttributedString(string: S.clearAll, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)

        addSubview(clearAllButton)

    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            //            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
            //            make.centerY.equalToSuperview()
        }

        clearAllButton.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(40)
//            make.top.equalToSuperview().offset(156)
            make.height.equalTo(19)
            make.trailing.equalToSuperview().offset(-24)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
