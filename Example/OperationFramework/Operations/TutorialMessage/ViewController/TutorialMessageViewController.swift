//
//  TutorialMessageViewController.swift
//  SampleApplication
//
//  Created by Amir on 10/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import UIKit

class TutorialMessageViewController:UIViewController {
    var message:String = ""
    var onCancelled:(()->Void)?
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = message
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            onCancelled?()
        }
    }
}
