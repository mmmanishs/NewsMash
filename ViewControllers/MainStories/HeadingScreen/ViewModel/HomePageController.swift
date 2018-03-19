//
//  HomePageViewModel.swift
//  NewsMash
//
//  Created by Manish Singh on 3/15/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises

enum HomePageState {
    case loading
    case loadedSuccess
    case loadingError
}

protocol HomePageUpdate {
    func updateViewController(state: HomePageState, viewModel: HomePageViewModel?)
}

class HomePageController {
    var viewModel: HomePageViewModel?
    var delegate: HomePageUpdate?
    
    func getData() {
        self.viewModel = HomePageViewModel(sections: [])
        delegate?.updateViewController(state: .loading, viewModel: self.viewModel)
        all(
            RemoteDataController().getArticles(newsType: .topArticles),
            RemoteDataController().getArticles(newsType: .business),
            RemoteDataController().getArticles(newsType: .sports),
            RemoteDataController().getArticles(newsType: .technology),
            RemoteDataController().getArticles(newsType: .science)
            ).then() { severalArticles in
                let topArticles = SectionData(news:NewsArticles(newsType: .topArticles, articles: severalArticles[0]))
                let business = SectionData(news:NewsArticles(newsType: .business, articles: severalArticles[1]))
                let sports = SectionData(news:NewsArticles(newsType: .sports, articles: severalArticles[2]))
                let technology = SectionData(news:NewsArticles(newsType: .technology, articles: severalArticles[3]))
                let science = SectionData(news:NewsArticles(newsType: .science, articles: severalArticles[4]))
                self.viewModel = HomePageViewModel(sections: [topArticles, business, sports, technology, science])
                self.delegate?.updateViewController(state: .loadedSuccess, viewModel: self.viewModel)
                
        }
    }
}

struct HomePageViewModel {
    private var sections: [SectionData]
    var numberOfSections: Int {
        return sections.count
    }
    var order: [NewsType] = [.topArticles, .business, .sports, .science, .technology]
    init(sections: [SectionData]) {
        self.sections = sections
    }
    
    func getSection(sectionIndex: Int) -> SectionData? {
        guard sections.count > sectionIndex,
        order.count > sectionIndex,
        sectionIndex >= 0 else {
            return nil
        }
        return sections[sectionIndex]
    }

}

struct SectionData {
    var sectionHeader: String {
        switch news.newsType {
        case .topArticles:
            return "Top Articles"
        case .business:
            return "Business"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        case .science:
            return "Science"
        default:
            return""
        }
    }
    
    let news: NewsArticles
    init(news: NewsArticles) {
        self.news = news
    }
}
