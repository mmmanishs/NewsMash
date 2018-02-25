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
    func getArticles() -> Promise<[Article]> {
        do {
            let topNewsURLRequest = try RequestProvider.topArticles.getRequest()
            let promise = Promise<[Article]> { fullfil, reject in
                let remote = Alamofire.request(topNewsURLRequest)
                remote.responseData() { response in
                    guard let data = response.result.value else {
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
            return Promise { fulfill, reject in
                reject(error)
            }
        }
    }
}


enum RequestProvider {
    case topArticles
    func getRequest() throws -> URLRequest {
        switch self {
        case .topArticles:
            do {
                return try getTopArticlesRequest()
            } catch (let error) {
                throw error
            }
        }
    }
    
    func getTopArticlesRequest() throws -> URLRequest {
        let endPoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=bb204bbc7bbc4f04b3700f3eaf983e9a"
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
}
