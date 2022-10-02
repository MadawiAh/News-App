//
//  MoviesModel.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 16/02/1444 AH.
//
import Foundation

struct MoviesNetworkCall: Codable {
    let copyright: String
    let hasMore: Bool
    let numResults: Int
    let response: [MoviesData]

    enum CodingKeys: String, CodingKey {
        case copyright
        case hasMore = "has_more"
        case numResults = "num_results"
        case response = "results"
    }
}

// MARK: MoviesData

struct MoviesData: Codable {
    let displayTitle: String
    let mpaaRating: String
    let criticsPick: Int
    let byline, headline, summaryShort, publicationDate: String
    let openingDate: String?
    let dateUpdated: String
    let link: Link
    let multimedia: MoviesMultimedia

    enum CodingKeys: String, CodingKey {
        case displayTitle = "display_title"
        case mpaaRating = "mpaa_rating"
        case criticsPick = "critics_pick"
        case byline, headline
        case summaryShort = "summary_short"
        case publicationDate = "publication_date"
        case openingDate = "opening_date"
        case dateUpdated = "date_updated"
        case link, multimedia
    }
    
    var hasMpaaRating: Bool {
        return  mpaaRating == "Unrated" ||
                mpaaRating == "Not Rated" ||
                mpaaRating == "" ? false: true
    }
    
    var isCriticsPick: Bool {
        return criticsPick == 1
    }
}

// MARK: Link

struct Link: Codable {
    let url: String
    let suggestedLinkText: String

    enum CodingKeys: String, CodingKey {
        case url
        case suggestedLinkText = "suggested_link_text"
    }
}

// MARK: MoviesMultimedia

struct MoviesMultimedia: Codable {
    let src: String
    let height, width: Int
}
