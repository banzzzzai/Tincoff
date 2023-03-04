//
//  NewsModel.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

// MARK: - TeslaNews
struct TeslaNews: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}

// MARK: - Article
struct ArticleModel: Decodable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}
