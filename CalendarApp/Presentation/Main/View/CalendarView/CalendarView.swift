//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Derrick kim on 2023/05/07.
//

import UIKit
import JZCalendarWeekView

final class CalendarView: JZBaseWeekView {
    override func registerViewClasses() {
        super.registerViewClasses()

        collectionView.register(CalendarCollectionViewCell.self)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendarCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let event = getCurrentEvent(with: indexPath) as? CalendarEvent
        cell.configureCell(event: event)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
