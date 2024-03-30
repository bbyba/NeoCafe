//
//  CollectionViewHeader.swift
//  NeoCafe Staff
//
import UIKit
import SnapKit

class CollectionViewHeader: BaseCollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var statusCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .skyBlue
        return view
    }()

    lazy var statusStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusCircle, statusLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    func configureTitle(title: String) {
        titleLabel.text = title
        titleLabel.isHidden = false
        statusStack.isHidden = true
    }

    func configureStatus(status: String) {
        statusLabel.text = status
        statusStack.isHidden = false
        titleLabel.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewHeader: BaseContentView {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(statusStack)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        statusStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}
