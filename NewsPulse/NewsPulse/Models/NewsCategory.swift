//
//  NewsCategory.swift
//  NewsPulse
//
//  Created by Sachin Arkasali on 20/10/25.
//

import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    case general = "general"
    case business = "business"
    case entertainment = "entertainment"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .general:
            return "General"
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
    
    var icon: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "briefcase"
        case .entertainment:
            return "tv"
        case .health:
            return "heart"
        case .science:
            return "atom"
        case .sports:
            return "sportscourt"
        case .technology:
            return "laptopcomputer"
        }
    }
}
