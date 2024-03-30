import UIKit

open class BaseTableViewCell: UITableViewCell {
    static public var reuseIdentifier: String {
        return String(describing: self)
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    open func setupUI() {}
}
