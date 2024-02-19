//
//  ViewController.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    private lazy var mainView = MainView()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        //            baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct VCPreview: PreviewProvider {
    static var previews: some View {
        MainViewController().showPreview()
    }
}
#endif
