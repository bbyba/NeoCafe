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

    let searchIcon: UIImageView = {
        let icon = UIImageView(image: Asset.magnifyingGlass.image)
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        addSubviews()
        setupConstraints()
    }

    private func setupBackground() {
        backgroundColor = Asset.Colors.grey.color
        layer.cornerRadius = 25
        layer.masksToBounds = true
    }

    private func addSubviews() {
        addSubview(textField)
        addSubview(searchIcon)
    }

    private func setupConstraints() {
        searchIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(34)
        }

        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(22)
            make.trailing.equalTo(searchIcon.snp.leading).offset(-8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
