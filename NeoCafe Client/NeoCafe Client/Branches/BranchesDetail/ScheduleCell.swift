//
//  ScheduleCell.swift
//  NeoCafe Client
//
import UIKit

class ScheduleTableViewCell: UITableViewCell {

    lazy var workingHours = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var descriptionLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 12, weight: .regular)
        label.textColor = .darkBlueCustom
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(workingHours)
    }

    func setupConstraints() {
        workingHours.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
