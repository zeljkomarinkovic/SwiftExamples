//
//  String+Extension.swift
//  LocalizationExampleUiKit
//
//  Created by Zeljko Marinkovic on 22/10/2024.
//

import Foundation

extension String {
    
    init(localized: String.LocalizationValue) {
        self = String(localized: localized, bundle: .bundle)
    }
}
