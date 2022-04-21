//
//  UICollectionViewDiffableDataSource+ViewModel.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import UIKit

extension UICollectionViewDiffableDataSource {
    func applySnaphotUsing(sectionIDs: [SectionIdentifierType], itemsBySection: [SectionIdentifierType: [ItemIdentifierType]],
                           sectionsRetainedIfEmpty: Set<SectionIdentifierType> = Set<SectionIdentifierType>()) {
        applySnaphotUsing(sectionIDs: sectionIDs, itemsBySection: itemsBySection, animatingDifferences: true, sectionsRetainedIfEmpty: sectionsRetainedIfEmpty)
    }
    
    func applySnaphotUsing(sectionIDs: [SectionIdentifierType], itemsBySection: [SectionIdentifierType: [ItemIdentifierType]],
                           animatingDifferences: Bool,
                           sectionsRetainedIfEmpty: Set<SectionIdentifierType> = Set<SectionIdentifierType>()) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>()
        
        for sectionID in sectionIDs {
            guard let sectionItems = itemsBySection[sectionID], sectionItems.count > 0 || sectionsRetainedIfEmpty.contains(sectionID) else { continue }
            
            snapshot.appendSections([sectionID])
            snapshot.appendItems(sectionItems, toSection: sectionID)
            snapshot.reloadItems(sectionItems)
        }
        self.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
