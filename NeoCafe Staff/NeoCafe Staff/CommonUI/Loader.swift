//
//  Loader.swift
//  NeoCafe Staff
//

import UIKit

class Loader {
    static let shared = Loader()
    private var spinnerView = UIActivityIndicatorView(style: .large)

    private init() {}

    func showLoader(view: UIView) {
        DispatchQueue.main.async {
            self.spinnerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(self.spinnerView)
            NSLayoutConstraint.activate([
                self.spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                self.spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            self.spinnerView.startAnimating()
            view.isUserInteractionEnabled = false
        }
    }

    func hideLoader(view: UIView) {
        DispatchQueue.main.async {
            self.spinnerView.stopAnimating()
            self.spinnerView.removeFromSuperview()
            view.isUserInteractionEnabled = true
        }
    }
}
