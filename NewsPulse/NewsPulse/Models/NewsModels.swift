//
//  NewsModels.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 18/10/25.
//

import Foundation

// MARK: - News response
struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

//  MARK: - News article
struct Articles: Decodable, Identifiable {
    let id: String // Use url as the identifier
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try container.decode(Source.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        let urlString = try container.decode(String.self, forKey: .url)
        self.url = urlString
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.id = urlString // Use the local variable instead of self.url
    }
}


// MARK: - Source
struct Source: Decodable {
    let id: String?
    let name: String
}

