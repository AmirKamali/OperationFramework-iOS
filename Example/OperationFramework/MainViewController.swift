//
//  ViewController.swift
//  SampleApplication
//
//  Created by Amir on 8/1/20.
//  Copyright © 2020 Amir Kamali. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            startTutorial()
        case 1:
            startChainedDownload()
        case 2:
            startAdvancedExample()
        default:
            break
        }
    }
    
    func startTutorial() {
        let config = TutorialOperationBuilderConfig()
        config.pageMessages = ["Message 1","Message 2","Message 3","Message 4","Message 5"]
       let tutorialBuilder = TutorialOperationBuilder(config: config, navigationController: self.navigationController)
        tutorialBuilder.start()
        
    }
    
    func startChainedDownload(){
        let downloadBuilder = DownloadOperationBuilder(currentViewController: self)
        downloadBuilder.start()
    }
    
    func startAdvancedExample(){
        AdvancedExampleOperationBuilder(navigationController: self.navigationController).start()
    }

}

