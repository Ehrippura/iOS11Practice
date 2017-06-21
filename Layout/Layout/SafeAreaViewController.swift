//
//  SafeAreaViewController.swift
//  Layout
//
//  Created by Wayne Lin on 2017/6/21.
//  Copyright © 2017年 Tzu-Yi Lin. All rights reserved.
//

import UIKit

class SafeAreaViewController: UIViewController {

    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isToolbarHidden = false

        let margin = view.safeAreaLayoutGuide

        subview.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true


    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        infoLabel.text = "Top Inset: \(view.safeAreaInsets.top)"
    }
}
