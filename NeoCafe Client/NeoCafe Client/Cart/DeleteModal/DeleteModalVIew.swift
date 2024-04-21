//
import SnapKit

//  DeleteModalView.swift
//  NeoCafe Client
//
import UIKit

class DeleteModalView: UIView {
    var itemName: String

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
        label.text = S.deleteFromOrder(itemName.lowercased())
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var noButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.no, backgroundColor: .clear, titleColor: .darkBlueCustom, showBorder: true)
        return button
    }()

    lazy var yesButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.yes, backgroundColor: .darkBlueCustom, titleColor: .white)
        return button
    }()

    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noButton, yesButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()

    init(frame: CGRect, itemName: String) {
        self.itemName = itemName
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DeleteModalView: BaseContentView {
    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(buttonStack)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.height.equalTo(192)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }

        buttonStack.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.leading.trailing.bottom.equalToSuperview().inset(24)
        }
    }
}