//
//  MainTabBarController.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 21.12.2021.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizedTrackDetailController()
    func maximizedTrackDetailsController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    private var minimizedTopAncorContsraint: NSLayoutConstraint!
    private var maximizedTopAncorContsraint: NSLayoutConstraint!
    private var bottomAncorConstraint: NSLayoutConstraint!
    let trackDetailView: TrackDetailsView = TrackDetailsView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719351113, blue: 0.4505646229, alpha: 1)
        
        setupTrackDetailView()
        searchVC.tabBarDelegate = self
        
        var library = Library()
        library.tabBarDelegate = self
        
        let hostVC = UIHostingController(rootView: library)
        hostVC.tabBarItem.image = #imageLiteral(resourceName: "library")
        hostVC.tabBarItem.title = "Библиотека"
        
        viewControllers = [hostVC, setupVC(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Поиск")]
    }
    
    private func setupVC(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationVC
    }
    
    private func setupTrackDetailView() {
        
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAncorContsraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
//        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        minimizedTopAncorContsraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAncorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAncorConstraint.isActive = true
        maximizedTopAncorContsraint.isActive = true
//        minimizedTopAncorContsraint.isActive = true
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func maximizedTrackDetailsController(viewModel: SearchViewModel.Cell?) {
        
        minimizedTopAncorContsraint.isActive = false
        maximizedTopAncorContsraint.isActive = true
        maximizedTopAncorContsraint.constant = 0
        bottomAncorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.trackDetailView.miniTrackView.alpha = 0
            self.trackDetailView.maximizedStackView.alpha = 1
        },
                       completion: nil)
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    func minimizedTrackDetailController() {
        
        maximizedTopAncorContsraint.isActive = false
        bottomAncorConstraint.constant = view.frame.height
        minimizedTopAncorContsraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.trackDetailView.miniTrackView.alpha = 1
            self.trackDetailView.maximizedStackView.alpha = 0
//            self.tabBar.transform = .identity
        },
                       completion: nil)
        
    }
}
