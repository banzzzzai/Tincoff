//
//  DetailedNewsViewController.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit

protocol DetailedNewsViewProtocol: AnyObject {
    
    func showInfo(article: Article)
    func showNoInternetAlert()
    
}

class DetailedNewsViewController: UIViewController {
    
    var presenter: DetailedNewsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    // MARK: - Private properties
    private let scrollView = UIScrollView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let descriprionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkStackView = UIStackView()
    
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var url: String?
    
}

private extension DetailedNewsViewController {
    
    func initialize() {
        view.backgroundColor = .systemBackground
        title = "Details"
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/9).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(titleImageView)
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        titleImageView.widthAnchor.constraint(equalTo: titleImageView.heightAnchor, multiplier: 16/9).isActive = true
        
        view.addSubview(descriprionLabel)
        descriprionLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 12).isActive = true
        descriprionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        descriprionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: descriprionLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        view.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        linkStackView.axis = .horizontal
        linkStackView.addArrangedSubview(linkLabel)
        linkStackView.addArrangedSubview(linkButton)
        linkStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(linkStackView)
        linkStackView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5).isActive = true
        linkStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        
        linkButton.addTarget(self, action: #selector(urlButtonClicked), for: .touchUpInside)
    
        presenter?.viewDidLoad()
        
    }
    
    @objc func urlButtonClicked() {
        guard let url = url else { return }
        presenter?.urlButtonClicked(url: url)
    }
    
}

extension DetailedNewsViewController: DetailedNewsViewProtocol {
    
    func showInfo(article: Article) {
        titleLabel.text = article.title
        titleImageView.image = UIImage(data: article.imageData)
        descriprionLabel.text = article.desc
        dateLabel.text = article.publishingTime
        authorLabel.text = "Written by " + (article.author ?? "Unnamed")
        linkLabel.text = "If you want to see the full version click "
        configureButtonLabel(text: "here")
        self.url = article.url
        
    }
    
    func configureButtonLabel(text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSRange(location: .zero, length: text.count)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
        linkButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: "Network Error", message: "No internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
