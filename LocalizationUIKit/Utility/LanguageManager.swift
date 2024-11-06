//
//  LanguageManager.swift
//  LocalizationExampleUiKit
//
//  Created by Zeljko Marinkovic on 22/10/2024.
//

import Foundation

protocol LanguageManagerServiceListener: AnyObject {
    func localize(_ languageManager: LanguageManager)
}

@MainActor
class LanguageManager {
    
    weak var listener: LanguageManagerServiceListener?
    
    var currentLanguage: String = "en" {
        didSet {
            Bundle.setLanguage(currentLanguage)
            
            listener?.localize(self)
        }
    }
}
