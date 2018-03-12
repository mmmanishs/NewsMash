//
//  HeadingCell.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HeadingCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var newSourceLogo: UIImageView!

    func setupCell(article: Article) {
        if let urlToImage = article.urlToImage {
            imageView.sd_setImage(with: URL(string: urlToImage), placeholderImage: UIImage(named: "placeholderImage"))
        }
        if let host = URL(string: article.url)?.host {
            if let url = try? URL(string: RequestProvider(newsType: .logo(host)).endPoint()) {
                newSourceLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
            }
        }

        name.text = article.title ?? ""
        //source.text = article.source.name ?? ""
        
    }
}
