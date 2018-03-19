//
//  TableHeaderViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 3/18/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class TableHeaderViewController: UIViewController {
    var heading: String?
    @IBOutlet weak var labelHeading: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.flatWhite
        labelHeading.textColor = UIColor.flatBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        labelHeading.text = heading
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
