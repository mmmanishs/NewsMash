//
//  HomePageViewControllerViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 3/15/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class HomePageViewControllerViewController: UIViewController, HomePageUpdate {
    @IBOutlet weak var tableview: UITableView!

    let controller = HomePageController()
    var viewModel: HomePageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        controller.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViewController(state: HomePageState, viewModel: HomePageViewModel?) {
        self.viewModel = viewModel
        switch state {
        case .loading:
            break
        case .loadedSuccess:
            break
        default: break
            
        }
        updateView(viewModel: viewModel)

    }

    func updateView(viewModel: HomePageViewModel?) {
        self.tableview.reloadData()
    }
}

extension HomePageViewControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let newsSections = viewModel?.sections,
            newsSections.count > (section) else {
            return 0
        }
        return newsSections[section] .news.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadingCell") as! HeadingCell
        if let article = viewModel?.sections[0].news.articles[indexPath.row] {
            cell.setupCell(article: article)
        }
        return cell
    }
    
    
}

extension HomePageViewControllerViewController: UITableViewDelegate {
    
}
