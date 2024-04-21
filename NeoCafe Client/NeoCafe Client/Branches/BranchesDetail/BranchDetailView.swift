//
//  BranchDetailView.swift
//  NeoCafe Client
//
import SnapKit
import SwiftUI
import UIKit

class BranchDetailView: UIView {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Asset.branchesDetail.name)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()

    lazy var branchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "NeoCafe Dzerzhinka"
        label.font = .poppins(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var branchAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "бульвар Эркиндик, 35"
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .blueCustom
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = S.schedule
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .blueCustom
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.backButton.image, for: .normal)
        return button
    }()

    lazy var phoneButton: UIButton = {
        let button = UIButton()
        let phoneImage = Asset.Buttons.phoneIcon.image.withRenderingMode(.alwaysTemplate)
        button.setImage(phoneImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orangeCustom
        button.layer.cornerRadius = 22
        return button
    }()

    lazy var locationButton: UIButton = {
        let button = UIButton()
        let locationImage = Asset.Buttons.location.image.withRenderingMode(.alwaysTemplate)
        button.setImage(locationImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orangeCustom
        button.layer.cornerRadius = 22
        return button
    }()

    lazy var dropDownButton: UIButton = {
        let button = UIButton()
        let dropDownImage = Asset.dropDownIcon.image.withRenderingMode(.alwaysTemplate)
        button.setImage(dropDownImage, for: .normal)
        button.tintColor = .darkBlueCustom
        return button
    }()

    lazy var goToMenuButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.menuButton, backgroundColor: .darkBlueCustom)
        return button
    }()

    lazy var scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isHidden = true
        return tableView
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(cell: MenuProductCell.self)
        collectionView.register(header: CollectionViewSingleHeader.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()

    lazy var scheduleLabelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    func toggleScheduleTableView(hidden: Bool) {
        scheduleTableView.isHidden = hidden

        let topConstraint = hidden ? scheduleLabelStack.snp.bottom : scheduleTableView.snp.bottom

        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(topConstraint).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(goToMenuButton.snp.top).offset(-16)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BranchDetailView {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .absolute(207)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                      leading: 0,
                                                      bottom: 8,
                                                      trailing: 8)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        header.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                       leading: 16,
                                                       bottom: 0,
                                                       trailing: 16)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension BranchDetailView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(image)
        addSubview(backButton)
        addSubview(branchNameLabel)
        addSubview(branchAddressLabel)
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(phoneButton)
        buttonStack.addArrangedSubview(locationButton)
        addSubview(scheduleLabelStack)
        scheduleLabelStack.addArrangedSubview(scheduleLabel)
        scheduleLabelStack.addArrangedSubview(dropDownButton)
        addSubview(scheduleTableView)
        addSubview(collectionView)
        addSubview(goToMenuButton)
    }

    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(40)
        }

        branchNameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(29)
        }

        branchAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(branchNameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(branchAddressLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        phoneButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.width.equalTo(44)
        }

        locationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.width.equalTo(44)
        }

        scheduleLabelStack.snp.makeConstraints { make in
            make.top.equalTo(buttonStack.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }

        scheduleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }

        dropDownButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.width.equalTo(24)
        }

        scheduleTableView.snp.makeConstraints { make in
            make.top.equalTo(scheduleLabelStack.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(scheduleLabelStack.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(goToMenuButton.snp.top).offset(-16)
        }

        goToMenuButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(16)
            make.height.equalTo(54)
        }
    }
}
