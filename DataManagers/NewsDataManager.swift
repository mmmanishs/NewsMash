//
//  DataManager.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
class NewsDataManager {
    func getNewsStories() -> Promise<[NewsArticles]> {
        return Promise<[NewsArticles]> {fulfill, reject in
            all(
                RemoteDataController().getArticles(newsType: .topArticles),
                RemoteDataController().getArticles(newsType: .business),
                RemoteDataController().getArticles(newsType: .sports),
                RemoteDataController().getArticles(newsType: .technology),
                RemoteDataController().getArticles(newsType: .science)
                ).then() { severalArticles in
                    let topArticles = NewsArticles(newsType: .topArticles, articles: severalArticles[0])
                    let business = NewsArticles(newsType: .topArticles, articles: severalArticles[1])
                    let sports = NewsArticles(newsType: .topArticles, articles: severalArticles[2])
                    let technology = NewsArticles(newsType: .topArticles, articles: severalArticles[3])
                    let science = NewsArticles(newsType: .topArticles, articles: severalArticles[4])
                    fulfill([topArticles, business, sports, technology, science])
            }
        }

    }
}

