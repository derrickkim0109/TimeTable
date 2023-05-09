//
//  UserDefault+Extensions.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/09.
//

import UIKit

extension UserDefaults {
    func set(_ color: UIColor?, forKey key: String) {
        guard let color = color else {
            return
        }

        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        set(colorData, forKey: key)
    }

    func color(forKey key: String) -> UIColor? {
        guard let colorData = data(forKey: key) else {
            return nil
        }

        if let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
            return color
        }

        return nil
    }
}


