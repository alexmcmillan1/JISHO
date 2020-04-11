//
//  DetailInteractor.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol DetailViewOutput: class {
    func viewIsReady()
    func favouriteEntry(_ viewModel: DetailViewModel)
    func unfavouriteEntry(_ viewModel: DetailViewModel)
}

class DetailInteractor: DetailViewOutput {
    
    weak var viewInput: DetailViewInput?
    
    private let baseWikiUrl: String = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=%@&exsentences=2"
    private let baseKanjiApiUrl: String = "https://kanjiapi.dev/v1/kanji/%@"
    
    private let presenter: DetailPresenting
    private let realmInteractor: RealmInterface
    private let data: EntryDisplayItem
    private let decoder = JSONDecoder()
    
    init(presenter: DetailPresenting = DetailPresenter(), realmInteractor: RealmInterface, data: EntryDisplayItem) {
        self.presenter = presenter
        self.realmInteractor = realmInteractor
        self.data = data
    }
    
    func viewIsReady() {
        when(fulfilled: createPromises(from: data)).done { (responses) in
            
            var wikiExtract: String?
            var kanji: [KanjiAPIResponse?] = []
            
            for response in responses.compactMap({$0}) {
                switch response {
                case .kanji(let k):
                    kanji.append(k)
                case .wiki(let w):
                    if let extract = w?.query.pages.first?.value["extract"].rawString() {
                        wikiExtract = extract
                    }
                }
            }
            
            let viewModel = self.presenter.makeViewModel(from: self.data, wikiExtract: wikiExtract, kanji: kanji.compactMap { $0 })
            self.viewInput?.viewModel = viewModel
        }.catch { error in
            print(error.localizedDescription)
        }
    }
    
    func favouriteEntry(_ viewModel: DetailViewModel) {
        realmInteractor.save(viewModel)
    }
    
    func unfavouriteEntry(_ viewModel: DetailViewModel) {
        realmInteractor.delete(viewModel)
    }
}

extension DetailInteractor {
    private func wikiPageTitle(from detail: EntryDisplayItem) -> String? {
        let firstEnglishWikiLink = detail.links.first { link -> Bool in
            link.description.contains("English Wikipedia")
        }
        
        let lastComponent = firstEnglishWikiLink?.addressString.components(separatedBy: "/").last
        return lastComponent?.components(separatedBy: "?").first
    }
    
    private func createPromises(from data: EntryDisplayItem) -> [Promise<ParallelResponse?>] {
        let kanjiPromises: [Promise<ParallelResponse?>] = data.kanji.compactMap { kanji -> Promise<ParallelResponse?>? in
            self.kanjiAPIRequestPromise(character: kanji)
        }
        
        var wikiPromise: Promise<ParallelResponse?>?
        
        if let pageTitle = wikiPageTitle(from: data), let promise = wikiAPIRequestPromise(pageTitle: pageTitle) {
            wikiPromise = promise
        }
        
        let promises: [Promise<ParallelResponse?>] = kanjiPromises + ((wikiPromise != nil) ? [wikiPromise!] : [])
        
        return promises
    }
    
    private func kanjiAPIRequestPromise(character: String) -> Promise<ParallelResponse?>? {
        guard let url = String(format: baseKanjiApiUrl, character).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return Promise { seal in
            AF.request(url).response { response in
                switch response.result {
                case .failure:
                    seal.fulfill(nil)
                case .success(let data):
                    guard let data = data else {
                        seal.fulfill(nil)
                        return
                    }
                    do {
                        let decoded = try self.decoder.decode(KanjiAPIResponse.self, from: data)
                        seal.fulfill(ParallelResponse.kanji(decoded))
                    } catch {
                        seal.fulfill(nil)
                    }
                }
            }
        }
    }
    
    private func wikiAPIRequestPromise(pageTitle: String) -> Promise<ParallelResponse?>? {
        guard let url = String(format: baseWikiUrl, pageTitle).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
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
                        let decoded = try self.decoder.decode(WikipediaExtractResponse.self, from: data)
                        seal.fulfill(ParallelResponse.wiki(decoded))
                    } catch {
                        seal.fulfill(nil)
                    }
                }
            }
        }
    }
}

enum ParallelResponse {
    case kanji(KanjiAPIResponse?)
    case wiki(WikipediaExtractResponse?)
}
