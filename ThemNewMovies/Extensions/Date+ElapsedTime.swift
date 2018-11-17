//
//  Date+ElapsedTime.swift
//  ThemNewMovies
//
//  Created by David Freitas on 16/11/18.
//  Copyright © 2018 David Freitas. All rights reserved.
//

import Foundation

extension Date {
    
    // -----
    // Method that returns a localized string representation
    // of time elapsed since/until the date
    // -----
    func getElapsedTime(locale: Locale? = nil) -> String {
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.calendar = calendar
        
        let intervalComponents = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: Date())
        
        if let year = intervalComponents.year, abs(year) > 0 {
            formatter.allowedUnits = [.year]
        } else if let month = intervalComponents.month, abs(month) > 0 {
            formatter.allowedUnits = [.month]
        } else if let week = intervalComponents.weekOfYear, abs(week) > 0 {
            formatter.allowedUnits = [.weekOfMonth]
        } else if let day = intervalComponents.day, abs(day) > 0 {
            formatter.allowedUnits = [.day]
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = calendar.locale
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true
            
            return dateFormatter.string(from: self).lowercased()
        }
        
        // get timeInterval to avoid negative values
        let timeInterval = abs(self.timeIntervalSince(Date()))
        guard let elapsedTime = formatter.string(from: timeInterval) else {
            // this should never fail, but alas, avoiding force unwrap
            return ""
        }
        
        if self > Date() {
            return "\(NSLocalizedString("in", comment: "date is in the future")) \(elapsedTime)"
        } else {
            return "\(elapsedTime) \(NSLocalizedString("ago", comment: "date is in the past"))"
        }
    }
}
