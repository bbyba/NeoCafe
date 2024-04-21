import UIKit

open class BaseTableViewCell: UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    open func setupUI() {}
}
