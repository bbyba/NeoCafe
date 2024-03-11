////
////  Network.swift
////  NeoCafe Client
////
//
//import Foundation
//import Moya
//
//class PathCollection {
//
//    // MARK: - Base
//    static let baseUrl = URL(string: "https://tokyo-backender.org.kg")!
//
//    // MARK: - Registration
//    enum Registration {
//        static func checkEmailRegister() -> URL {
//            baseUrl.appendingPathComponent("/customer/check-email-register/")
//        }
//
//        static func registerUser() -> URL {
//            baseUrl.appendingPathComponent("/customer/register/")
//        }
//    }
//
//    // MARK: - Authorization
//    enum Authorization {
//        static func checkEmailLogin() -> URL {
//            baseUrl.appendingPathComponent("/customer/check-email-login/")
//        }
//
//        static func loginUser() -> URL {
//            baseUrl.appendingPathComponent("/customer/login/")
//        }
//    }
//
//    // MARK: - Categories
//    enum Menu {
//        static func getCategories() -> URL {
//            baseUrl.appendingPathComponent("/menu/category/all/")
//        }
//
//        static func getMenu(id: Int) -> URL {
////            baseUrl.appendingPathComponent("/menu/get-all/\(id)")
//            baseUrl.appendingPathComponent("/menu/category/{id}/")
//        }
//    }
//
//
//}
