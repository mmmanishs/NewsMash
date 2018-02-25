//
//  ViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import Promises
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            let articlesPromise = DataManager().getTopNewStories()
            articlesPromise.then(){ articles in
                print("Articles count= \(articles.count)")
                }.catch() { error in
                    print("Error : \(error.localizedDescription)")
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

