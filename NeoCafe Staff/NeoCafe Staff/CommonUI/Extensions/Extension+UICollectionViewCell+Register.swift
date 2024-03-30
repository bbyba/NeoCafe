//
//  Extension+UICollectionViewCell+Register.swift
//  NeoCafe Client
//

import UIKit

extension UICollectionView {
    public func register<T: BaseCollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    public func dequeue<T: BaseCollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    public func register<T: BaseCollectionViewCell>(header: T.Type) {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: T.reuseIdentifier)
    }
    public func dequeue<T: BaseCollectionViewCell>(forHeader indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else {
            fatalError("Failed to dequeue header with identifier: \(T.reuseIdentifier)")
            }
        return header
    }

    public func register<T: BaseCollectionViewCell>(footer: T.Type) {
        register(T.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: T.reuseIdentifier)
    }
    public func dequeue<T: BaseCollectionViewCell>(forFooter indexPath: IndexPath) -> T {
        guard let footer = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
        else {
            fatalError("Failed to dequeue footer with identifier: \(T.reuseIdentifier)")
        }
        return footer
    }
}
