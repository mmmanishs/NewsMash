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
    func getNewsStories() -> Promise<[Article]> {
        return Promise<[Article]> {fulfill, reject in
            all(
                RemoteDataController().getArticles(newsType: .topArticles),
                RemoteDataController().getArticles(newsType: .business),
                RemoteDataController().getArticles(newsType: .sports),
                RemoteDataController().getArticles(newsType: .technology)
                ).then() { severalArticles in
                    fulfill(severalArticles.flatMap {$0})
            }
        }

    }
}

