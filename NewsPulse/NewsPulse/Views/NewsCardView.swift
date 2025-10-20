//
//  NewsCardView.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 20/10/25.
//

import SwiftUI

struct NewsCardView: View {
    let article: Articles
    let onTap: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            // Image Section
            if let imageUrl = article.urlToImage, !imageUrl.isEmpty {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                                .tint(.gray)
                        )
                }
                .frame(height: 200)
                .clipped()
            } else {
                Rectangle()
                    .fill(LinearGradient(
                        colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "newspaper")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.8))
                    )
            }
            
            // Content Section
            VStack(alignment: .leading, spacing: 12) {
                // Source and Date
                HStack {
                    Text(article.source.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(6)
                    
                    Spacer()
                    
                    Text(formatDate(article.publishedAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Title
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Description
                if let description = article.description, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // Author
                if let author = article.author, !author.isEmpty {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.caption)
                        Text("By \(author)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Read More Button
                Button(action: onTap) {
                    HStack {
                        Text("Read Full Article")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .padding(20)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(colorScheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.06), lineWidth: 1)
                )
        )
        .shadow(color: (colorScheme == .dark ? Color.black.opacity(0.6) : Color.black.opacity(0.1)), radius: colorScheme == .dark ? 12 : 6, x: 0, y: colorScheme == .dark ? 8 : 2)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}

#Preview {
    NewsCardView(
        article: Articles(
            source: Source(id: "test", name: "Test News"),
            author: "John Doe",
            title: "Sample News Title That Could Be Very Long",
            description: "This is a sample description for the news article that provides more details about the story.",
            url: "https://example.com",
            urlToImage: nil,
            publishedAt: "2024-10-20T10:00:00Z",
            content: "Sample content"
        ),
        onTap: {}
    )
}
