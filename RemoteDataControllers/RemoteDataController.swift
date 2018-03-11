//
//  RemoteDataController.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
import Alamofire

class RemoteDataController {
    func getArticles(newsType: NewsType) -> Promise<[Article]> {
        do {
            let newsRequest = try RequestProvider(newsType: newsType).getRequest()
            let promise = Promise<[Article]> { fullfil, reject in
                let remote = Alamofire.request(newsRequest)
                remote.responseData() { response in
                    guard let data = response.result.value else {
                        reject(ApiError.dataReturnedIsNull)
                        return
                    }
                    let decoder = JSONDecoder()
                    do { //Parsing now
                        let news = try decoder.decode(News.self, from: data) as News
                        fullfil(news.articles)
                        
                    } catch (let error){
                        reject(error)
                    }
                }
            }
            return promise
        }
        catch (let error){
            return Promise(error)
        }
    }
}


