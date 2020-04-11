//
//  KanjiInteractor.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import Alamofire

protocol KanjiViewOutput: class {
    func viewIsReady()
}

class KanjiInteractor: KanjiViewOutput {
    
    weak var viewInput: KanjiViewInput?
    
    private let character: String
    private let baseUrl: String = "https://kanjiapi.dev/v1/kanji/%@"
    private let decoder = JSONDecoder()
    private let presenter: KanjiPresenting
    
    init(presenter: KanjiPresenting = KanjiPresenter(), character: String) {
        self.presenter = presenter
        self.character = character
    }
    
    func viewIsReady() {
        AF.request(createUrl(for: character)).response { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.handleDataResponse(data)
            }
        }
    }
    
    private func createUrl(for character: String) -> String {
        return String(format: baseUrl, character).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    private func handleDataResponse(_ data: Data?) {
        guard let data = data else { return }
        do {
            let decoded = try self.decoder.decode(KanjiResponseItem.self, from: data)
            self.viewInput?.data = self.presenter.makeDisplayItems(from: decoded)
        } catch {
            print("Decoding error")
        }
    }
}
