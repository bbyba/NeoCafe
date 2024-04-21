// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif
#if canImport(SwiftUI)
    import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
    static let accentColor = ColorAsset(name: "AccentColor")
    enum Colors {
        static let blue = ColorAsset(name: "blue")
        static let coral = ColorAsset(name: "coral")
        static let darkBlue = ColorAsset(name: "darkBlue")
        static let darkGrey = ColorAsset(name: "darkGrey")
        static let grey = ColorAsset(name: "grey")
        static let ivory = ColorAsset(name: "ivory")
        static let orange = ColorAsset(name: "orange")
        static let white = ColorAsset(name: "white")
        static let yellow = ColorAsset(name: "yellow")
    }

    enum Menu {
        static let bakery = ImageAsset(name: "bakery")
        static let coffee = ImageAsset(name: "coffee")
        static let dessert = ImageAsset(name: "dessert")
        static let drink = ImageAsset(name: "drink")
        static let tea = ImageAsset(name: "tea")
    }

    enum Splash {
        static let coffeeCups = ImageAsset(name: "coffeeCups")
        static let neocafe = ImageAsset(name: "neocafe")
        static let threeBeans = ImageAsset(name: "threeBeans")
        static let twoBeans = ImageAsset(name: "twoBeans")
    }

    enum TabBar {
        static let branches = ImageAsset(name: "branches")
        static let cart = ImageAsset(name: "cart")
        static let main = ImageAsset(name: "main")
        static let profileTab = ImageAsset(name: "profileTab")
    }

    enum TextField {
        static let at = ImageAsset(name: "at")
        static let calendar = ImageAsset(name: "calendar")
        static let profileTextField = ImageAsset(name: "profileTextField")
    }

    static let bonusImage = ImageAsset(name: "bonusImage")
    static let branchesDetail = ImageAsset(name: "branchesDetail")
    static let branchesModal = ImageAsset(name: "branchesModal")
    enum Buttons {
        static let backButton = ImageAsset(name: "backButton")
        static let location = ImageAsset(name: "location")
        static let logoutButton = ImageAsset(name: "logoutButton")
        static let notification = ImageAsset(name: "notification")
        static let orderHistory = ImageAsset(name: "orderHistory")
        static let phoneIcon = ImageAsset(name: "phoneIcon")
    }

    static let coffeeBeanModal = ImageAsset(name: "coffeeBeanModal")
    static let coffeeCupFront = ImageAsset(name: "coffeeCupFront")
    static let coffeeCupTop = ImageAsset(name: "coffeeCupTop")
    static let dropDownIcon = ImageAsset(name: "dropDownIcon")
    static let emptyCartImage = ImageAsset(name: "emptyCartImage")
    static let error404Image = ImageAsset(name: "error404Image")
    static let magnifyingGlass = ImageAsset(name: "magnifyingGlass")
    static let stepperMinus = ImageAsset(name: "stepperMinus")
    static let stepperPlus = ImageAsset(name: "stepperPlus")
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

final class ColorAsset {
    fileprivate(set) var name: String

    #if os(macOS)
        typealias Color = NSColor
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        typealias Color = UIColor
    #endif

    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    private(set) lazy var color: Color = {
        guard let color = Color(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()

    #if os(iOS) || os(tvOS)
        @available(iOS 11.0, tvOS 11.0, *)
        func color(compatibleWith traitCollection: UITraitCollection) -> Color {
            let bundle = BundleToken.bundle
            guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
                fatalError("Unable to load color asset named \(name).")
            }
            return color
        }
    #endif

    #if canImport(SwiftUI)
        @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
        private(set) lazy var swiftUIColor: SwiftUI.Color = .init(asset: self)
    #endif

    fileprivate init(name: String) {
        self.name = name
    }
}

extension ColorAsset.Color {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    convenience init?(asset: ColorAsset) {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            self.init(named: NSColor.Name(asset.name), bundle: bundle)
        #elseif os(watchOS)
            self.init(named: asset.name)
        #endif
    }
}

#if canImport(SwiftUI)
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    extension SwiftUI.Color {
        init(asset: ColorAsset) {
            let bundle = BundleToken.bundle
            self.init(asset.name, bundle: bundle)
        }
    }
#endif

struct ImageAsset {
    fileprivate(set) var name: String

    #if os(macOS)
        typealias Image = NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        typealias Image = UIImage
    #endif

    @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
    var image: Image {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            let image = Image(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            let name = NSImage.Name(self.name)
            let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
            let image = Image(named: name)
        #endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }

    #if os(iOS) || os(tvOS)
        @available(iOS 8.0, tvOS 9.0, *)
        func image(compatibleWith traitCollection: UITraitCollection) -> Image {
            let bundle = BundleToken.bundle
            guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
                fatalError("Unable to load image asset named \(name).")
            }
            return result
        }
    #endif

    #if canImport(SwiftUI)
        @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
        var swiftUIImage: SwiftUI.Image {
            SwiftUI.Image(asset: self)
        }
    #endif
}

extension ImageAsset.Image {
    @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
    @available(macOS, deprecated,
               message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
    convenience init?(asset: ImageAsset) {
        #if os(iOS) || os(tvOS)
            let bundle = BundleToken.bundle
            self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            self.init(named: NSImage.Name(asset.name))
        #elseif os(watchOS)
            self.init(named: asset.name)
        #endif
    }
}

#if canImport(SwiftUI)
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    extension SwiftUI.Image {
        init(asset: ImageAsset) {
            let bundle = BundleToken.bundle
            self.init(asset.name, bundle: bundle)
        }

        init(asset: ImageAsset, label: Text) {
            let bundle = BundleToken.bundle
            self.init(asset.name, bundle: bundle, label: label)
        }

        init(decorative asset: ImageAsset) {
            let bundle = BundleToken.bundle
            self.init(decorative: asset.name, bundle: bundle)
        }
    }
#endif

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
