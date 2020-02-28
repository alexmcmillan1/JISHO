//
//  SearchInteractor.swift
//  JISHO
//
//  Created by Alex on 02/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Alamofire

protocol SearchViewOutput {
    func request(keyword: String, language: Language)
}

class SearchInteractor: SearchViewOutput {
    
    weak var viewInput: SearchViewInput?
    private let presenter: SearchPresenting

    private let baseUrl: String = "https://jisho.org/api/v1/search/words?keyword="
    private let decoder = JSONDecoder()
    
    init(presenter: SearchPresenting = SearchPresenter()) {
        self.presenter = presenter
    }
    
    func request(keyword: String, language: Language) {
        guard let fullUrl: String = createUrlString(from: keyword, language: language) else { return }
                
        AF.request(fullUrl).response { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                if let data = data {
                    self.handleDataResponse(data)
                }
            }
        }
    }
    
    private func handleDataResponse(_ data: Data) {
        do {
            let decoded = try self.decoder.decode(SearchResponse.self, from: data)
            let sanitised: [EntryDisplayItem] = decoded.data.compactMap { slug -> EntryDisplayItem? in
                presenter.makeDisplayItem(from: slug)
            }
            viewInput?.data = sanitised
        } catch {
            print("Decoding error")
        }
    }
    
    private func createUrlString(from input: String, language: Language) -> String? {
        guard var escaped = input.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        if language == .english { escaped = wrapForEnglish(escaped) }
        
        return "\(baseUrl)\(escaped)"
    }
    
    private func wrapForEnglish(_ input: String) -> String {
        return "%22\(input)%22"
    }
}
