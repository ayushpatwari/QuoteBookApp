//FIX THIS BECAUSE THE NUMBERS FOR THE IF/ELSEs MIGHT BE WRONG

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes == 1 {
        return "\(minutes) minute ago"
    }else if minutes < 59 {
        return "\(minutes) minutes ago"
    } else if hours == 1 {
        return "\(hours) hour ago"
    } else if minutes >= 60 && hours < 24 {
        return "\(hours) hours ago"
    } else if hours >= 24 && hours < 48{
        return "\(days) day ago"
    } else {
        return "\(days) days ago"
    }
}
