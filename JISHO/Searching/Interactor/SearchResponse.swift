import Foundation

struct SearchResponse: Decodable {
    let data: [Datum]
}

struct Datum: Decodable {
    let slug: String
    let japanese: [Japanese]
    let senses: [Sense]
}

struct Japanese: Decodable {
    let word: String?
    let reading: String?
}

struct Sense: Decodable {
    let english_definitions: [String]
    let parts_of_speech: [String]
    let links: [Link]
}

struct Link: Decodable {
    let text: String
    let url: String
}
