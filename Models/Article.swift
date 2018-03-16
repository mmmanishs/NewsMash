//
//  Article.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    var urlNewsLogo: String?
    let urlToImage: String?
    let publishedAt: String?
    
    func setUrlNewsLogo(url: String) {
        self.urlNewsLogo = url
    }
}

class News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

class Source: Codable {
    let id: String?
    let name: String?
}

class NewsArticles {
    let newsType: NewsType
    var articles: [Article]
    init(newsType: NewsType, articles: [Article]) {
        self.newsType = newsType
        self.articles = articles
    }
}

