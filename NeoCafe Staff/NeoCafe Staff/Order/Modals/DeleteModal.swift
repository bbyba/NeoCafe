//
//  DeleteModal.swift
//  NeoCafe Staff
//

import UIKit
import SnapKit

class DeleteModalView: UIView {

    lazy var blurredBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.deleteFromOrder
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var noButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.no, backgroundColor: .lightBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var yesButton : CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.yes, backgroundColor: .clear, titleColor: .lightBlueCustom, showBorder: true)
        return button
    }()

    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noButton, yesButton])
        stackView.axis = .horizontal
        stackView.spacing = 13
        stackView.alignment = .center
        return stackView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DeleteModalView: BaseContentView {

    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview((headerLabel))
        contentView.addSubview(buttonStack)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }

        buttonStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
    }

}
