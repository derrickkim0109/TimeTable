//
//  CalendarView.swift
//  TimeTable
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
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalendarCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let event = getCurrentEvent(with: indexPath) as? CalendarEvent
        cell.configure(model: event)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = self.findViewController() as? MainViewController,
           let selectedEvent = getCurrentEvent(with: indexPath) as? CalendarEvent {

            guard let lecture = viewController.viewModel.lectures.filter({ $0.code == selectedEvent.id }).first,
                  let memos = viewController.viewModel.memoDictionary[selectedEvent.id] else {
                return
            }

            viewController.coordinator?.showLectureDetailViewController(
                at: viewController,
                lecture: lecture,
                memos: memos)
        }
    }
}
