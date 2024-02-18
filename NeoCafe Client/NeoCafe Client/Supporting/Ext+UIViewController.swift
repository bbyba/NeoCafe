//
//  Ext+UIViewController.swift
//  NeoCafe Client
//
//

import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

            //            if let colorChangeVC = uiViewController as? ColorChangeViewController {
            //                colorChangeVC.toggleColor()
            //            }

        }

    }

    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
}
