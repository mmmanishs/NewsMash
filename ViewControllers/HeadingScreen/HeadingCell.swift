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

    func setupCell(article: Article) {
        if let urlToImage = article.urlToImage {
            print(urlToImage)
            imageView.sd_setImage(with: URL(string: urlToImage), placeholderImage: UIImage(named: "placeholderImage"))
        }
        name.text = article.description ?? ""
    }
}
