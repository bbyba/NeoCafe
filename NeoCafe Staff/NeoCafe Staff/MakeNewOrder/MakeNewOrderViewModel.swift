//
//  MakeNewOrderViewModel.swift
//  NeoCafe Staff
//
import Foundation

protocol MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onOrderNavigate: EmptyCompletion? { get set }
    var orderedItems: [WaiterItem] {  get set }
}

class MakeNewOrderViewModel: NSObject, MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?

    var orderedItems: [WaiterItem] = [
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп"),
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп"),
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп"),
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп")
    ]
}
