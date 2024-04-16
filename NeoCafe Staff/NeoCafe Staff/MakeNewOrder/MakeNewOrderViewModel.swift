//
//  MakeNewOrderViewModel.swift
//  NeoCafe Staff
//
import Foundation

protocol MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onOrderNavigate: EmptyCompletion? { get set }
//    var orderedItems: [WaiterItem] {  get set }
}

class MakeNewOrderViewModel: NSObject, MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?
    var table: TableModel?

    init(table: TableModel?) {
        self.table = table
        super.init()
    }
}
