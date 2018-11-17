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
    // of time elapsed since self, if in the past, or
    // until self, if in the future
    // -----
    func getElapsedTime() -> String {
        // get formatter calendar
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.calendar = calendar
        
        // get time interval components
        let today = Date()
        let intervalComponents = calendar.dateComponents(
            [.year, .month, .weekOfYear, .day],
            from: self,
            to: today)
        
        if let year = intervalComponents.year, abs(year) > 0 {
            // date is at least 1 year away
            formatter.allowedUnits = [.year]
        } else if let month = intervalComponents.month, abs(month) > 0 {
            // date is at least 1 month away
            formatter.allowedUnits = [.month]
        } else if let week = intervalComponents.weekOfYear, abs(week) > 0 {
            // date is at least 1 week away
            formatter.allowedUnits = [.weekOfMonth]
        } else if let day = intervalComponents.day, abs(day) > 0 {
            // date is at least 1 day away
            formatter.allowedUnits = [.day]
        } else {
            // date is today
            return "today".localized
        }
        
        // get absolute timeInterval to avoid negative values
        let timeInterval = abs(self.timeIntervalSince(today))
        guard let elapsedTime = formatter.string(from: timeInterval) else {
            // this should never fail, but alas, avoiding force unwrap
            return ""
        }
        
        if self > Date() {
            return "\("in".localized) \(elapsedTime)"
        } else {
            return "\(elapsedTime) \("ago".localized)"
        }
    }
}
