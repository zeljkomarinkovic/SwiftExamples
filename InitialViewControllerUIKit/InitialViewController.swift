//
//  InitialViewController.swift
//
//  Created by Zeljko Marinkovic on 22/10/2024.
//

import UIKit

class InitialViewController: UIViewController {
    
    // If we want to go this way and remove all storyboard files and use our own UIViewController to
    // be inital view, make sure to delete all .storyboard files and remove xcodeporj.pbxproj values
    // INFOPLIST_KEY_UILaunchStoryboardName = "";
    // INFOPLIST_KEY_UIMainStoryboardFile = "";
    // and remove
    // <key>UISceneStoryboardFile</key>
    // <string>Main</string>
    // from info.plist
    // After that do changes in SceneDelegate and initialize ViewController



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .green
    }
}

