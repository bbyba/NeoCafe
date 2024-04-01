//
//  Models.swift
//  NeoCafe Staff
//

import Foundation

// MARK: - Auth

struct ConfirmationResponse: Codable {
    let message, waiterEmail, csrfToken: String

    enum CodingKeys: String, CodingKey {
        case message
        case waiterEmail = "waiter_email"
        case csrfToken = "csrf_token"
    }
}

struct AuthenticationResponse: Codable {
    let message, accessToken, refreshToken: String
    let branchID, userID: Int

    enum CodingKeys: String, CodingKey {
        case message
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case branchID = "branch_id"
        case userID = "user_id"
    }
}

// MARK: - Profile

struct ProfileResponse: Codable {
    let id: Int
    let user: User
    let userType: String
    let branch: Int?

    enum CodingKeys: String, CodingKey {
        case id, user
        case userType = "user_type"
        case branch
    }
}

struct User: Codable {
    let id: Int
    let username, password, firstName: String
    let lastName: Int?
    let email, userType: String
    let branch: Int
    let branchName: String
    let employeeSchedules: [EmployeeSchedule]

    enum CodingKeys: String, CodingKey {
        case id, username, password
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case userType = "user_type"
        case branch
        case branchName = "branch_name"
        case employeeSchedules = "employee_schedules"
    }
}

struct EmployeeSchedule: Codable {
    let day, startTime, endTime: String

    enum CodingKeys: String, CodingKey {
        case day
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
