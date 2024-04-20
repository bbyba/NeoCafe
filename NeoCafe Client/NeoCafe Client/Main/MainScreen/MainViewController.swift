//
//  ViewController.swift
//  NeoCafe Client
//

import UIKit
import SwiftUI

class MainViewController: BaseViewController<MainViewModel, MainView> {
    var loadingIndicator: UIActivityIndicatorView?
    var selectedBranchName: String?
    var selectedBranchID: Int? {
        didSet {
            setupBindings()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        viewModel.onBranchesModalNavigate?()
//        viewModel.getCategories()
        viewModel.getPopularItems()
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    func addTargets() {
        contentView.notificationButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
    }

    func updateForSelectedBranch() {
        setupBindings()
    }

    private func setupBindings() {
        viewModel.onCategoriesFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator?.stopAnimating()
                self?.contentView.collectionView.isHidden = false
                self?.contentView.collectionView.reloadData()
            }
        }

        viewModel.onPopularItemsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.collectionView.reloadData()
            }
        }
    }

    @objc func notificationsButtonTapped() {
        viewModel.onNotificationsNavigate?()
    }

    @objc func goToMenuTapped() {
        viewModel.onMenuNavigate?()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .category:
            return viewModel.categories.count
        case .popular:
            return min(viewModel.popularItems.count, 3)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
        case .category:
            let cell: CategoryCell = collectionView.dequeue(for: indexPath)
            let category = viewModel.categories[indexPath.row]
            cell.configureData(name: category.name, imageName: category.image!)
            return cell
        case .popular:
            let cell: BigProductCell = collectionView.dequeue(for: indexPath)
            let popularItem = viewModel.popularItems[indexPath.row]
            cell.configureData(item: popularItem)
            cell.plusButton.isHidden = false
            cell.plusButton.isUserInteractionEnabled = true
            cell.onAddToCart = { [weak self] popularItem in
                self?.viewModel.addToCart(menuItem: popularItem)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)

        if let sectionKind = Section(rawValue: Section.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .category:
                header.configureTitle(title: S.ourMenu)
                header.configureButton(title: S.menuButton, isVisible: true)
                header.button.addTarget(self, action: #selector(goToMenuTapped), for: .touchUpInside)
            case .popular:
                header.configureTitle(title: S.popular)
                header.button.isHidden = true
            }
        }
        return header
    }
}
