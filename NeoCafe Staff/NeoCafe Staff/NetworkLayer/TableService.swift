//
//  TableService.swift
//  NeoCafe Staff
//
import Foundation

class TableService {
    static let shared = TableService()
    @InjectionInjected(\.networkService) var networkService: NetworkServiceProtocol

    var tables: [TableModel] = []
    private var listeners: [(TableModel) -> Void] = []

    private init() {}

    func getTables(completion: (() -> Void)? = nil) {
        networkService.sendRequest(successModelType: [TableModel].self,
                                   endpoint: MultiTarget(UserAPI.getTablesByBranch(branchID: UserDefaultsService.shared.branchID))) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.tables = response
                    self.notifyListeners()
                    completion?()
                case .failure(let error):
                    print("handle error: \(error)")
                }
            }
        }
    }

    func addListener(listener: @escaping (TableModel) -> Void) {
        listeners.append(listener)
    }

    private func notifyListeners() {
        tables.forEach { table in
            listeners.forEach { listener in
                listener(table)
            }
        }
    }
}
