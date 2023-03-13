//
//  CardCollectionComponent.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 10/03/23.
//

import UIKit

class CardCollectionComponent: UICollectionView {
    var cellConfiguration: CellConformant? = nil
    
    init(cellConfiguration: CellConformant, layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.cellConfiguration = cellConfiguration
        super.init(frame: .zero, collectionViewLayout: layout)
        self.register(type(of: cellConfiguration), forCellWithReuseIdentifier: cellConfiguration.identifier)

    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        fatalError("init(coder:) has not been implemented")
    }
}


