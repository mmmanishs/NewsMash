//
//  ViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import Promises
import AMScrollingNavbar
class HeadlinesViewController: UIViewController {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    fileprivate let heightPerCell:CGFloat = 200.0
    fileprivate let itemsPerRow = 2
    var articles: [Article]?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Stories"
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(self.newsCollectionView, delay: 15.0)
        }
    }
    
    func loadData() {
        activityIndicator.isHidden = false
        DispatchQueue.global(qos: .background).async {
            let articlesPromise = NewsDataManager().getTopNewStories()
            articlesPromise.then(){ articles in
                
                self.articles = articles
                print("Articles count= \(articles.count)")
                DispatchQueue.main.async {
                    self.newsCollectionView.reloadData()
                    self.activityIndicator.isHidden = true
                }
                
                }.catch() { error in
                    print("Error : \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        loadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HeadlinesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (articles?.count ?? 0) / itemsPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return itemsPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "collectionviewreuseIdentifier"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? HeadingCell,
            let article = articles?[(indexPath.section * itemsPerRow) + indexPath.row] else {
                return HeadingCell()
        }
        cell.setupCell(article: article)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Router.detailNewsScreen(self, articles?[(indexPath.section * itemsPerRow) + indexPath.row]).route()
    }
}

extension HeadlinesViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: heightPerCell)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}