// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Подтвердить
  internal static let confirm = S.tr("Localizable", "confirm", fallback: "Подтвердить")
  /// Введите логин
  internal static let enterLogin = S.tr("Localizable", "enterLogin", fallback: "Введите логин")
  /// Введите пароль
  internal static let enterPassword = S.tr("Localizable", "enterPassword", fallback: "Введите пароль")
  /// Вход
  internal static let entry = S.tr("Localizable", "entry", fallback: "Вход")
  /// example@email.com
  internal static let exampleEmail = S.tr("Localizable", "exampleEmail", fallback: "example@email.com")
  /// Получить код
  internal static let getCode = S.tr("Localizable", "getCode", fallback: "Получить код")
  /// Введите 4-х значный код,
  ///  отправленный на почту 
  ///  email@gmail.com
  internal static let otpCodeLabel = S.tr("Localizable", "OTPCodeLabel", fallback: "Введите 4-х значный код,\n отправленный на почту \n email@gmail.com")
  /// Отправить ещё раз
  internal static let resend = S.tr("Localizable", "resend", fallback: "Отправить ещё раз")
  /// Отправить ещё раз через
  internal static let resendAfter = S.tr("Localizable", "resendAfter", fallback: "Отправить ещё раз через")
  /// Поиск
  internal static let search = S.tr("Localizable", "search", fallback: "Поиск")
  /// Код подтверждения
  internal static let verificationCode = S.tr("Localizable", "verificationCode", fallback: "Код подтверждения")
  /// Localizable.strings
  ///   NeoCafe Staff
  internal static let welcome = S.tr("Localizable", "welcome", fallback: "Добро пожаловать в")
  /// Код введён неверно,
  ///  попробуйте еще раз
  internal static let wrongCode = S.tr("Localizable", "wrongCode", fallback: "Код введён неверно,\n попробуйте еще раз")
  /// Неправильный логин
  internal static let wrongLogin = S.tr("Localizable", "wrongLogin", fallback: "Неправильный логин")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
