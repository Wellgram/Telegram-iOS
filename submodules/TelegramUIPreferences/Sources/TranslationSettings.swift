import Foundation
import Postbox
import TelegramCore
import SwiftSignalKit
//定制-类修改
public struct TranslationSettings: Codable, Equatable {
    public var showTranslate: Bool
    public var ignoredLanguages: [String]?
    //定制-全局属性
    ///自动翻译
    public var showWgAutoTranslate: Bool
    ///手动翻译
    public var showWgHandTranslate: Bool
    ///发送翻译
    public var showWgSendTranslate: Bool
    
    public static var defaultSettings: TranslationSettings {
        return TranslationSettings(showTranslate: false, ignoredLanguages: nil, showWgAutoTranslate: false, showWgHandTranslate: false, showWgSendTranslate: false)
    }
    
    init(showTranslate: Bool, ignoredLanguages: [String]?, showWgAutoTranslate: Bool, showWgHandTranslate: Bool, showWgSendTranslate: Bool) {
        self.showTranslate = showTranslate
        self.ignoredLanguages = ignoredLanguages
        self.showWgAutoTranslate = showWgAutoTranslate
        self.showWgHandTranslate = showWgHandTranslate
        self.showWgSendTranslate = showWgSendTranslate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        self.showTranslate = try container.decodeIfPresent(Bool.self, forKey: "showTranslate") ?? false
        self.ignoredLanguages = try container.decodeIfPresent([String].self, forKey: "ignoredLanguages")
        self.showWgAutoTranslate = try container.decodeIfPresent(Bool.self, forKey: "showWgAutoTranslate") ?? false
        self.showWgHandTranslate = try container.decodeIfPresent(Bool.self, forKey: "showWgHandTranslate") ?? false
        self.showWgSendTranslate = try container.decodeIfPresent(Bool.self, forKey: "showWgSendTranslate") ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(self.showTranslate, forKey: "showTranslate")
        try container.encodeIfPresent(self.ignoredLanguages, forKey: "ignoredLanguages")
        try container.encode(self.showWgAutoTranslate, forKey: "showWgAutoTranslate")
        try container.encode(self.showWgHandTranslate, forKey: "showWgHandTranslate")
        try container.encode(self.showWgSendTranslate, forKey: "showWgSendTranslate")
    }
    
    public static func ==(lhs: TranslationSettings, rhs: TranslationSettings) -> Bool {
        return lhs.showTranslate == rhs.showTranslate && lhs.ignoredLanguages == rhs.ignoredLanguages && lhs.showWgAutoTranslate == rhs.showWgAutoTranslate && lhs.showWgHandTranslate == rhs.showWgHandTranslate && lhs.showWgSendTranslate == rhs.showWgSendTranslate
    }
    
    public func withUpdatedShowTranslate(_ showTranslate: Bool) -> TranslationSettings {
        return TranslationSettings(showTranslate: showTranslate, ignoredLanguages: self.ignoredLanguages, showWgAutoTranslate: self.showWgAutoTranslate, showWgHandTranslate: self.showWgHandTranslate, showWgSendTranslate: self.showWgSendTranslate)
    }
    
    public func withUpdatedIgnoredLanguages(_ ignoredLanguages: [String]?) -> TranslationSettings {
        return TranslationSettings(showTranslate: self.showTranslate, ignoredLanguages: ignoredLanguages, showWgAutoTranslate: showWgAutoTranslate, showWgHandTranslate: showWgHandTranslate, showWgSendTranslate: showWgSendTranslate)
    }
    
    public func withUpdatedShowWgAutoTranslate(_ showWgAutoTranslate: Bool) -> TranslationSettings {
        return TranslationSettings(showTranslate: showTranslate, ignoredLanguages: self.ignoredLanguages, showWgAutoTranslate: showWgAutoTranslate, showWgHandTranslate: self.showWgHandTranslate, showWgSendTranslate: self.showWgSendTranslate)
    }
    
    public func withUpdatedShowWgHandTranslate(_ showWgHandTranslate: Bool) -> TranslationSettings {
        return TranslationSettings(showTranslate: showTranslate, ignoredLanguages: self.ignoredLanguages, showWgAutoTranslate: self.showWgAutoTranslate, showWgHandTranslate: showWgHandTranslate, showWgSendTranslate: self.showWgSendTranslate)
    }
    
    public func withUpdatedShowWgSendTranslate(_ showWgSendTranslate: Bool) -> TranslationSettings {
        return TranslationSettings(showTranslate: showTranslate, ignoredLanguages: self.ignoredLanguages, showWgAutoTranslate: self.showWgAutoTranslate, showWgHandTranslate: showWgHandTranslate, showWgSendTranslate: showWgSendTranslate)
    }
}

public func updateTranslationSettingsInteractively(accountManager: AccountManager<TelegramAccountManagerTypes>, _ f: @escaping (TranslationSettings) -> TranslationSettings) -> Signal<Void, NoError> {
    return accountManager.transaction { transaction -> Void in
        transaction.updateSharedData(ApplicationSpecificSharedDataKeys.translationSettings, { entry in
            let currentSettings: TranslationSettings
            if let entry = entry?.get(TranslationSettings.self) {
                currentSettings = entry
            } else {
                currentSettings = TranslationSettings.defaultSettings
            }
            return PreferencesEntry(f(currentSettings))
        })
    }
}
