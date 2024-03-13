////
////  BonusViewController.swift
////  NeoCafe Client
////
//import Foundation
//
//class BonusViewController: BaseViewController<BonusModalViewModel, BonusModalView> {
//
//    override func setTargets() {
//        contentView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
//        contentView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
//        contentView.goodButton.addTarget(self, action: #selector(goodButtonTapped), for: .touchUpInside)
//    }
//
//
//    @objc func yesButtonTapped() {
//        delegate?.didRequestNextState()
//    }
//
//    @objc func noButtonTapped() {
//        delegate?.didRequestPreviousState()
//    }
//
//    @objc func goodButtonTapped() {
//        delegate?.didRequestDismissal()
//    }
//
//
//}
