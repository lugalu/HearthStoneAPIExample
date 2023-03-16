//
//  CardCellProtocols.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 12/03/23.
//

import UIKit

protocol CellConformant: UICollectionViewCell{
    var identifier: String { get }
    func configure(with: CardCellData)
}

protocol CardCellData{
    var cardImage: UIImage {get}
    var cardTitle: String {get}
}

