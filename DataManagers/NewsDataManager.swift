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
    func getTopNewStories() -> Promise<[Article]> {
        return RemoteDataController().getArticles()
    }
}
