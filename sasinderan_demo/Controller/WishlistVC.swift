//
//  WishlistVC.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 24/12/25.
//

import Foundation
import UIKit

class WishlistVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        addText()
    }
    
    func addText() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        label.text = "View your Wishlist Here!"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
    }

}
