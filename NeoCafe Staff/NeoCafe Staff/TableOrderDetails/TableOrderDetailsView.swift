//
//  TableOrderDetailsView.swift
//  NeoCafe Staff
//
import SnapKit
import UIKit

class TableOrderDetailsView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var orderNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var statusAndTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .regular)
        label.textColor = .darkBlueCustom
        label.textAlignment = .center
        return label
    }()

    lazy var waiterNameLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.textAlignment = .left
        return label
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = S.total
        label.textAlignment = .center
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .orangeCustom
        return label
    }()

    lazy var totalPriceLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
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
        return view
    }()

    lazy var statusStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusCircle, statusLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()

    lazy var backButton = CustomRoundButton(withImage: Asset.Images.arrowBack.image,
                                            backgroundColor: .lightBlueCustom)

    lazy var closeOrderButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.closeOrder,
                             backgroundColor: .whiteCustom,
                             titleColor: .blueCustom,
                             showBorder: true)
        return button
    }()

    lazy var addButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.add, backgroundColor: .blueCustom)
        return button
    }()

    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [closeOrderButton, addButton])
        stackView.axis = .horizontal
        stackView.spacing = 7
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: CustomBigCell.self)
        collectionView.register(header: CollectionViewHeader.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    func configureUI(orderDetail: OrderDetailsModel) {
        headerLabel.text = S.tableNo(orderDetail.table.tableNumber)
        orderNumberLabel.text = S.numberSymbol(orderDetail.orderNumber)
        statusAndTimeLabel.text = "Time: \(String(describing: orderDetail.createdAt))"
        waiterNameLabel.text = S.waiter(orderDetail.employeeProfile.user.firstName)
        updateUI(status: orderDetail.orderStatus)
    }

    func updateUI(status: String) {
        switch status {
        case "Новый":
            statusCircle.backgroundColor = .skyBlueCustom
            statusLabel.text = S.newStatus
            buttonStack.isHidden = false
        case "В процессе":
            statusCircle.backgroundColor = .yellowCustom
            statusLabel.text = S.processingStatus
            buttonStack.isHidden = false
        case "Готово":
            statusCircle.backgroundColor = .systemGreen
            statusLabel.text = S.readyStatus
            addButton.isHidden = true
        case "Завершено":
            statusCircle.backgroundColor = .greyCustom
            statusLabel.text = S.doneStatus
            addButton.isHidden = true
        default:
            statusCircle.backgroundColor = .darkGreyCustom
            statusLabel.text = S.cancelledStatus
            buttonStack.isHidden = true
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                      leading: 16,
                                                      bottom: 8,
                                                      trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableOrderDetailsView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(orderNumberLabel)
        addSubview(statusAndTimeLabel)
        addSubview(waiterNameLabel)
        addSubview(statusStack)
        addSubview(collectionView)
        addSubview(totalPriceLabel)
        addSubview(buttonStack)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        orderNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(40)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
        }

        statusAndTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(40)
            make.height.equalTo(19)
            make.trailing.equalToSuperview().offset(-24)
        }

        waiterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(orderNumberLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        statusStack.snp.makeConstraints { make in
            make.top.equalTo(waiterNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(statusStack.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonStack.snp.top).offset(-50)
        }

        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(buttonStack.snp.top).offset(-12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        buttonStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }

        statusCircle.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
    }
}
