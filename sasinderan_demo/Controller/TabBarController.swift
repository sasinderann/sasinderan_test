//
//  TabBarController.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 24/12/25.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        selectDefaultPortfolio()
        configureTabBarAppearance()
    }

    func setupTabs() {
        let watchlistVC = WishlistVC()
        let watchlistNav = UINavigationController(rootViewController: watchlistVC)
        watchlistNav.tabBarItem = UITabBarItem(
            title: "Watchlist",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet.rectangle")
        )

        let ordersVC = OrderVC()
        let ordersNav = UINavigationController(rootViewController: ordersVC)
        ordersNav.tabBarItem = UITabBarItem(
            title: "Orders",
            image: UIImage(systemName: "clock"),
            selectedImage: UIImage(systemName: "clock.fill")
        )

        let portfolioVC = PortfolioVC()
        let portfolioNav = UINavigationController(rootViewController: portfolioVC)
        portfolioNav.tabBarItem = UITabBarItem(
            title: "Portfolio",
            image: UIImage(systemName: "briefcase"),
            selectedImage: UIImage(systemName: "briefcase.fill")
        )

        let fundsVC = FundsVC()
        let fundsNav = UINavigationController(rootViewController: fundsVC)
        fundsNav.tabBarItem = UITabBarItem(
            title: "Funds",
            image: UIImage(systemName: "indianrupeesign"),
            selectedImage: UIImage(systemName: "indianrupeesign.fill")
        )

        let investVC = InvestVC()
        let investNav = UINavigationController(rootViewController: investVC)
        investNav.tabBarItem = UITabBarItem(
            title: "Invest",
            image: UIImage(systemName: "circle.grid.3x3"),
            selectedImage: UIImage(systemName: "circle.grid.3x3.fill")
        )

        viewControllers = [
            watchlistNav,
            ordersNav,
            portfolioNav,
            fundsNav,
            investNav
        ]
    }
    
    func selectDefaultPortfolio() {
        selectedIndex = 2
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
