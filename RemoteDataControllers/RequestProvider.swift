//
//  RequestProvider.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

let API_KEY = "bb204bbc7bbc4f04b3700f3eaf983e9a"

enum NewsType {
    case topArticles
    case business
    case sports
    case technology
    case science
    case logo(String)
}

class RequestProvider {
    let newsType: NewsType
    init(newsType: NewsType) {
        self.newsType = newsType
    }
    
    func getRequest() throws -> URLRequest {
        let endPoint = self.endPoint()
        guard let url = URL(string: endPoint) else {
            throw ApiError.badURL
        }
        do {
            let request = try URLRequest(url: url, method: .get, headers: nil) //pass the key in headers
            return request
        } catch {
            throw ApiError.badURL
        }
    }
    
    
    func endPoint() -> String {
        switch self.newsType {
        case .topArticles:
            return "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_KEY)"
        case .business:
            return "https://newsapi.org/v2/top-headlines?country=us&category=business&pageSize=99&apiKey=bb204bbc7bbc4f04b3700f3eaf983e9a"
        case .sports:
            return "https://newsapi.org/v2/top-headlines?country=us&category=sports&pageSize=99&apiKey=\(API_KEY)"
        case .technology:
            return "https://newsapi.org/v2/top-headlines?country=us&category=technology&pageSize=99&apiKey=\(API_KEY)"
        case .science:
                return "https://newsapi.org/v2/top-headlines?country=us&category=science&pageSize=50&apiKey=\(API_KEY)"
        case .logo(let domainName):
            return "https://logo.clearbit.com/\(domainName)"
        }
    }
}
