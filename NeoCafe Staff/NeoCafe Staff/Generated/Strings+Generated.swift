// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum S {
    /// Добавить
    static let add = S.tr("Localizable", "add", fallback: "Добавить")
    /// Все
    static let all = S.tr("Localizable", "all", fallback: "Все")
    /// Занято
    static let busy = S.tr("Localizable", "busy", fallback: "Занято")
    /// Отменено
    static let cancelledStatus = S.tr("Localizable", "cancelledStatus", fallback: "Отменено")
    /// Выберите стол
    static let chooseTheTable = S.tr("Localizable", "chooseTheTable", fallback: "Выберите стол")
    /// Очистить всё
    static let clearAll = S.tr("Localizable", "clearAll", fallback: "Очистить всё")
    /// Закрыть счёт
    static let closeOrder = S.tr("Localizable", "closeOrder", fallback: "Закрыть счёт")
    /// Подтвердить
    static let confirm = S.tr("Localizable", "confirm", fallback: "Подтвердить")
    /// Удалить %@ из заказа?
    static func deleteFromOrder(_ p1: Any) -> String {
        return S.tr("Localizable", "deleteFromOrder", String(describing: p1), fallback: "Удалить %@ из заказа?")
    }

    /// Завершено
    static let doneStatus = S.tr("Localizable", "doneStatus", fallback: "Завершено")
    /// Введите логин
    static let enterLogin = S.tr("Localizable", "enterLogin", fallback: "Введите логин")
    /// Введите пароль
    static let enterPassword = S.tr("Localizable", "enterPassword", fallback: "Введите пароль")
    /// Вход
    static let entry = S.tr("Localizable", "entry", fallback: "Вход")
    /// example@email.com
    static let exampleEmail = S.tr("Localizable", "exampleEmail", fallback: "example@email.com")
    /// Свободно
    static let free = S.tr("Localizable", "free", fallback: "Свободно")
    /// Получить код
    static let getCode = S.tr("Localizable", "getCode", fallback: "Получить код")
    /// Перейти к заказам
    static let goToOrders = S.tr("Localizable", "goToOrders", fallback: "Перейти к заказам")
    /// Меню
    static let menu = S.tr("Localizable", "menu", fallback: "Меню")
    /// Имя
    static let name = S.tr("Localizable", "name", fallback: "Имя")
    /// Новый заказ
    static let newOrder = S.tr("Localizable", "newOrder", fallback: "Новый заказ")
    /// Заказ успешно оформлен
    static let newOrderSuccessfullyMade = S.tr("Localizable", "newOrderSuccessfullyMade", fallback: "Заказ успешно оформлен")
    /// Новый
    static let newStatus = S.tr("Localizable", "newStatus", fallback: "Новый")
    /// Нет
    static let no = S.tr("Localizable", "no", fallback: "Нет")
    /// Уведомления
    static let notifications = S.tr("Localizable", "notifications", fallback: "Уведомления")
    /// №%@
    static func numberSymbol(_ p1: Any) -> String {
        return S.tr("Localizable", "numberSymbol", String(describing: p1), fallback: "№%@")
    }

    /// Заказ №%@
    static func orderNo(_ p1: Any) -> String {
        return S.tr("Localizable", "orderNo", String(describing: p1), fallback: "Заказ №%@")
    }

    /// Заказы
    static let orders = S.tr("Localizable", "orders", fallback: "Заказы")
    /// Заказ успешно закрыт
    static let orderSuccesfullyClosed = S.tr("Localizable", "orderSuccesfullyClosed", fallback: "Заказ успешно закрыт")
    /// Введите 4-х значный код,
    ///  отправленный на почту
    ///  jackie@chan.kg
    static let otpCodeLabel = S.tr("Localizable", "OTPCodeLabel", fallback: "Введите 4-х значный код,\n отправленный на почту \n jackie@chan.kg")
    /// (%@ с за шт)
    static func pricePerItem(_ p1: Any) -> String {
        return S.tr("Localizable", "pricePerItem", String(describing: p1), fallback: "(%@ с за шт)")
    }

    /// В процессе
    static let processingStatus = S.tr("Localizable", "processingStatus", fallback: "В процессе")
    /// Профиль
    static let profile = S.tr("Localizable", "profile", fallback: "Профиль")
    /// Готово
    static let readyStatus = S.tr("Localizable", "readyStatus", fallback: "Готово")
    /// Отправить ещё раз
    static let resend = S.tr("Localizable", "resend", fallback: "Отправить ещё раз")
    /// Отправить ещё раз через
    static let resendAfter = S.tr("Localizable", "resendAfter", fallback: "Отправить ещё раз через")
    /// Сохранить
    static let save = S.tr("Localizable", "save", fallback: "Сохранить")
    /// Поиск
    static let search = S.tr("Localizable", "search", fallback: "Поиск")
    /// %@ с
    static func som(_ p1: Any) -> String {
        return S.tr("Localizable", "som", String(describing: p1), fallback: "%@ с")
    }

    /// Стол №%@
    static func tableNo(_ p1: Any) -> String {
        return S.tr("Localizable", "tableNo", String(describing: p1), fallback: "Стол №%@")
    }

    /// Столы
    static let tables = S.tr("Localizable", "tables", fallback: "Столы")
    /// Заказать
    static let toOrder = S.tr("Localizable", "toOrder", fallback: "Заказать")
    /// Итого:
    static let total = S.tr("Localizable", "total", fallback: "Итого:")
    /// Код подтверждения
    static let verificationCode = S.tr("Localizable", "verificationCode", fallback: "Код подтверждения")
    /// Официант: %@
    static func waiter(_ p1: Any) -> String {
        return S.tr("Localizable", "waiter", String(describing: p1), fallback: "Официант: %@")
    }

    /// Localizable.strings
    ///   NeoCafe Staff
    static let welcome = S.tr("Localizable", "welcome", fallback: "Добро пожаловать в")
    /// График работы
    static let workSchedule = S.tr("Localizable", "workSchedule", fallback: "График работы")
    /// Код введён неверно,
    ///  попробуйте еще раз
    static let wrongCode = S.tr("Localizable", "wrongCode", fallback: "Код введён неверно,\n попробуйте еще раз")
    /// Неправильный логин
    static let wrongLogin = S.tr("Localizable", "wrongLogin", fallback: "Неправильный логин")
    /// Да
    static let yes = S.tr("Localizable", "yes", fallback: "Да")
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
