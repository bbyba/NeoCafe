//
//  CartView.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

class CartView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.cart
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .left
        return label
    }()

    lazy var takeOutLabel: UILabel = {
        let label = UILabel()
        label.text = S.toGoShort
        label.font = .poppins(ofSize: 20, weight: .bold)
        label.textColor = .whiteCustom
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: BigProductCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

//    lazy var totalPriceLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = .poppins(ofSize: 14, weight: .semibold)
//        label.textColor = .darkBlueCustom
//        return label
//    }()

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

    lazy var nameFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .orangeCustom
        view.layer.cornerRadius = 24
        return view
    }()

    lazy var orderHistoryButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.orderHistory.image, for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    lazy var addMoreButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.addMore, backgroundColor: .clear, titleColor: .orangeCustom, showBorder: true)
        button.titleLabel?.font = .poppins(ofSize: 16, weight: .medium)
        button.isUserInteractionEnabled = true
        return button
    }()

    lazy var orderButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.order, backgroundColor: .darkBlueCustom)
        return button
    }()

    lazy var emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = S.emptyCart
        label.textAlignment = .center
        label.font = .poppins(ofSize: 20, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var emptyCartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.emptyCartImage.name)
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var toMenuButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.toMenu, backgroundColor: Asset.Colors.darkBlue.color)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    func switchCartViews(cartEmpty: Bool) {
        emptyCartLabel.isHidden = !cartEmpty
        emptyCartImage.isHidden = !cartEmpty
        toMenuButton.isHidden = !cartEmpty
        nameFieldView.isHidden = cartEmpty
        collectionView.isHidden = cartEmpty
        addMoreButton.isHidden = cartEmpty
//        totalPriceLabel.isHidden = cartEmpty
        totalLabel.isHidden = cartEmpty
        priceLabel.isHidden = cartEmpty
        orderButton.isHidden = cartEmpty
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.37)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerLabel)
        header.addSubview(orderHistoryButton)
        addSubview(nameFieldView)
        nameFieldView.addSubview(takeOutLabel)
        addSubview(collectionView)
        addSubview(addMoreButton)
//        addSubview(totalPriceLabel)
        addSubview(totalLabel)
        addSubview(priceLabel)

        addSubview(orderButton)
        addSubview(emptyCartLabel)
        addSubview(emptyCartImage)
        addSubview(toMenuButton)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(70)
        }

        orderHistoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(40)
            make.height.width.equalTo(40)
        }

        nameFieldView.snp.makeConstraints { make in
            make.centerY.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        takeOutLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameFieldView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addMoreButton.snp.top).offset(-20)
        }

        addMoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(totalLabel.snp.top).offset(-41)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        totalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(orderButton.snp.top).offset(-12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(orderButton.snp.top).offset(-12)
            make.leading.equalTo(totalLabel.snp.trailing).offset(5)
            make.height.equalTo(24)
        }

        orderButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }

        emptyCartLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }

        emptyCartImage.snp.makeConstraints { make in
            make.top.equalTo(emptyCartLabel.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(toMenuButton.snp.top).offset(-108)
        }

        toMenuButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }

        emptyCartLabel.isHidden = true
        emptyCartImage.isHidden = true
        toMenuButton.isHidden = true
    }
}
