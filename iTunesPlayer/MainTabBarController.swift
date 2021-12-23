//
//  MainTabBarController.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 21.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719351113, blue: 0.4505646229, alpha: 1)
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
        viewControllers = [setupVC(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Поиск"),
                           setupVC(rootViewController: ViewController(), image: #imageLiteral(resourceName: "library"), title: "Библиотека")]
    }
    
    private func setupVC(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationVC
    }
}
