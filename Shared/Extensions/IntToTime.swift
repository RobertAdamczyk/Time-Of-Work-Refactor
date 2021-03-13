//
//  DoubleToTime.swift
//  Time Of Work (iOS)
//
//  Created by Robert Adamczyk on 10.03.21.
//

extension Int {
    func toTimeString() -> String{
        var positive = abs(self)
        if positive % 3600 % 60 > 0 { // if sec rest add one min more
            positive += 60
        }
        let m = positive % 3600 / 60
        let h = positive / 3600
        
        
        let hour = "\(h)h "
        let mins = "\(m)m"
        return self < 0 ? "-" + hour + mins : hour + mins
    }
}
