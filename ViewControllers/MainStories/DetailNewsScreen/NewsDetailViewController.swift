//
//  NewsDetailViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import WebKit
import AMScrollingNavbar

class NewsDetailViewController: UIViewController, ScrollingNavigationControllerDelegate {

    @IBOutlet weak var webview: WKWebView!
    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let request = try getURLRequest(urlString: (article?.url)!)
            webview.load(request)
        } catch {
            print("Error loading news article")
        }
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(webview, delay: 50, scrollSpeedFactor: 1.0, collapseDirection: .scrollUp, followers: [])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
    }

    func getURLRequest(urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.badURL
        }
        return URLRequest(url: url)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension NewsDetailViewController {
    func scrollingNavigationController(_ controller: AMScrollingNavbar.ScrollingNavigationController, didChangeState state: AMScrollingNavbar.NavigationBarState) {
        webview.frame.size.height = self.view.frame.size.height
    }
}

