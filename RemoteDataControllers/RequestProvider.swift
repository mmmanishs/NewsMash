//
//  RequestProvider.swift
//  NewsMash
//
//  Created by Manish Singh on 2/24/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

enum RequestProvider {
    case topArticles
    case logo(String)
    func getRequest() throws -> URLRequest {
        switch self {
        case .topArticles:
            do {
                return try getTopArticlesRequest()
            } catch (let error) {
                throw error
            }
        case .logo(let domainName):
        do {
            return try getNewsLogoRequest(domainName: domainName)
        } catch (let error) {
            throw error
            }
            
        }
    }
    
    private func getTopArticlesRequest() throws -> URLRequest {
        let endPoint = "https://newsapi.org/v2/top-headlines?country=us&pageSize=99&apiKey=bb204bbc7bbc4f04b3700f3eaf983e9a"
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
    
    private func getSampleAll() throws -> URLRequest {
        let endPoint = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=bb204bbc7bbc4f04b3700f3eaf983e9a"
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
    
    
    private func getNewsLogoRequest(domainName: String) throws -> URLRequest {
        let endPoint = "https://logo.clearbit.com/\(domainName)"
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

extension RequestProvider {
    static func getLogoUrl(domainName: String) -> URL? {
        let endPoint = "https://logo.clearbit.com/\(domainName)"
        guard let url = URL(string: endPoint) else {
            return nil
        }
        return url
    }
}
