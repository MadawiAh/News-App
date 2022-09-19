//
//  News.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 23/01/1444 AH.
//
import Foundation
import UIKit

struct NewsNetworkCall: Codable {
    let copyright: String
    let response: NewsResponse
}

struct NewsResponse: Codable {
    let docs: [NewsData]
    let meta: NewsMetaData
}

// MARK: News Data

struct NewsData: Codable {
    
    let abstract: String
    let webURL: String
    let snippet, leadParagraph: String
    let source: String
    let multimedia: [NewsMultimedia]
    let headline: Headline
    let keywords: [Keyword]
    let pubDate: String
    let documentType: String
    let newsDesk: String
    let sectionName: String
    let byline: Byline
    let wordCount: Int
    let subsectionName: String?
    
    enum CodingKeys: String, CodingKey {
        case abstract
        case webURL = "web_url"
        case snippet
        case leadParagraph = "lead_paragraph"
        case source, multimedia, headline, keywords
        case pubDate = "pub_date"
        case documentType = "document_type"
        case newsDesk = "news_desk"
        case sectionName = "section_name"
        case byline
        case wordCount = "word_count"
        case subsectionName = "subsection_name"
    }
    
    var timeToRead: String {
        get {
            let time = Int(round(Double(wordCount)/200.0))
            return "\(time == 0 ? "less than" : (String(describing: time))) min read"
        }
    }
    // TODO: Needs further testing
    var formatedDate: String {
        get {
            /// casting to dates
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: pubDate)!
            
            let now = Date()
            
            /// comparison
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
            formatter.maximumUnitCount = 1
            
            return formatter.string(from: date, to: now) ?? String(describing: pubDate)
        }
    }
}

// MARK: Byline

struct Byline: Codable {
    let original: String?
    let person: [Person]
    let organization: String?
}

// MARK: Person

struct Person: Codable {
    let firstname: String
    let middlename: String?
    let lastname: String
    let qualifier: String?
    let role: String
    let organization: String
    let rank: Int
}

// MARK: Headline

struct Headline: Codable {
    let main: String
    let kicker: String?
    let printHeadline: String
    
    enum CodingKeys: String, CodingKey {
        case main, kicker
        case printHeadline = "print_headline"
    }
}

// MARK: Keyword

struct Keyword: Codable {
    let name: String
    let value: String
    let rank: Int
    let major: String
}

// MARK: Multimedia

struct NewsMultimedia: Codable {
    let type: String
    let url: String
    let height, width: Int
    
    enum CodingKeys: String, CodingKey {
        case type, url, height, width
    }
}
// MARK: News Meta Data

struct NewsMetaData: Codable {
    let hits: Int
}

