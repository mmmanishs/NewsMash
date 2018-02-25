//
//  Article.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Source: Codable {
    let id: String?
    let name: String?
}
