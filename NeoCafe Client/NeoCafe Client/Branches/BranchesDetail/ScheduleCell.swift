//
//  ScheduleCell.swift
//  NeoCafe Client
//
import UIKit

class ScheduleTableViewCell: UITableViewCell {
//    static let identifier = "ScheduleTableViewCell"

    lazy var workingHours = {
        let label = UILabel()
        label.font = .poppins(ofSize: 14, weight: .semibold)
        label.textColor = .darkBlueCustom
        label.text = "00:00 - 02:00"
        return label
    }()

    lazy var descriptionLabel = {
        let label = UILabel()
        label.font = .poppins(ofSize: 12, weight: .regular)
        label.textColor = .darkBlueCustom
        label.text = "Espresso with Milk"
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

//    func configureData(_ branch: BranchModel) {
//
//        if let todayScheduleText = branch.todaySchedule,
//           let weekDay = branch.todaySchedule
//        {
//            titleLabel.text = "\(weekDay): \(todayScheduleText)"
//        } else {
//            titleLabel.text = S.scheduleNotAvailanle
//        }
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
