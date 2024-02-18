////
////  NetworkService.swift
////  NeoCafe Client
//
//import Foundation
//import Moya
//
//enum UserService {
//    case registerUser(email: String, confirmationCode: Int)
//    case loginUser(email: String, confirmationCode: Int)
//    case checkEmailRegister(email: String)
//    case checkEmailLogin(email: String)
//}
//
//extension UserService: TargetType {
//    var baseURL: URL {
//        return URL(string: "https://tokyo-backender.org.kg/schema/swagger/#/")!
//    }
//    
//    var path: String {
//        switch self {
//        case .checkEmailRegister(_):
//            return "/customer/check-email-register/"
//        case .checkEmailLogin(_):
//            return "/customer/check-email-login/"
//        case .registerUser(_, _):
//            return "/customer/register/"
//        case .loginUser(_, _)):
//            return "/customer/register/"
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//            case .checkEmailRegister(_),
//                 .checkEmailLogin(_):
//                return .post
//            case .registerUser(_, _)),
//                 .loginUser(_, _)):
//                return .post
//            }
//    }
//
//    var task: Task {
//        switch self {
//        case .checkEmailRegister(_),
//                .checkEmailLogin(_):
//            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
//
//        case .registerUser(_, _),
//                .loginUser(_, _)):
//            return .requestParameters(parameters: ["email": email, "confirmationCode": confirmationCode], encoding: JSONEncoding.default)
//        }
//    }
//
//    var headers: [String : String]? {
//        return ["Content-Type": "application-json"]
//    }
//}
