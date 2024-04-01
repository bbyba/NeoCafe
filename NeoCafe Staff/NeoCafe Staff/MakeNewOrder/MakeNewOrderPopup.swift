//
//  MakeNewOrderPopup.swift
//  NeoCafe Staff
//
import UIKit
import SnapKit

class MakeNewOrderPopup: UIView {

    lazy var blurredBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlueCustom
        view.layer.cornerRadius = 16
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = S.deleteFromOrder
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .whiteCustom
        label.textAlignment = .center
        return label
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = S.total
        label.textAlignment = .center
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .whiteCustom
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = .poppins(ofSize: 16, weight: .semibold)
        label.textColor = .whiteCustom
        return label
    }()

    lazy var totalPriceLabel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalLabel, priceLabel])
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()

    lazy var orderButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.orders, backgroundColor: .orangeCustom, titleColor: .whiteCustom)
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: CustomBigCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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


extension MakeNewOrderPopup: BaseContentView {

    func addSubviews() {
        addSubview(blurredBackgroundView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(totalPriceLabel)
//        contentView.addSubview(syrupStackView)
        contentView.addSubview(orderButton)
    }

    func setupConstraints() {
        blurredBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(540)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(totalPriceLabel.snp.top).inset(-24)
        }

        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(orderButton.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(16)
        }

        orderButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 3.3))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                      leading: 16,
                                                      bottom: 8,
                                                      trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
