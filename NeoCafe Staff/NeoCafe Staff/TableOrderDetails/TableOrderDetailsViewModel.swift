//
//  TableOrderDetailsViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol TableOrderDetailsViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onCloseOrderNavigate: EmptyCompletion? { get set }
    var onAddNavigate: EmptyCompletion? { get set }
    var orderedItems: [ITO] {  get set }
}

class TableOrderDetailsViewModel: NSObject, TableOrderDetailsViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onCloseOrderNavigate: EmptyCompletion?
    var onAddNavigate: EmptyCompletion?

    var orderedItems: [ITO] = [
    ]

    var singleOrder: OrderDetailsModel

    init(singleOrder: OrderDetailsModel) {
        self.singleOrder = singleOrder
        super.init()
    }
}
