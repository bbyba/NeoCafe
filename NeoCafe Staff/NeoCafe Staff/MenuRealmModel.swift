//
//  Menurealm.swift
//
import Foundation
import RealmSwift

class ItemRealmModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var itemImage: String?
    @objc dynamic var pricePerUnit: Int = 0
    @objc dynamic var branch: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(from item: Item) {
        self.init()
        id = item.id
        name = item.name
        itemImage = item.itemImage
        pricePerUnit = item.pricePerUnit
        branch = item.branch ?? 0
    }
}

//
//
// class ItemRealmModel: Object {
//    @objc dynamic var id: Int = 0
//    @objc dynamic var name: String = ""
//    @objc dynamic var itemImage: String?
//    @objc dynamic var pricePerUnit: Int = 0
//    @objc dynamic var branch: Int = 0
//    @objc dynamic var category: CategoryRealm?
//    var ingredients = List<IngredientRealm>()
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//
//    convenience init(from item: Item) {
//        self.init()
//        self.id = item.id
//        self.name = item.name
//        self.itemImage = item.itemImage
//        self.pricePerUnit = item.pricePerUnit
//        self.branch = item.branch ?? 0
//        self.category = CategoryRealm(value: item.category as Any)
//
//        let ingredientRealmList = List<IngredientRealm>()
//        if let ingredients = item.ingredients {
//            for ingredient in ingredients {
//                ingredientRealmList.append(IngredientRealm(value: ingredient))
//            }
//        }
//        self.ingredients = ingredientRealmList
//    }
// }
//
// class IngredientRealm: Object {
//    @objc dynamic var id: Int = 0
//    @objc dynamic var name: String = ""
//    @objc dynamic var quantity: Int = 0
//    @objc dynamic var measurementUnit: String?
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
// }
//
// class CategoryRealm: Object {
//    @objc dynamic var id: Int = 0
//    @objc dynamic var name: String = ""
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
// }
