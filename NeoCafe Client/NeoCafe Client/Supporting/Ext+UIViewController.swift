//
//  Ext+UIViewController.swift
//  NeoCafe Client
//
//


import SwiftUI

@available(iOS 15.0, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context _: Context) -> some UIViewController {
            viewController
        }

        func updateUIViewController(_: UIViewControllerType, context _: Context) {

        }
    }

    func showPreview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
}
