//
//  TabBar.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 09/03/23.
//

import UIKit

class TabBar: UITabBarController {

    init( _ viewControllers: TabBarConformant...){
        super.init(nibName: nil, bundle: nil)
        
        var viewControllersArr: [UIViewController] = []
        for view in viewControllers {
            let newVC = createNavController(for: view, title: view.titleKey, image: view.image)
            viewControllersArr.append(newVC)
        }
        
        self.viewControllers = viewControllersArr
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
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


