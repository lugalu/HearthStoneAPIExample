//
//  CardCollectionComponent.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 10/03/23.
//

import UIKit

class CardCollectionComponent: UICollectionViewController {
    var cellConfiguration: CellConformant? = nil
    
    init(cellConfiguration: CellConformant) {
        self.cellConfiguration = cellConfiguration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let cellConfiguration else { return }
        collectionView.register(type(of: cellConfiguration), forCellWithReuseIdentifier: cellConfiguration.identifier)
    }
}

protocol CellConformant: UICollectionViewCell{
    var identifier: String { get }
    func configure(with: CardCellData)
}

protocol CardCellData{
    var cardImage:UIImage {get}
    var cardTitle: String {get}
}
