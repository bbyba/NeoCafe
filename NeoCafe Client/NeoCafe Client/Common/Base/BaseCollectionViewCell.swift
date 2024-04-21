//
//  BaseCollectionViewCell.swift
//  NeoCafe Client
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    open func setupUI() {}
}
