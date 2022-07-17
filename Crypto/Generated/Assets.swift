// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let corbeau = ColorAsset(name: "Corbeau")
    internal static let greenMana = ColorAsset(name: "GreenMana")
    internal static let heatherGrey = ColorAsset(name: "HeatherGrey")
    internal static let latinCharm = ColorAsset(name: "LatinCharm")
    internal static let red = ColorAsset(name: "Red")
    internal static let strawberryDreams = ColorAsset(name: "StrawberryDreams")
    internal static let watermelonJuice = ColorAsset(name: "WatermelonJuice")
    internal static let white = ColorAsset(name: "White")
  }
  internal enum Images {
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal enum Coins {
      internal static let binance = ImageAsset(name: "Coins/binance")
      internal static let bitcoin = ImageAsset(name: "Coins/bitcoin")
      internal static let cardano = ImageAsset(name: "Coins/cardano")
      internal static let chainLink = ImageAsset(name: "Coins/chain_link")
      internal static let etherium = ImageAsset(name: "Coins/etherium")
      internal static let etherium2 = ImageAsset(name: "Coins/etherium2")
      internal static let tether = ImageAsset(name: "Coins/tether")
    }
    internal enum Common {
      internal static let arrowDrop = ImageAsset(name: "Common/arrowDrop")
      internal static let arrowDropUp24px = ImageAsset(name: "Common/arrow_drop_up_24px")
      internal static let drop = ImageAsset(name: "Common/drop")
      internal static let newsIcon = ImageAsset(name: "Common/newsIcon")
      internal static let up = ImageAsset(name: "Common/up")
    }
    internal enum News {
      internal static let altcoin = ImageAsset(name: "News/altcoin")
      internal static let bitcoin = ImageAsset(name: "News/bitcoin")
    }
    internal enum Onboarding {
      internal static let step1 = ImageAsset(name: "Onboarding/step1")
      internal static let step2 = ImageAsset(name: "Onboarding/step2")
      internal static let step3 = ImageAsset(name: "Onboarding/step3")
    }
    internal enum TabBar {
      internal static let marketSelected = ImageAsset(name: "TabBar/marketSelected")
      internal static let marketUnselected = ImageAsset(name: "TabBar/marketUnselected")
      internal static let profileSelected = ImageAsset(name: "TabBar/profileSelected")
      internal static let profileUnselected = ImageAsset(name: "TabBar/profileUnselected")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
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

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
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
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
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
