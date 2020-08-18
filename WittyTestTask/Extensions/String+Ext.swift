//
//  String+Ext.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import Foundation

extension String {
    
    var isStringOnlyNumbers: Bool {
        guard self.count > 0 else { return false }
        let set: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: set)
    }

    func formatToCardNumber() -> String {
        var number = self
        
        switch number.count {
        case 13:
            var result = String(number.prefix(4)) + CardDetailEntry.NonBreakingSpace
            number.replaceSubrange(number.startIndex..<number.index(number.startIndex, offsetBy: 4), with: "")
            result += String(number.prefix(3)) + CardDetailEntry.NonBreakingSpace
            number.replaceSubrange(number.startIndex..<number.index(number.startIndex, offsetBy: 3), with: "")
            result += String(number.prefix(3)) + CardDetailEntry.NonBreakingSpace
            number.replaceSubrange(number.startIndex..<number.index(number.startIndex, offsetBy: 3), with: "")
            result += number
            return result
        case 15:
            var result = String(number.prefix(4)) + CardDetailEntry.NonBreakingSpace
            number.replaceSubrange(number.startIndex..<number.index(number.startIndex, offsetBy: 4), with: "")
            result += String(number.prefix(6)) + CardDetailEntry.NonBreakingSpace
            number.replaceSubrange(number.startIndex..<number.index(number.startIndex, offsetBy: 6), with: "")
            result += number
            return result
        case 18:
            var result = String(number.prefix(8)) + CardDetailEntry.NonBreakingSpace
            number.replaceSubrange(number.startIndex..<number.index(number.startIndex, offsetBy: 8), with: "")
            result += number
            return result
        default:
            let formatter = NumberFormatter()
            formatter.numberStyle = .none
            formatter.groupingSize = 4
            formatter.minimumIntegerDigits = number.count
            formatter.groupingSeparator = CardDetailEntry.NonBreakingSpace
            formatter.usesGroupingSeparator = true
            if let reversedNumber = NumberFormatter().number(from: String(number.reversed())) {
                return String((formatter.string(from:reversedNumber)?.reversed())!)
            }
            return self
        }
    }
    
}
