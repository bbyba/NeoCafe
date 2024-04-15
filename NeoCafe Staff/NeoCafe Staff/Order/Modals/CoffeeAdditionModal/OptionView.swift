//
//  OptionView.swift
//  NeoCafe Staff
//
import UIKit
import SnapKit

class OptionView: UIView {
    lazy var checkbox = UIView()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [self.checkbox, self.titleLabel])
        stackview.axis = .horizontal
        stackview.spacing = 8
        stackview.alignment = .center
        return stackview
    }()

    init(title: String, milkOption: Bool) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setUpCheckbox(milkOption: milkOption)
        addSubviews()
        setupConstraints()
    }

    private func setUpCheckbox(milkOption: Bool) {
        checkbox = milkOption ? CircularCheckbox() : SquareCheckbox()
        stackView.insertArrangedSubview(checkbox, at: 0)
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        checkbox.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
