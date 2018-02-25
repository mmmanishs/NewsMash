//
//  ViewController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import Promises
class HeadlinesViewController: UIViewController {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    fileprivate let itemsPerRow = 2
    var articles: [Article]?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Stories"
        loadData()
    }
    
    func loadData() {
        DispatchQueue.global(qos: .background).async {
            let articlesPromise = DataManager().getTopNewStories()
            articlesPromise.then(){ articles in
                self.articles = articles
                print("Articles count= \(articles.count)")
                self.newsCollectionView.reloadData()
                }.catch() { error in
                    print("Error : \(error.localizedDescription)")
            }
        }
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
        let newsDetailViewController = NewsDetailViewController(nibName: "NewsDetailViewController", bundle: nil)
        newsDetailViewController.article = articles?[(indexPath.section * itemsPerRow) + indexPath.row]
        navigationController?.pushViewController(newsDetailViewController, animated: true)
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
        
        return CGSize(width: widthPerItem, height: widthPerItem)
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
