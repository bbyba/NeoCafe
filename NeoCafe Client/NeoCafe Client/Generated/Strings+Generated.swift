// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Филиалы
  internal static let branches = S.tr("Localizable", "branches", fallback: "Филиалы")
  /// Корзина
  internal static let cart = S.tr("Localizable", "cart", fallback: "Корзина")
  /// Подтвердить
  internal static let confirm = S.tr("Localizable", "confirm", fallback: "Подтвердить")
  /// Войти
  internal static let enter = S.tr("Localizable", "enter", fallback: "Войти")
  /// Введите почту
  internal static let enterEmail = S.tr("Localizable", "enterEmail", fallback: "Введите почту")
  /// Localizable.strings
  ///   NeoCafe Client
  internal static let entry = S.tr("Localizable", "entry", fallback: "Вход")
  /// example@email.com
  internal static let exampleEmail = S.tr("Localizable", "exampleEmail", fallback: "example@email.com")
  /// Получить код
  internal static let getCode = S.tr("Localizable", "getCode", fallback: "Получить код")
  /// Доброе утро!
  internal static let goodMorning = S.tr("Localizable", "goodMorning", fallback: "Доброе утро!")
  /// Главная
  internal static let main = S.tr("Localizable", "main", fallback: "Главная")
  /// Перейти к меню
  internal static let menuButton = S.tr("Localizable", "menuButton", fallback: "Перейти к меню")
  /// Введите 4-х значный код,
  ///  отправленный на почту
  internal static let otpCodeLabel = S.tr("Localizable", "OTPCodeLabel", fallback: "Введите 4-х значный код,\n отправленный на почту")
  /// Наше меню
  internal static let ourMenu = S.tr("Localizable", "ourMenu", fallback: "Наше меню")
  /// Популярное
  internal static let popular = S.tr("Localizable", "popular", fallback: "Популярное")
  /// Профиль
  internal static let profile = S.tr("Localizable", "profile", fallback: "Профиль")
  /// Зарегистрироваться
  internal static let register = S.tr("Localizable", "register", fallback: "Зарегистрироваться")
  /// Регистрация
  internal static let registration = S.tr("Localizable", "registration", fallback: "Регистрация")
  /// Отправить ещё раз через
  internal static let resend = S.tr("Localizable", "resend", fallback: "Отправить ещё раз через")
  /// Поиск
  internal static let search = S.tr("Localizable", "search", fallback: "Поиск")
  /// Код подтверждения
  internal static let verificationCode = S.tr("Localizable", "verificationCode", fallback: "Код подтверждения")
  /// Добро пожаловать в
  internal static let welcome = S.tr("Localizable", "welcome", fallback: "Добро пожаловать в")
  /// Код введён неверно,
  ///  попробуйте еще раз
  internal static let wrongCode = S.tr("Localizable", "wrongCode", fallback: "Код введён неверно,\n попробуйте еще раз")
  /// Неправильный адрес электронной почты, попробуйте ещё раз
  internal static let wrongEmail = S.tr("Localizable", "wrongEmail", fallback: "Неправильный адрес электронной почты, попробуйте ещё раз")
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
