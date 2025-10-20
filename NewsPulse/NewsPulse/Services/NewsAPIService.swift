//
//  NewsAPIService.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 18/10/25.
//

import Foundation

class NewsAPIService {
    
    func fetchTopHeadlines() async throws -> [Articles] {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=b09854f55786447aaedfdc71c0d310bd"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard data.count < 5_000_000 else {
            throw URLError(.dataLengthExceedsMaximum)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(NewsResponse.self, from: data)
        
        guard decoded.status == "ok" else {
            throw URLError(.badServerResponse)
        }
        
        guard decoded.articles.count <= 100 else {
            throw URLError(.dataLengthExceedsMaximum)
        }
        
        return decoded.articles
    }
}
