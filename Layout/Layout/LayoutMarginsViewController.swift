//
//  LayoutMarginsViewController.swift
//  Layout
//
//  Created by Wayne Lin on 2017/6/21.
//  Copyright © 2017年 Tzu-Yi Lin. All rights reserved.
//

import UIKit

class LayoutMarginsViewController: UIViewController {

    @IBOutlet var subview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0,
                                                                leading: 0,
                                                                bottom: 0,
                                                                trailing: 0)

        // uncommand this line
        // viewRespectsSystemMinimumLayoutMargins = false

        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        
        let margin = view.layoutMarginsGuide
        subview.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
    }
}

