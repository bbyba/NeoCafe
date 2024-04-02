//
// CodeConfirmationView.swift
// NeoCafe Client
//

import Foundation
import SnapKit
import SVPinView

class CodeConfirmationView: UIStackView {
    lazy var enterCodeMessageLabel: UILabel = {
        let label = UILabel()
        label.text = S.otpCodeLabel
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var otpField: SVPinView = {
        let pinView = SVPinView()
        pinView.pinLength = 4
        pinView.interSpace = 8
        pinView.textColor = .darkBlueCustom
        pinView.font = .poppins(ofSize: 20, weight: .regular)
        pinView.keyboardType = .numberPad
        pinView.shouldSecureText = false
        pinView.fieldBackgroundColor = .greyCustom
        pinView.style = .underline
        pinView.deleteButtonAction = .deleteCurrent
        pinView.pinInputAccessoryView = UIView()
        return pinView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 16
        addSubviews()
    }

    private func addSubviews() {
        addArrangedSubview(enterCodeMessageLabel)
        addArrangedSubview(otpField)
        self.alignment = .center

        otpField.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.height.equalTo(52)
            make.top.equalTo(enterCodeMessageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
