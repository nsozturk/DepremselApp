//
//  DetailViewController.swift
//  FayHat
//
//  Created by enes öztürk on 6.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var eaq = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.red.cgColor
    }
}
