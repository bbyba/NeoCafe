//
//  BaseCollectionViewCell.swift
//  NeoCafe Client
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    static public var reuseIdentifier: String {
        return String(describing: self)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    open func setupUI() {}
}
