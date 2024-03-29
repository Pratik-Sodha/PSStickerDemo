//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 6 files.
  struct file {
    /// Resource file `AmaticSC-Regular.ttf`.
    static let amaticSCRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "AmaticSC-Regular", pathExtension: "ttf")
    /// Resource file `DancingScript-VariableFont_wght.ttf`.
    static let dancingScriptVariableFont_wghtTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "DancingScript-VariableFont_wght", pathExtension: "ttf")
    /// Resource file `Lobster-Regular.ttf`.
    static let lobsterRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Lobster-Regular", pathExtension: "ttf")
    /// Resource file `Monoton-Regular.ttf`.
    static let monotonRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Monoton-Regular", pathExtension: "ttf")
    /// Resource file `Pacifico-Regular.ttf`.
    static let pacificoRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Pacifico-Regular", pathExtension: "ttf")
    /// Resource file `RockSalt-Regular.ttf`.
    static let rockSaltRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "RockSalt-Regular", pathExtension: "ttf")

    /// `bundle.url(forResource: "AmaticSC-Regular", withExtension: "ttf")`
    static func amaticSCRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.amaticSCRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "DancingScript-VariableFont_wght", withExtension: "ttf")`
    static func dancingScriptVariableFont_wghtTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.dancingScriptVariableFont_wghtTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Lobster-Regular", withExtension: "ttf")`
    static func lobsterRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.lobsterRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Monoton-Regular", withExtension: "ttf")`
    static func monotonRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.monotonRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Pacifico-Regular", withExtension: "ttf")`
    static func pacificoRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.pacificoRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "RockSalt-Regular", withExtension: "ttf")`
    static func rockSaltRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.rockSaltRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 6 fonts.
  struct font: Rswift.Validatable {
    /// Font `AmaticSC-Regular`.
    static let amaticSCRegular = Rswift.FontResource(fontName: "AmaticSC-Regular")
    /// Font `DancingScript-Regular`.
    static let dancingScriptRegular = Rswift.FontResource(fontName: "DancingScript-Regular")
    /// Font `Lobster-Regular`.
    static let lobsterRegular = Rswift.FontResource(fontName: "Lobster-Regular")
    /// Font `Monoton-Regular`.
    static let monotonRegular = Rswift.FontResource(fontName: "Monoton-Regular")
    /// Font `Pacifico-Regular`.
    static let pacificoRegular = Rswift.FontResource(fontName: "Pacifico-Regular")
    /// Font `RockSalt-Regular`.
    static let rockSaltRegular = Rswift.FontResource(fontName: "RockSalt-Regular")

    /// `UIFont(name: "AmaticSC-Regular", size: ...)`
    static func amaticSCRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: amaticSCRegular, size: size)
    }

    /// `UIFont(name: "DancingScript-Regular", size: ...)`
    static func dancingScriptRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: dancingScriptRegular, size: size)
    }

    /// `UIFont(name: "Lobster-Regular", size: ...)`
    static func lobsterRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: lobsterRegular, size: size)
    }

    /// `UIFont(name: "Monoton-Regular", size: ...)`
    static func monotonRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: monotonRegular, size: size)
    }

    /// `UIFont(name: "Pacifico-Regular", size: ...)`
    static func pacificoRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: pacificoRegular, size: size)
    }

    /// `UIFont(name: "RockSalt-Regular", size: ...)`
    static func rockSaltRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: rockSaltRegular, size: size)
    }

    static func validate() throws {
      if R.font.amaticSCRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'AmaticSC-Regular' could not be loaded, is 'AmaticSC-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.dancingScriptRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'DancingScript-Regular' could not be loaded, is 'DancingScript-VariableFont_wght.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.lobsterRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Lobster-Regular' could not be loaded, is 'Lobster-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.monotonRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Monoton-Regular' could not be loaded, is 'Monoton-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.pacificoRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Pacifico-Regular' could not be loaded, is 'Pacifico-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.rockSaltRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'RockSalt-Regular' could not be loaded, is 'RockSalt-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 31 images.
  struct image {
    /// Image `Animal1`.
    static let animal1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Animal1")
    /// Image `centerAlignment`.
    static let centerAlignment = Rswift.ImageResource(bundle: R.hostingBundle, name: "centerAlignment")
    /// Image `iconAlignment`.
    static let iconAlignment = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconAlignment")
    /// Image `iconCharacterSpacing`.
    static let iconCharacterSpacing = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconCharacterSpacing")
    /// Image `iconColor`.
    static let iconColor = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconColor")
    /// Image `iconCross`.
    static let iconCross = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconCross")
    /// Image `iconEdit`.
    static let iconEdit = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconEdit")
    /// Image `iconFontSelection`.
    static let iconFontSelection = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconFontSelection")
    /// Image `iconFontSize`.
    static let iconFontSize = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconFontSize")
    /// Image `iconFont`.
    static let iconFont = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconFont")
    /// Image `iconOpacity`.
    static let iconOpacity = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconOpacity")
    /// Image `iconTextColorSelection`.
    static let iconTextColorSelection = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconTextColorSelection")
    /// Image `iconTextColor`.
    static let iconTextColor = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconTextColor")
    /// Image `iconTextOutlineSelection`.
    static let iconTextOutlineSelection = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconTextOutlineSelection")
    /// Image `iconTextOutline`.
    static let iconTextOutline = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconTextOutline")
    /// Image `iconTextShadowSelection`.
    static let iconTextShadowSelection = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconTextShadowSelection")
    /// Image `iconTextShadow`.
    static let iconTextShadow = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconTextShadow")
    /// Image `leftAlignment`.
    static let leftAlignment = Rswift.ImageResource(bundle: R.hostingBundle, name: "leftAlignment")
    /// Image `rightAlignment`.
    static let rightAlignment = Rswift.ImageResource(bundle: R.hostingBundle, name: "rightAlignment")
    /// Image `texture10`.
    static let texture10 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture10")
    /// Image `texture11`.
    static let texture11 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture11")
    /// Image `texture12`.
    static let texture12 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture12")
    /// Image `texture1`.
    static let texture1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture1")
    /// Image `texture2`.
    static let texture2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture2")
    /// Image `texture3`.
    static let texture3 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture3")
    /// Image `texture4`.
    static let texture4 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture4")
    /// Image `texture5`.
    static let texture5 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture5")
    /// Image `texture6`.
    static let texture6 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture6")
    /// Image `texture7`.
    static let texture7 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture7")
    /// Image `texture8`.
    static let texture8 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture8")
    /// Image `texture9`.
    static let texture9 = Rswift.ImageResource(bundle: R.hostingBundle, name: "texture9")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Animal1", bundle: ..., traitCollection: ...)`
    static func animal1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.animal1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "centerAlignment", bundle: ..., traitCollection: ...)`
    static func centerAlignment(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.centerAlignment, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconAlignment", bundle: ..., traitCollection: ...)`
    static func iconAlignment(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconAlignment, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconCharacterSpacing", bundle: ..., traitCollection: ...)`
    static func iconCharacterSpacing(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconCharacterSpacing, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconColor", bundle: ..., traitCollection: ...)`
    static func iconColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconCross", bundle: ..., traitCollection: ...)`
    static func iconCross(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconCross, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconEdit", bundle: ..., traitCollection: ...)`
    static func iconEdit(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconEdit, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconFont", bundle: ..., traitCollection: ...)`
    static func iconFont(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconFont, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconFontSelection", bundle: ..., traitCollection: ...)`
    static func iconFontSelection(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconFontSelection, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconFontSize", bundle: ..., traitCollection: ...)`
    static func iconFontSize(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconFontSize, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconOpacity", bundle: ..., traitCollection: ...)`
    static func iconOpacity(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconOpacity, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconTextColor", bundle: ..., traitCollection: ...)`
    static func iconTextColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconTextColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconTextColorSelection", bundle: ..., traitCollection: ...)`
    static func iconTextColorSelection(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconTextColorSelection, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconTextOutline", bundle: ..., traitCollection: ...)`
    static func iconTextOutline(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconTextOutline, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconTextOutlineSelection", bundle: ..., traitCollection: ...)`
    static func iconTextOutlineSelection(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconTextOutlineSelection, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconTextShadow", bundle: ..., traitCollection: ...)`
    static func iconTextShadow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconTextShadow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "iconTextShadowSelection", bundle: ..., traitCollection: ...)`
    static func iconTextShadowSelection(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconTextShadowSelection, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "leftAlignment", bundle: ..., traitCollection: ...)`
    static func leftAlignment(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.leftAlignment, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "rightAlignment", bundle: ..., traitCollection: ...)`
    static func rightAlignment(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.rightAlignment, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture1", bundle: ..., traitCollection: ...)`
    static func texture1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture10", bundle: ..., traitCollection: ...)`
    static func texture10(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture10, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture11", bundle: ..., traitCollection: ...)`
    static func texture11(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture11, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture12", bundle: ..., traitCollection: ...)`
    static func texture12(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture12, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture2", bundle: ..., traitCollection: ...)`
    static func texture2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture3", bundle: ..., traitCollection: ...)`
    static func texture3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture4", bundle: ..., traitCollection: ...)`
    static func texture4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture4, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture5", bundle: ..., traitCollection: ...)`
    static func texture5(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture5, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture6", bundle: ..., traitCollection: ...)`
    static func texture6(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture6, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture7", bundle: ..., traitCollection: ...)`
    static func texture7(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture7, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture8", bundle: ..., traitCollection: ...)`
    static func texture8(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture8, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "texture9", bundle: ..., traitCollection: ...)`
    static func texture9(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.texture9, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
