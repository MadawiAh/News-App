//
//  String+Extentions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 22/02/1444 AH.
//

import Foundation

extension String {
    
    func getFormattedDate(currentFormat: String) -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        
        guard let date = formatter.date(from: self) else {
            return nil
        }
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMM d, yyyy"
    
        return formatter.string(from: date)
    }
    
    func getSlice(from: String, to: String) -> String? {
            return (range(of: from)?.upperBound).flatMap { substringFrom in
                (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                    String(self[substringFrom..<substringTo])
                }
            }
        }
    
    func emptyAsNil() -> String? {
            self.isEmpty ? nil : self
        }
}
