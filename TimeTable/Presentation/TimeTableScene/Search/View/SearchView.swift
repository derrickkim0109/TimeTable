//
//  SearchView.swift
//  TimeTable
//
//  Created by Derrick kim on 2023/05/08.
//

import UIKit

final class SearchView: BaseView {
    let searchBarView = SearchBarView()

    lazy var lectureCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, LectureEntity>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, LectureEntity>

    private lazy var dataSource = self.configureDataSource()
    private lazy var snapshot = self.makeSnapshot()

    override func setupDefault() {
        super.setupDefault()
    }

    override func addUIComponents() {
        super.addUIComponents()

        [searchBarView,
         lectureCollectionView].forEach { addSubview($0) }
    }

    override func configureLayouts() {
        super.configureLayouts()

        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            lectureCollectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            lectureCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lectureCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lectureCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(210))

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize)

        let insetAmount: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(
            top: insetAmount,
            leading: insetAmount,
            bottom: insetAmount,
            trailing: insetAmount)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(210))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)

        let section = NSCollectionLayoutSection(
            group: group)

        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10)

        let layout = UICollectionViewCompositionalLayout(
            section: section)

        return layout
    }

    private func configureDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration<LectureCollectionViewCell, LectureEntity> {
            (cell,
             indexPath,
             model) in
            cell.layer.borderColor = UIColor.systemGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10

            cell.configure(model: model)
        }

        return UICollectionViewDiffableDataSource<Section, LectureEntity>(
            collectionView: lectureCollectionView) {
                (collectionView,
                 indexPath,
                 itemIdentifier) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: itemIdentifier)
            }
    }

    private func makeSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        return snapshot
    }

    @MainActor
    func updateDataSource(by data: [LectureEntity], isSearched: Bool) {
        if isSearched == true {
            snapshot = makeSnapshot()
        }
        
        snapshot.appendItems(data)
        dataSource.apply(
            snapshot,
            animatingDifferences: false)
    }

    private enum Const {
        static let zero: CGFloat = 0
        static let two = 2
        static let ten: CGFloat = 10
        static let onePoint: CGFloat = 1.0
        static let onePointFive: CGFloat = 1.5
    }
}
