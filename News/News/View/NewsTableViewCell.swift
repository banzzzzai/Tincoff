//
//  NewsTableViewCell.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Public
    static let identifier = "NewsTableViewCell"
    
    func configure(with article: Article) {
        articleImageView.image = UIImage(data: article.imageData)
        articleNameLabel.text = article.title
        viewsCountLabel.text = "Views: \(article.viewsCount)"
    }

    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private let articleNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.axis = .vertical
        return view
    }()
    
}

// MARK: - Private methods
private extension NewsTableViewCell {
    func initialize() {
        contentView.addSubview(articleImageView)
        articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor, multiplier: 16/9).isActive = true
        
        stackView.addArrangedSubview(articleNameLabel)
        stackView.addArrangedSubview(viewsCountLabel)
        contentView.addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
}
