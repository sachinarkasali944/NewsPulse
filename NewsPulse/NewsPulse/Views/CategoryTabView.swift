//
//  CategoryTabView.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 20/10/25.
//

import SwiftUI

struct CategoryTabView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(NewsCategory.allCases) { category in
                    CategoryTabButton(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        Task {
                            await viewModel.selectCategory(category)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color(.systemBackground))
    }
}

struct CategoryTabButton: View {
    let category: NewsCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.system(size: 14, weight: .medium))
                
                Text(category.displayName)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.blue : Color(.systemGray6))
            )
            .foregroundColor(isSelected ? .white : .primary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CategoryTabView(viewModel: NewsViewModel())
}
