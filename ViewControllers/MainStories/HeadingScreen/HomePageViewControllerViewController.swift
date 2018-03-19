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
        title = "N E W S"
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

    @IBAction func reloadData(_ sender: Any) {
        controller.getData()
    }
    func updateView(viewModel: HomePageViewModel?) {
        self.tableview.reloadData()
    }
}

extension HomePageViewControllerViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
                return 0
        }
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = viewModel?.getSection(sectionIndex: section) else {
            return 0
        }
        return sectionData.news.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadingCell") as! HeadingCell
        if let article = viewModel?.getSection(sectionIndex: indexPath.section)?.news.articles[indexPath.row] {
            cell.setupCell(article: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vc = TableHeaderViewController()
        vc.heading = viewModel?.getSection(sectionIndex: section)?.sectionHeader
        let view = vc.view
        
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return view
    }
}

extension HomePageViewControllerViewController: UITableViewDelegate {
    
}
