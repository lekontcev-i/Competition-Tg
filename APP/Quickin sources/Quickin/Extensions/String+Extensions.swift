//
//  String+Extensions.swift
//  Quickin
//
//  Created by Vitaliy Pedan on 30.08.2021.
//

import Foundation

extension String {
    
    var spacingless: String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var toInt: Int {
        return Int(self) ?? 0
    }

    static var empty: String {
        return ""
    }
    
    static var whitespace: String {
        return " "
    }


    func withMask(mask: String) -> String {
        var resultString = String()

        let chars = self
        let maskChars = mask

        var stringIndex = chars.startIndex
        var maskIndex = mask.startIndex

        while stringIndex < chars.endIndex && maskIndex < maskChars.endIndex {
            if (maskChars[maskIndex] == "#") {
                resultString.append(chars[stringIndex])
                stringIndex = chars.index(after: stringIndex)
            } else {
                resultString.append(maskChars[maskIndex])
            }
            maskIndex = maskChars.index(after: maskIndex)
        }

        return resultString
    }
    
    var nameShort: String {
        let components = self.components(separatedBy: " ")
        guard components.count > 1 else { return self }
        return [components[0], components[1].prefix(1) + "."].joined(separator: " ")
    }
    
    func chunked(into size: Int) -> [String] {
        return stride(from: 0, to: count, by: size).map {
            String((self.suffix(from: self.index(self.startIndex, offsetBy: $0))).prefix(size))
        }
    }
    
    var doubleValue: Double? {
        var value: Double = 0.0
        let scanner = Scanner(string: self.replacingOccurrences(of: ",", with: "."))
        if scanner.scanDouble(&value) {
            return value
        }
        return nil
    }

    var checkIsEmpty: String? {
        return self.isEmpty ? nil : self
    }
    
    func wrapped(with wrapString: String) -> Self {
        return wrapString + self + wrapString
    }

    func condensingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: "")
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    static func isValid(_ string: Self?) -> Bool {
        if let string = string {
            return !string.isEmpty
        } else {
            return false
        }
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func removeNonLetters() {
        removeAll {
            guard let unicodeScalar = $0.unicodeScalars.first else { return false }
            return !CharacterSet.letters.contains(unicodeScalar)
        }
    }
    var letters: Self {
        var letters = self
        letters.removeNonLetters()
        return letters
    }
}

extension String {
    func matching(pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let range = NSRange(location: 0, length: self.utf16.count)
        let result = regex.firstMatch(in: self, options: [], range: range)
        
        return result != nil
    }
}
