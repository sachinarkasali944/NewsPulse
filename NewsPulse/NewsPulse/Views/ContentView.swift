//
//  ContentView.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 18/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading news...")
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
                } else {
                    List(viewModel.articles) { article in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(article.title)
                                .font(.headline)
                                .lineLimit(3)
                            if let description = article.description {
                                Text(description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    .background(Color.white.opacity(0.5))

                }
            }
            .navigationTitle("Top Headlines")
            .task {
                await viewModel.loadNews()
            }
        }
    }
}

#Preview {
    ContentView()
}
