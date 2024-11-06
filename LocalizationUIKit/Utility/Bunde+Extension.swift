//
//  Bunde+Extension.swift
//  LocalizationExampleUiKit
//
//  Created by Zeljko Marinkovic on 22/10/2024.
//

import Foundation

var bundleKey: UInt8 = 0

extension Bundle {
    
    static var bundle: Bundle = Bundle.main
    
    static func setLanguage(_ languageCode: String) {
        
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("Failed to find bundle for language: \(languageCode)")

            return
        }
        
        defer {
            object_setClass(Bundle.main, PrivateBundle.self)
        }
        
        self.bundle = bundle
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

class PrivateBundle: Bundle, @unchecked Sendable {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
