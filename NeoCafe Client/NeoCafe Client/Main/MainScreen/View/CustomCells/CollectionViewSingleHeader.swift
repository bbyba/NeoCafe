//
//  CollectionViewSingleHeader.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

class CollectionViewSingleHeader: BaseCollectionViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .poppins(ofSize: 16, weight: .regular)
        button.setTitleColor(.orangeCustom, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        button.isHidden = true
    }

    func configureTitle(title: String) {
            titleLabel.text = title
        }

    func configureButton(title: String, isVisible: Bool) {
            button.setTitle(title, for: .normal)
            button.isHidden = !isVisible
        }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(button)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        button.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
