//
//  CardBackView.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 10/03/23.
//

import UIKit

class CardBackView: UIViewController, TabBarConformant {
    var titleKey: String = "Card Back"
    var image: String = "doc.fill"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let test = UILabel()
        test.text = "Hey ho"
        
        view.addSubview(test)
        
        test.translatesAutoresizingMaskIntoConstraints = false
        
        let const = [
            test.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            test.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(const)
        
        //self.tabBarItem.title = titleKey
        
        // Do any additional setup after loading the view.
    }
}
