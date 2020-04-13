//
//  SearchInteractor.swift
//  JISHO
//
//  Created by Alex on 02/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Alamofire
import PromiseKit

protocol SearchViewOutput {
    func request(keyword: String)
}

class SearchInteractor: SearchViewOutput {
    
    weak var viewInput: SearchViewInput?
    private let presenter: SearchPresenting
    private let realmInteractor: RealmInterface

    private let baseUrl: String = "https://jisho.org/api/v1/search/words?keyword="
    private let decoder = JSONDecoder()
    
    init(presenter: SearchPresenting = SearchPresenter(), realmInteractor: RealmInterface = RealmInteractor()) {
        self.presenter = presenter
        self.realmInteractor = realmInteractor
    }
    
    func request(keyword: String) {
        guard let englishUrl = createUrlString(from: keyword, wrapped: true), let japaneseUrl = createUrlString(from: keyword, wrapped: false) else { return }
        
        let promises: [Promise<SearchInteractionResult>] = [promiseForRequest(to: englishUrl),
                                                            promiseForRequest(to: japaneseUrl),
                                                            promiseForStoredFavouritesIds()]
        
        when(fulfilled: promises).done { [weak self] responses in
            
            /*
             var apiResponses = [SearchResponse?]()
             var realmIds = [String]
             
             switch on enum type of each response
             
             for result in responses {
                switch result {
                case .apiResponse(let response):
                    apiResponses.append(response)
                case .realmResponse(let ids):
                    realmIds = ids
                }
             }
             
             guard let firstResponse = responses[0] ...
             
            */
            
            var apiResponses = [SearchResponse?]()
            var realmIds = [String]()
            
            for response in responses {
                switch response {
                case .apiResponse(let searchResponse):
                    apiResponses.append(searchResponse)
                case .realmResponse(let ids):
                    realmIds = ids
                }
            }
            
            guard let firstResponse = apiResponses[0], let secondResponse = apiResponses[1] else {
                self?.viewInput?.showErrorState(true)
                return
            }
                        
            // interleave response data and make display items
            var allResponseData: [Datum] = []
            
            if firstResponse.data.count < secondResponse.data.count {
                for i in 0 ..< firstResponse.data.count {
                    allResponseData.append(firstResponse.data[i])
                    allResponseData.append(secondResponse.data[i])
                }
                // then add the rest of the longer one
                for i in firstResponse.data.count ..< secondResponse.data.count {
                    allResponseData.append(secondResponse.data[i])
                }
            } else {
                for i in 0 ..< secondResponse.data.count {
                    allResponseData.append(secondResponse.data[i])
                    allResponseData.append(firstResponse.data[i])
                }
                // then add the rest of the longer one
                for i in secondResponse.data.count ..< firstResponse.data.count {
                    allResponseData.append(firstResponse.data[i])
                }
            }
            
            let displayItems = self?.presenter.makeDisplayItems(from: allResponseData, favouritesIds: realmIds)
            
            if let items = displayItems, let data = self?.presenter.deduplicate(displayItems: items) {
                self?.viewInput?.data = data
            } else {
                self?.viewInput?.showErrorState(true)
            }
        }.catch { error in
            print(error.localizedDescription)
            self.viewInput?.showErrorState(true)
        }
    }
    
    private func promiseForRequest(to url: String) -> Promise<SearchInteractionResult> {
        return Promise { seal in
            AF.request(url).response { [weak self] response in
                guard let self = self else {
                    seal.fulfill(SearchInteractionResult.apiResponse(nil))
                    return
                }
                
                switch response.result {
                case .failure:
                    seal.fulfill(SearchInteractionResult.apiResponse(nil))
                case .success(let data):
                    guard let data = data else {
                        seal.fulfill(SearchInteractionResult.apiResponse(nil))
                        return
                    }
                    do {
                        let decoded = try self.decoder.decode(SearchResponse.self, from: data)
                        seal.fulfill(SearchInteractionResult.apiResponse(decoded))
                    } catch {
                        seal.fulfill(SearchInteractionResult.apiResponse(nil))
                    }
                }
            }
        }
    }
    
    private func promiseForStoredFavouritesIds() -> Promise<SearchInteractionResult> {
        return Promise { seal in
            let objects = realmInteractor.storedObjects()
            let ids = objects.map { $0.id }
            seal.fulfill(SearchInteractionResult.realmResponse(ids))
        }
    }
    
    private func createUrlString(from input: String, wrapped: Bool) -> String? {
        guard var escaped = input.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        if wrapped { escaped = wrapForEnglish(escaped) }
        
        return "\(baseUrl)\(escaped)"
    }
    
    private func wrapForEnglish(_ input: String) -> String {
        return "%22\(input)%22"
    }
}

enum SearchInteractionResult {
    case apiResponse(SearchResponse?)
    case realmResponse([String])
}
