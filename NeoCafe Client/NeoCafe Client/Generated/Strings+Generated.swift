// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum S {
    /// Добавить ещё
    static let addMore = S.tr("Localizable", "addMore", fallback: "Добавить ещё")
    /// Бонусы к списанию:
    static let availablePoints = S.tr("Localizable", "availablePoints", fallback: "Бонусы к списанию:")
    /// У вас есть %@ бонусов, хотите
    ///  использовать их?
    static func availablePointsWant(_ p1: Any) -> String {
        S.tr("Localizable", "availablePointsWant", String(describing: p1), fallback: "У вас есть %@ бонусов, хотите \n использовать их?")
    }

    /// Бонусы
    static let bonuses = S.tr("Localizable", "bonuses", fallback: "Бонусы")
    /// Накапливайте бонусы и совершайте
    ///  выгодные для Вас заказы!
    ///  1 бонус = 1 сом
    static let bonusMessageProfile = S.tr("Localizable", "bonusMessageProfile", fallback: "Накапливайте бонусы и совершайте \n выгодные для Вас заказы! \n 1 бонус = 1 сом")
    /// Использованные бонусы:
    static let bonusPointsUsed = S.tr("Localizable", "bonusPointsUsed", fallback: "Использованные бонусы: ")
    /// Филиалы
    static let branches = S.tr("Localizable", "branches", fallback: "Филиалы")
    /// Отмена
    static let cancel = S.tr("Localizable", "cancel", fallback: "Отмена")
    /// Корзина
    static let cart = S.tr("Localizable", "cart", fallback: "Корзина")
    /// Категории
    static let categories = S.tr("Localizable", "categories", fallback: "Категории")
    /// Выберите филиал
    static let chooseBranch = S.tr("Localizable", "chooseBranch", fallback: "Выберите филиал")
    /// Очистить всё
    static let clearAll = S.tr("Localizable", "clearAll", fallback: "Очистить всё")
    /// Закрыть счёт
    static let closeOrder = S.tr("Localizable", "closeOrder", fallback: "Закрыть счёт")
    /// Подтвердить
    static let confirm = S.tr("Localizable", "confirm", fallback: "Подтвердить")
    /// Актуальный заказ
    static let currentOrder = S.tr("Localizable", "currentOrder", fallback: "Актуальный заказ")
    /// Удалить %@ из заказа?
    static func deleteFromOrder(_ p1: Any) -> String {
        S.tr("Localizable", "deleteFromOrder", String(describing: p1), fallback: "Удалить %@ из заказа?")
    }

    /// В заведении
    static let eatHere = S.tr("Localizable", "eatHere", fallback: "В заведении")
    /// Редактирование
    static let editing = S.tr("Localizable", "editing", fallback: "Редактирование")
    /// Ваша корзина пуста
    static let emptyCart = S.tr("Localizable", "emptyCart", fallback: "Ваша корзина пуста")
    /// Войти
    static let enter = S.tr("Localizable", "enter", fallback: "Войти")
    /// Введите количество бонусов,
    ///  которое хотите списать
    static let enterBonusPoints = S.tr("Localizable", "enterBonusPoints", fallback: "Введите количество бонусов,\n которое хотите списать")
    /// Введите почту
    static let enterEmail = S.tr("Localizable", "enterEmail", fallback: "Введите почту")
    /// Введите своё имя
    static let enterYourName = S.tr("Localizable", "enterYourName", fallback: "Введите своё имя")
    /// Вход
    static let entry = S.tr("Localizable", "entry", fallback: "Вход")
    /// example@email.com
    static let exampleEmail = S.tr("Localizable", "exampleEmail", fallback: "example@email.com")
    /// Завершенные
    static let finished = S.tr("Localizable", "finished", fallback: "Завершенные")
    /// Получить код
    static let getCode = S.tr("Localizable", "getCode", fallback: "Получить код")
    /// Доброе утро!
    static let goodMorning = S.tr("Localizable", "goodMorning", fallback: "Доброе утро!")
    /// Выход
    static let logout = S.tr("Localizable", "logout", fallback: "Выход")
    /// Вы действительно хотите выйти?
    static let logoutConfirmation = S.tr("Localizable", "logoutConfirmation", fallback: "Вы действительно хотите выйти?")
    /// Главная
    static let main = S.tr("Localizable", "main", fallback: "Главная")
    /// Меню:
    static let menu2 = S.tr("Localizable", "menu2", fallback: "Меню: ")
    /// Перейти к меню
    static let menuButton = S.tr("Localizable", "menuButton", fallback: "Перейти к меню")
    /// Нет
    static let no = S.tr("Localizable", "no", fallback: "Нет")
    /// Уведомления
    static let notifications = S.tr("Localizable", "notifications", fallback: "Уведомления")
    /// Упс, что-то пошло не так
    static let oopsSomethingsWrong = S.tr("Localizable", "oopsSomethingsWrong", fallback: "Упс, что-то пошло не так")
    /// Открытый заказ
    static let openOrder = S.tr("Localizable", "openOrder", fallback: "Открытый заказ")
    /// Заказать
    static let order = S.tr("Localizable", "order", fallback: "Заказать")
    /// Ваш заказ принят, пожалуйста ожидайте
    static let orderAcceptedWait = S.tr("Localizable", "orderAcceptedWait", fallback: "Ваш заказ принят, пожалуйста ожидайте")
    /// Заказ #%@
    static func orderHash(_ p1: Any) -> String {
        S.tr("Localizable", "orderHash", String(describing: p1), fallback: "Заказ #%@")
    }

    /// История заказов
    static let orderHistory = S.tr("Localizable", "orderHistory", fallback: "История заказов")
    /// Введите 4-х значный код,
    ///  отправленный на почту
    ///  burte.bsn@gmail.com
    static let otpCodeLabel = S.tr("Localizable", "OTPCodeLabel", fallback: "Введите 4-х значный код,\n отправленный на почту \n burte.bsn@gmail.com")
    /// Наше меню
    static let ourMenu = S.tr("Localizable", "ourMenu", fallback: "Наше меню")
    /// Отлично!
    static let perfect = S.tr("Localizable", "perfect", fallback: "Отлично!")
    /// Приятное дополнение
    static let pleasantAddition = S.tr("Localizable", "pleasantAddition", fallback: "Приятное дополнение")
    /// Популярное
    static let popular = S.tr("Localizable", "popular", fallback: "Популярное")
    /// Популярные блюда
    static let popularMenu = S.tr("Localizable", "popularMenu", fallback: "Популярные блюда")
    /// Профиль
    static let profile = S.tr("Localizable", "profile", fallback: "Профиль")
    /// Зарегистрироваться
    static let register = S.tr("Localizable", "register", fallback: "Зарегистрироваться")
    /// Регистрация
    static let registration = S.tr("Localizable", "registration", fallback: "Регистрация")
    /// Повторить
    static let reload = S.tr("Localizable", "reload", fallback: "Повторить")
    /// Отправить ещё раз
    static let resend = S.tr("Localizable", "resend", fallback: "Отправить ещё раз")
    /// Отправить ещё раз через
    static let resendAfter = S.tr("Localizable", "resendAfter", fallback: "Отправить ещё раз через")
    /// Сохранить
    static let save = S.tr("Localizable", "save", fallback: "Сохранить")
    /// График работы:
    static let schedule = S.tr("Localizable", "schedule", fallback: "График работы: ")
    /// График не доступен
    static let scheduleNotAvailanle = S.tr("Localizable", "scheduleNotAvailanle", fallback: "График не доступен")
    /// Поиск
    static let search = S.tr("Localizable", "search", fallback: "Поиск")
    /// %@ с
    static func som(_ p1: Any) -> String {
        S.tr("Localizable", "som", String(describing: p1), fallback: "%@ с")
    }

    /// Сегодня с
    static let todaySchedule = S.tr("Localizable", "todaySchedule", fallback: "Сегодня с ")
    /// Возьму с собой
    static let toGo = S.tr("Localizable", "toGo", fallback: "Возьму с собой")
    /// С собой
    static let toGoShort = S.tr("Localizable", "toGoShort", fallback: "С собой")
    /// В меню
    static let toMenu = S.tr("Localizable", "toMenu", fallback: "В меню")
    /// Итого:
    static let total = S.tr("Localizable", "total", fallback: "Итого: ")
    /// В корзину
    static let toTheBasket = S.tr("Localizable", "toTheBasket", fallback: "В корзину")
    /// Списать
    static let use = S.tr("Localizable", "use", fallback: "Списать")
    /// Списание бонусов
    static let useBonusPoints = S.tr("Localizable", "useBonusPoints", fallback: "Списание бонусов")
    /// Код подтверждения
    static let verificationCode = S.tr("Localizable", "verificationCode", fallback: "Код подтверждения")
    /// Пн: 11:00 - 22:00
    static let weekSchedule = S.tr("Localizable", "weekSchedule", fallback: "Пн: 11:00 - 22:00")
    /// Localizable.strings
    ///   NeoCafe Client
    static let welcome = S.tr("Localizable", "welcome", fallback: "Добро пожаловать в")
    /// Код введён неверно,
    ///  попробуйте еще раз
    static let wrongCode = S.tr("Localizable", "wrongCode", fallback: "Код введён неверно,\n попробуйте еще раз")
    /// Неправильный адрес электронной почты, попробуйте ещё раз
    static let wrongEmail = S.tr("Localizable", "wrongEmail", fallback: "Неправильный адрес электронной почты, попробуйте ещё раз")
    /// Да
    static let yes = S.tr("Localizable", "yes", fallback: "Да")
    /// Ваши бонусы: %@
    static func yourBonusPoints(_ p1: Any) -> String {
        S.tr("Localizable", "yourBonusPoints", String(describing: p1), fallback: "Ваши бонусы: %@")
    }
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
