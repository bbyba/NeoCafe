//
//  SquareCheckbox.swift
//  NeoCafe Staff
//

import UIKit

final class SquareCheckbox: UIView {
    private var isChecked = false

    lazy var orangeCheck: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.tintColor = .orangeCustom
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.blueCustom.cgColor
        backgroundColor = .greyCustom

        addSubviews()
        setupConstraints()
    }

    func toggle() {
        isChecked = !isChecked
        orangeCheck.isHidden = !isChecked
    }

    func addSubviews() {
        addSubview(orangeCheck)
    }

    func setupConstraints() {
        orangeCheck.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// contentView.squareCheckbox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(squareCheckboxTapped)))
//
// @objc private func squareCheckboxTapped() {
// contentView.squareCheckbox.toggle()
// }
