import UIKit

public protocol ContentViewSetupable: UIView {
    func addSubviews()
    func setupConstraints()
}

public protocol BaseContentView: ContentViewSetupable {
    func setProperties()
}

public extension BaseContentView {
    func setProperties() {}
}
