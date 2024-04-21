//
//  CustomHeaderView.swift
//  NeoCafe Staff
//

import UIKit

class CustomHeaderView: UIView {
    lazy var headerSection: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .ivoryCustom
        return view
    }()

    lazy var headerImage: UIImageView = {
        let imageView = UIImageView(image: Asset.twoBeans.image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(headerSection)
        headerSection.addSubview(headerImage)
    }

    func setupConstraints() {
        headerSection.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }

        headerImage.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.equalTo(headerSection)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
