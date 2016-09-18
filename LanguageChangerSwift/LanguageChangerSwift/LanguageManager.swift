//
//  LanguageManager.swift
//  LanguageChangerSwift
//
//  Created by Harish-Uz-Jaman Mridha Raju on 9/17/16.
//  Copyright © 2016 Raju. All rights reserved.
//

import UIKit

func Localised(key:String) -> String {
    
    let languageCode =  NSUserDefaults.standardUserDefaults().stringForKey(Constant.DEFAULTS_KEY_LANGUAGE_CODE)
    let bundlePath = NSBundle.mainBundle().pathForResource(languageCode as String?, ofType: "lproj")
    let Languagebundle = NSBundle(path: bundlePath!)
    
    return (Languagebundle?.localizedStringForKey(key, value: key, table: nil))!
}

class LanguageManager: NSObject {
    
    var availableLocales = [Local]()
    
    
    class func sharedLanguageManager() -> LanguageManager {
        // Create a singleton.
        var once: dispatch_once_t = 0
        var languageManager: LanguageManager?
        
        dispatch_once(&once) { () -> Void in
            languageManager = LanguageManager()
        }
        return languageManager!
    }
    
    override init() {
        super.init()
        
        // Manually create a list of available localisations for this example project.
        let english = Local(languageCode: "en", countryCode: "gb", name: "United Kingdom")
        let french = Local(languageCode: "fr", countryCode: "fr", name: "France")
        let german = Local(languageCode: "de", countryCode: "de", name: "Deutschland")
        let italian = Local(languageCode: "it", countryCode: "it", name: "Italia")
        let japanese = Local(languageCode: "ja", countryCode: "jp", name: "日本")
        let bengali = Local(languageCode: "bn", countryCode: "bn", name: "বাংলা")
        self.availableLocales = [english, french, german, italian, japanese, bengali]
        
    }
    
    func setLanguageWithLocale(locale: Local) {
        NSUserDefaults.standardUserDefaults().setObject(locale.languageCode, forKey: Constant.DEFAULTS_KEY_LANGUAGE_CODE)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getSelectedLocale() -> Local {
        var selectedLocale: Local? = nil
        // Get the language code.
        
        if let languageCode = NSUserDefaults.standardUserDefaults().stringForKey(Constant.DEFAULTS_KEY_LANGUAGE_CODE)?.lowercaseString {
            // Iterate through available localisations to find the one that matches languageCode.
            for locale: Local in self.availableLocales {
                if locale.languageCode!.caseInsensitiveCompare(languageCode) == .OrderedSame {
                    selectedLocale = locale
                }
            }
        }
        
        return selectedLocale! ?? Local(languageCode: "en", countryCode: "gb", name: "United Kingdom")
    }
    
    func getTranslationForKey(key: String) -> String {
        // Get the language code.
        let languageCode = NSUserDefaults.standardUserDefaults().stringForKey(Constant.DEFAULTS_KEY_LANGUAGE_CODE)!.lowercaseString
        // Get the relevant language bundle.
        let bundlePath = NSBundle.mainBundle().pathForResource(languageCode, ofType: "lproj")!
        let languageBundle = NSBundle(path: bundlePath)
        // Get the translated string using the language bundle.
        var translatedString = languageBundle!.localizedStringForKey(key, value: "", table: nil)
        if translatedString.characters.count < 1 {
            // There is no localizable strings file for the selected language.
            translatedString = NSLocalizedString(key, tableName: nil, bundle: NSBundle.mainBundle(), value: key, comment: key)
        }
        return translatedString
    }

}
