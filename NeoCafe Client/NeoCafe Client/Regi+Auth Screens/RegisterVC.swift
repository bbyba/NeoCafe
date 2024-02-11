//
//  RegisterVC.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.02.
//

import UIKit

class RegisterVC: UIViewController {
    lazy var baseAuthRegView = BaseAuthRegView()
    lazy var registrationView = RegistrationView()
    lazy var signinView = SignInView()

    override func loadView() {
        view = baseAuthRegView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateViewForSegmentIndex(index: baseAuthRegView.segmentedControl.selectedSegmentIndex)
        baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    @objc func segmentedControlValueChanged() {
        let selectedIndex = baseAuthRegView.segmentedControl.selectedSegmentIndex
        updateViewForSegmentIndex(index: selectedIndex)
    }

    private func updateViewForSegmentIndex(index: Int) {
        baseAuthRegView.textFieldStack.subviews.forEach { $0.removeFromSuperview() }

        if index == 0 {
            baseAuthRegView.textFieldStack.addSubview(signinView)
            signinView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            baseAuthRegView.textFieldStack.addSubview(registrationView)
            registrationView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
