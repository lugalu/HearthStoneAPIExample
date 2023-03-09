//
//  TabBar.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 09/03/23.
//

import UIKit

class TabBar: UITabBarController {

    init( _ viewControllers: (TabBarConformant)...){
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = []
        for view in viewControllers {
            self.viewControllers?.append( createNavController(for: view, title: view.titleKey, image: view.image))
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let noteListingPrivate = NoteListingRouter.createView(withAccessLevel: .privateDB)
        //let noteListingPublic = NoteListingRouter.createView(withAccessLevel: .publicDB)
        
        self.viewControllers = [
            // createNavController(for: noteListingPrivate, title: "Private", image: UIImage(systemName: "lock")),
           // createNavController(for: noteListingPublic, title: "Public", image: UIImage(systemName: "lock.open"))
                               
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: String) -> UIViewController {
        
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = UIImage(named: image) ?? UIImage(systemName: image)
        
          return navController
      }
}

protocol TabBarConformant: UIViewController{
    var titleKey: String {get set}
    var image: String {get set}
}
