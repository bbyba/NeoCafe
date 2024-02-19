//
//  MainView.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

class MainView: UIView  {
    lazy var headerSection: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = Asset.Colors.blue.color
        return view
    }()

    lazy var headerImage: UIImageView = {
        let imageView = UIImageView(image: Asset.Splash.twoBeans.image)
        return imageView
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.goodMorning
        label.font = FontFamily.Poppins.bold.font(size: 32)
        label.textColor = Asset.Colors.ivory.color
        label.textAlignment = .left
        return label
    }()

    lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        return searchBar
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(headerSection)
        addSubview(headerImage)
        headerSection.addSubview(headerLabel)
        addSubview(searchBar) // Make sure to add this
    }


    func setupConstraints() {
        headerSection.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }

        headerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(headerSection)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.trailing.equalToSuperview()
        }

        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerSection.snp.bottom).offset(searchBar.frame.height / 2)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
