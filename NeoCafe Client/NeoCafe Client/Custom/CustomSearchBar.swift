//
//  CustomSearchBar.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

class CustomSearchBar: UIView {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = S.search
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orangeCustom
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.layer.cornerRadius = 23
        button.tintColor = .white
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        addSubviews()
        setupConstraints()
    }

    private func setupBackground() {
        backgroundColor = .greyCustom
        layer.cornerRadius = 23
        layer.masksToBounds = true
    }

    private func addSubviews() {
        addSubview(textField)
        addSubview(searchButton)
    }

    private func setupConstraints() {
        searchButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.height.width.equalTo(48)
        }

        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(22)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
