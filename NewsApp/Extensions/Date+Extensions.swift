//
//  Date+Extensions.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/02/1444 AH.
//

import Foundation

extension Date {
    func getComponent(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func getComponent(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
