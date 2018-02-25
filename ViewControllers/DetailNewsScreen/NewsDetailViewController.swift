//
//  NewsDetailViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import WebKit
class NewsDetailViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
