import UIKit

class CustomTextField: UITextField {
    var iconName: UIImage?
    var customPlaceholder: String?
    var isPasswordField: Bool

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()

    init(iconName: UIImage?, customPlaceholder: String, isPasswordField: Bool = false) {
        self.iconName = iconName
        self.customPlaceholder = customPlaceholder
        self.isPasswordField = isPasswordField
        super.init(frame: .zero)
        isPasswordField ? setupSecureTextField() : setupTextField()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let leftView = self.leftView {
            leftView.frame = CGRect(x: 0, y: 0, width: 40, height: bounds.height)
            iconImageView.frame = CGRect(x: 10, y: 0, width: 20, height: bounds.height)
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }

    private func setupTextField() {
        autocapitalizationType = .none
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        backgroundColor = .greyCustom
        textColor = .darkBlueCustom
        font = .sFProDisplayFont(ofSize: 16)
        attributedPlaceholder = NSAttributedString(string: customPlaceholder ?? "", attributes: [NSAttributedString.Key.font: font])
        layer.cornerRadius = 18
        iconImageView.isHidden = iconName == nil
        iconImageView.image = iconName

        if let iconName = iconName {
            let leftViewContainer = UIView()
            leftViewContainer.addSubview(iconImageView)
            leftView = leftViewContainer
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }
    }

    private func setupSecureTextField() {
        setupTextField()
        isSecureTextEntry = true
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        toggleButton.tintColor = .darkGreyCustom
        toggleButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        toggleButton.addTarget(self, action: #selector(toggleSecureTextEntry), for: .touchUpInside)
        rightView = toggleButton
        rightViewMode = .always
    }

    @objc private func toggleSecureTextEntry(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected = !isSecureTextEntry
    }
}
