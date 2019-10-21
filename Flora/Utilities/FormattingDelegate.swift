//
//  FormattingDelegate.swift
//  Flora
//
//  Created by Mark on 19/02/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import Foundation
import WikipediaKit

class FormattingDelegate: WikipediaTextFormattingDelegate {
    
    static let shared = FormattingDelegate()
    
    func format(context: WikipediaTextFormattingDelegateContext, rawText: String, title: String?, language: WikipediaLanguage, isHTML: Bool) -> String {
        
        let formattedText = rawText
        
        //let formattedText = rawText.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression)
        
        return formattedText
    }
    
}
