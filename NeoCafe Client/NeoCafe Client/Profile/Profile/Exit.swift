//
//  Exit.swift
//  NeoCafe Client
//
import UIKit
import SnapKit


class ExitModalView: UIView {

    var currentState: BonusModalState = .initialState

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
        label.text = S.logout
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = S.logoutConfirmation
        label.font = .poppins(ofSize: 16, weight: .medium)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var yesButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.yes, backgroundColor: .darkBlueCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var noButton : CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.no, backgroundColor: .clear, titleColor: .darkBlueCustom, showBorder: true)
        return button
    }()

    lazy var yesNoButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noButton, yesButton])
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExitModalView: BaseContentView {
    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview((headerLabel))
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(yesNoButtonStack)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(210)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        yesNoButtonStack.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(24)
            make.height.equalTo(54)
        }
    }
}

class ExitViewController: BaseViewController<BonusModalViewModel, ExitModalView> {
    var onLogout: EmptyCompletion?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.errorPresenter = self
        addTargets()
    }

    func addTargets() {
        contentView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        contentView.noButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc private func yesButtonTapped() {
        exit(0)
    }

    @objc private func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
