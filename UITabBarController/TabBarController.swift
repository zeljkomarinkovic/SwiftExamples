//
//  TabBarController.swift
//  UITabBarController
//
//  Created by Zeljko Marinkovic on 07/11/2024.
//

import UIKit

//class TabBarController: UITabBarController {
//    
//    deinit {
//        print("OS reclaiming memory for TabBarController")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.delegate = self
//        
//        self.tabBar.backgroundColor = .systemGray
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        guard let navigationController else { return }
//        print("TabBarController will disappear, navController: \(navigationController)")
//    }
//    
//    override func willMove(toParent parent: UIViewController?) {
//        super.willMove(toParent: parent)
//        
//        print("TabBarController will move to parrent: \(parent) \(self.viewControllers)")
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//        print("TabBarController recieved mem warning")
//    }
//}
//
//extension TabBarController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected: \(viewController)")
//    }
//}
