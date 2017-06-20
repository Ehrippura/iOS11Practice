//
//  LargeTitleViewController.swift
//  Layout
//
//  Created by Tzu-Yi Lin on 2017/6/20.
//  Copyright © 2017年 Tzu-Yi Lin. All rights reserved.
//

import UIKit

class LargeTitleViewController: UITableViewController {

    private enum LargeTitleType: String {
        case automatic = "Automatic"
        case always = "Always"
        case never = "Never"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = true

        let idx = navigationController?.viewControllers.index(of: self) ?? 0
        title = "Controller: \(idx)"
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let type = LargeTitleType(rawValue: segue.identifier!) else {
            return
        }

        let targetNVItem = segue.destination.navigationItem

        switch type {
        case .automatic:
            targetNVItem.largeTitleDisplayMode = .automatic

        case .always:
            targetNVItem.largeTitleDisplayMode = .always

        case .never:
            targetNVItem.largeTitleDisplayMode = .never
        }
    }
}
