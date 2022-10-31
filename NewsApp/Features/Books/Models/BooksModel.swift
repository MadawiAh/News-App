//
//  BooksModel.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 22/03/1444 AH.
//

import Foundation

// MARK: - BooksNetworkCall

struct BooksNetworkCall: Codable {
    let status, copyright: String
    let numResults: Int
    let results: BooksListsResult
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - BooksListsResult

struct BooksListsResult: Codable {
    let lists: [BookList]
}

// MARK: - BookList

struct BookList: Codable {
    let listName, displayName: String
    let books: [BookData]
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case books
    }
}

// MARK: - BookData

struct BookData: Codable {
    let title, updatedDate: String
    let amazonProductURL: String
    let author: String
    let bookImage: String
    let bookReviewLink: String?
    let createdDate, bookDescription: String
    let price, primaryIsbn10, primaryIsbn13: String
    let publisher: String
    let rank: Int
    let buyLinks: [BuyLink]
    let weeksOnList: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case updatedDate = "updated_date"
        case amazonProductURL = "amazon_product_url"
        case author
        case bookImage = "book_image"
        case bookReviewLink = "book_review_link"
        case createdDate = "created_date"
        case bookDescription = "description"
        case price
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case publisher, rank
        case buyLinks = "buy_links"
        case weeksOnList = "weeks_on_list"
    }
}

// MARK: - BuyLink

struct BuyLink: Codable {
    let name: SellerName
    let url: String
}

enum SellerName: String, Codable {
    case amazon = "Amazon"
    case appleBooks = "Apple Books"
    case barnesAndNoble = "Barnes and Noble"
    case booksAMillion = "Books-A-Million"
    case bookshop = "Bookshop"
    case indieBound = "IndieBound"
}

