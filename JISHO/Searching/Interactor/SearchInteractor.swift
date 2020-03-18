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

    private let baseUrl: String = "https://jisho.org/api/v1/search/words?keyword="
    private let decoder = JSONDecoder()
    
    init(presenter: SearchPresenting = SearchPresenter()) {
        self.presenter = presenter
    }
    
    func request(keyword: String) {
        guard let englishUrl = createUrlString(from: keyword, wrapped: true), let japaneseUrl = createUrlString(from: keyword, wrapped: false) else { return }
        
        let promises: [Promise<SearchResponse?>] = [promiseForRequest(to: englishUrl), promiseForRequest(to: japaneseUrl)]
        
        when(fulfilled: promises).done { [weak self] (responses) in
            guard let firstResponse = responses[0], let secondResponse = responses[1] else {
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
            
            let sanitised: [EntryDisplayItem] = allResponseData.compactMap { slug -> EntryDisplayItem? in
                self?.presenter.makeDisplayItem(from: slug)
            }
            
            if let data = self?.presenter.deduplicate(displayItems: sanitised) {
                self?.viewInput?.data = data
            } else {
                self?.viewInput?.showErrorState(true)
            }
        }.catch { error in
            print(error.localizedDescription)
            self.viewInput?.showErrorState(true)
        }
    }
        
    private func promiseForRequest(to url: String) -> Promise<SearchResponse?> {
        return Promise { seal in
            AF.request(url).response { [weak self] response in
                guard let self = self else {
                    seal.fulfill(nil)
                    return
                }
                
                switch response.result {
                case .failure:
                    seal.fulfill(nil)
                case .success(let data):
                    guard let data = data else {
                        seal.fulfill(nil)
                        return
                    }
                    do {
                        let decoded = try self.decoder.decode(SearchResponse.self, from: data)
                        seal.fulfill(decoded)
                    } catch {
                        seal.fulfill(nil)
                    }
                }
            }
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
