//
//  EditProfileViewController.swift
//  NeoCafe Client
//

import UIKit

class EditProfileViewController: BaseViewController<EditProfileViewModel, EditProfileView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

    }

    func configureData(_ userData: CustomerProfile) {
        contentView.nameTextField.text = userData.firstName
        contentView.emailTextField.text = userData.email
    }

    func showAlert(withTitle title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func saveButtonTapped() {
        guard let newName = contentView.nameTextField.text, !newName.isEmpty else {
            print("Please enter a name.")
            return
        }

        viewModel.patchProfile(firstName: newName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedProfile):
                    self?.viewModel.personalDataEdit = updatedProfile
                    self?.configureData(updatedProfile)
//                    router.showAlert(withTitle: "Profile Update", message: "Successfully updated profile.")
                    self?.showAlert(withTitle: "Редактирование", message: "Редактирование прошло успешно.") {
                        self?.viewModel.onEditCompleted?()
                    }
                case .failure(let error):
                    print("Error updating profile: \(error.localizedDescription)")
                    self?.showAlert(withTitle: "Profile Update", message: "Could not update the profile.") {
                        self?.viewModel.onEditCompleted?()
                    }
                }
            }
        }
    }
}


