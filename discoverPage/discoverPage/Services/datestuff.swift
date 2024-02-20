//
//  datestuff.swift
//  discoverPage
//
//  Created by Vishal Varma on 9/3/23.
//

import Foundation



func dateOf(with date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateFormatter.string(from: date)
}

let calendar = Calendar.current
func findDayBefore(date: Date) -> Date{
    let yesterday = calendar.date(byAdding: .day, value: -1, to: date)!
    return yesterday

}
