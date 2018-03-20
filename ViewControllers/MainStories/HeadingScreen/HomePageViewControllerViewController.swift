//
//  HomePageViewControllerViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 3/15/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class HomePageViewControllerViewController: UIViewController, HomePageUpdate {
    @IBOutlet weak var tableview: UITableView!
    let controller = HomePageController()
    var viewModel: HomePageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "N E W S"
        controller.delegate = self
        controller.getData()
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = viewModel?.getSection(sectionIndex: indexPath.section)?.news.articles[indexPath.row] {
            Router.detailNewsScreen(self, article).route()
        }
    }
}

extension HomePageViewControllerViewController: ScrollingNavigationControllerDelegate {
    func scrollingNavigationController(_ controller: AMScrollingNavbar.ScrollingNavigationController, didChangeState state: AMScrollingNavbar.NavigationBarState) {
        //        tableview.frame = self.view.frame
        tableview.frame.size.height = self.view.frame.size.height
        
    }
}

extension HomePageViewControllerViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableview, delay: 50, scrollSpeedFactor: 1.0, collapseDirection: .scrollUp, followers: [])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
    }
}



