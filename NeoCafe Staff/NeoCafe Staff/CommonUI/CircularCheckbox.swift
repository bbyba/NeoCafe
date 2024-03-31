//
//  CircularCheckbox.swift
//  NeoCafe Staff
//

import UIKit

final class CircularCheckbox: UIView {
    private var isChecked = false

    lazy var orangeCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeCustom
        view.layer.cornerRadius = 5
        view.isHidden = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.blueCustom.cgColor
        layer.cornerRadius = 10
        backgroundColor = .greyCustom

        addSubviews()
        setupConstraints()

    }

    func toggle() {
        self.isChecked = !isChecked
        if self.isChecked {
            orangeCircle.isHidden = false
        } else {
            orangeCircle.isHidden = true
        }
    }

    func addSubviews() {
        addSubview(orangeCircle)
    }

    func setupConstraints() {
        orangeCircle.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//contentView.checkBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(circularCheckboxTapped)))
//
//@objc private func circularCheckboxTapped() {
//contentView.checkBox.toggle()
//}
