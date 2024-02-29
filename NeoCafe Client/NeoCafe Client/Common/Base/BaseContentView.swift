import UIKit

public protocol ContentViewSetupable: UIView {
    func addSubviews()
    func setConstraints()
}

public protocol BaseContentView: ContentViewSetupable {
    func setProperties()
}

public extension BaseContentView {
    func setProperties() {}
}
