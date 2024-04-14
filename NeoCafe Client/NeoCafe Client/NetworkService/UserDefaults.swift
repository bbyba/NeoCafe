import Foundation

class UserDefaultsService {

    static let shared = UserDefaultsService()
    private init() {}

    enum Token: String {
        case accessToken
        case refreshToken
    }

    enum BranchData: String {
        case branchID
        case branchName
    }

    enum ProfileData: String {
        case customerID
        case userID
        case firstName
        case email
        case bonusPoints
    }

    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: Token.accessToken.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Token.accessToken.rawValue) }
    }

    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: Token.refreshToken.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Token.refreshToken.rawValue) }
    }

    var customerProfile: CustomerProfile? {
        get {
            guard let customerID = UserDefaults.standard.object(forKey: ProfileData.customerID.rawValue) as? Int?,
                  let userID = UserDefaults.standard.object(forKey: ProfileData.userID.rawValue) as? Int?,
                  let firstName = UserDefaults.standard.string(forKey: ProfileData.firstName.rawValue),
                  let email = UserDefaults.standard.string(forKey: ProfileData.email.rawValue),
                  let bonusPoints = UserDefaults.standard.object(forKey: ProfileData.bonusPoints.rawValue) as? Int? else {
                return nil
            }
            return CustomerProfile(id: customerID ?? 0, userID: userID ?? 0, firstName: firstName, email: email, bonusPoints: bonusPoints ?? 0)
        }
        set {
            UserDefaults.standard.set(newValue?.id, forKey: ProfileData.customerID.rawValue)
            UserDefaults.standard.set(newValue?.userID, forKey: ProfileData.userID.rawValue)
            UserDefaults.standard.set(newValue?.firstName, forKey: ProfileData.firstName.rawValue)
            UserDefaults.standard.set(newValue?.email, forKey: ProfileData.email.rawValue)
            UserDefaults.standard.set(newValue?.bonusPoints, forKey: ProfileData.bonusPoints.rawValue)
        }
    }

    var branchID: Int {
        get { UserDefaults.standard.integer(forKey: BranchData.branchID.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: BranchData.branchID.rawValue) }
    }

    var branchName: String? {
        get { UserDefaults.standard.string(forKey: BranchData.branchName.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: BranchData.branchName.rawValue) }
    }

    func saveTokens(response: AuthResponseModel) {
        self.accessToken = response.accessToken
        self.refreshToken = response.refreshToken
    }

    func saveCustomerProfile(profile: CustomerProfile) {
        self.customerProfile = profile
    }

    func saveBranchData(response: BranchModel) {
        self.branchName = response.branchName
        self.branchID = response.id
    }
}
