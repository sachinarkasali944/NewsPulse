//
//  NewsViewModel.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 18/10/25.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles: [Articles] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedCategory: NewsCategory = .general
    
    private var service: NewsAPIService?
    
    init() {
        self.service = NewsAPIService()
    }
    
    func loadNews() async {
        isLoading = true
        errorMessage = nil
        
        guard let service = service else {
            errorMessage = "Service not available"
            isLoading = false
            return
        }
        
        do {
            let fetchedArticles = try await service.fetchTopHeadlines(category: selectedCategory)
            
            await MainActor.run {
                self.articles.removeAll()
                self.articles = fetchedArticles
            }
            
            if articles.isEmpty {
                await MainActor.run {
                    self.errorMessage = "No articles found. This might be due to API limitations or regional restrictions."
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load news: \(error.localizedDescription)"
            }
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }
    
    func selectCategory(_ category: NewsCategory) async {
        selectedCategory = category
        await loadNews()
    }
    
}
