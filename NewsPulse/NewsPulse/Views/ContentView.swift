//
//  ContentView.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 18/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CategoryTabView(viewModel: viewModel)
                    .padding(.vertical, 8)
                
                if viewModel.isLoading {
                    ProgressView("Loading news...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Error loading news")
                            .font(.headline)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task {
                                await viewModel.loadNews()
                            }
                        }
                        .padding(.top)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 30) {
                            ForEach(viewModel.articles) { article in
                                NewsCardView(article: article) {
                                    openURL(article.url)
                                }
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationTitle("NewsPulse")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.loadNews()
            }
        }
    }
}

#Preview {
    ContentView()
}
