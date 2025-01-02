//
//  MainViewController.swift
//  UITabBarController
//
//  Created by Zeljko Marinkovic on 07/11/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var window: UIWindow!
    
    var button: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.title = "Tap me"
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
        config.baseBackgroundColor = .tintColor
        
        let button = UIButton(configuration: config)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Main View Controller"
        
        view.backgroundColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("MAIN WILL APPEAR")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("VC \(self)\(title) recieved mem warning")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        print("VC \(self)\(title) will move to parent")
    }
    
    @objc
    func buttonAction() {
        let redVC: UINavigationController = createRedNVC()
        let greenVC: UINavigationController = createGreenNVC()
        let blueVC: UINavigationController = createBlueNVC()
        
        let tabBarVC = TabBarController()

        tabBarVC.viewControllers = [redVC, greenVC, blueVC]
        
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }
    
    @objc
    func backAction() {
        print("BACK")
    }
    
    private func createRedNVC() -> UINavigationController {
        let root = ViewControllerRed()
        let nav = UINavigationController(rootViewController: root)
        nav.viewControllers.first?.navigationItem.title = "\(root.title) Controller"
        nav.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(backAction))
        
        nav.tabBarItem = UITabBarItem(title: "Red", image: nil, tag: 0)
        
        return nav
    }
    
    private func createGreenNVC() -> UINavigationController {
        let root = ViewControllerGreen()
        let nav = UINavigationController(rootViewController: root)
        
        nav.tabBarItem = UITabBarItem(title: "Green", image: nil, tag: 0)
        
        return nav
    }
    
    private func createBlueNVC() -> UINavigationController {
        let root = ViewControllerBlue()
        let nav = UINavigationController(rootViewController: root)
        
        nav.tabBarItem = UITabBarItem(title: "Blue", image: nil, tag: 0)
        
        return nav
    }
}

class ViewControllerBlue: UIViewController {
    
    deinit {
        print("OS reclaiming memory for ViewControllerBlue")
//        tabBarItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        title = "Blue"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("VC \(self) recieved mem warning")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("VC \(self) will disappear")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        print("VC \(self) will move to parent:\(parent)")
    }
}

class ViewControllerRed: UIViewController {
    
    deinit {
        print("OS reclaiming memory for ViewControllerRed")
//        tabBarItem = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        title = "Red"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("VC \(self)\(title) recieved mem warning")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("VC \(self)\(title) will disappear")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        print("VC \(self)\(title) will move to parent:\(parent)")
    }
}

class ViewControllerGreen: UIViewController {
    
    deinit {
        print("OS reclaiming memory for ViewControllerGreen")
//        tabBarItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .green
        title = "Green"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("VC \(self)\(title) recieved mem warning")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("VC \(self)\(title) will disappear")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        print("VC \(self)\(title) will move to parent:\(parent)")
    }
}

class TabBarController: UITabBarController {
    
    deinit {
        print("OS reclaiming memory for TabBarController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.tabBar.backgroundColor = .systemGray
        
        print("TabBarController didLoad, navController: \(self)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let navigationController else { return }
        print("TabBarController will disappear, navController: \(navigationController)")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        print("TabBarController will move to parrent: \(parent) \(self.viewControllers)")
        
        guard let navigationController else { return }
        
        print("TabBarController will move to parrent: \(parent) \(self.viewControllers), navController: \(navigationController)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected: \(viewController)")
    }
}
