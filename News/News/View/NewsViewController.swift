//
//  ViewController.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit

protocol NewsViewProtocol: AnyObject {
    func showArticles(articles: [Article])
    func showNoInternetAlert()
}

class NewsViewController: UIViewController {

    var presenter: NewsPresenterProtocol?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Private properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()

    private var articles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    private let refreshControl = UIRefreshControl()

}

//MARK: - Private methods
private extension NewsViewController {

    func initialize() {
        view.backgroundColor = .systemBackground
        addImageToNavBar()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)

        refreshControl.addTarget(self, action: #selector(refreshArticles(sender:)), for: .valueChanged)
    }

    func addImageToNavBar() {
        if let navController = navigationController {
            let imageLogo = UIImage(named: "newsLogo")

            let widthNavBar = navController.navigationBar.frame.width
            let heightNavBar = navController.navigationBar.frame.height

            let viewWidth = widthNavBar * 0.4
            let viewHeight = heightNavBar * 0.9

            let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
            imageView.image = imageLogo
            imageView.contentMode = .scaleAspectFit
            logoContainer.addSubview(imageView)

            navigationItem.titleView = logoContainer
        }
    }

    @objc func refreshArticles(sender: UIRefreshControl) {
        presenter?.tableViewStartedLoadingNewData()
    }

    func createSpinnerFooter() -> UIView {

        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()

        return footerView

    }

}

// MARK: - TableView setup
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.configure(with: articles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        presenter?.didTapOnCell(with: article)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

}

// MARK: - UIScrollView setup
extension NewsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 50 - scrollView.frame.size.height {
            // fetch more data
            let nextRequiredPageNumber = Int(tableView.contentSize.height / 100) / 10 + 1
            if self.articles.count > 0 {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = self.createSpinnerFooter()
                }
                presenter?.fetchMoreData(page: nextRequiredPageNumber) {
                    DispatchQueue.main.async {
                        self.tableView.tableFooterView = nil
                    }
                }
            }
        }
    }
}

extension NewsViewController: NewsViewProtocol {
    func showArticles(articles: [Article]) {
        self.articles = articles
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: "Network Error", message: "No internet connection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.async {
            self.tableView.tableFooterView = nil
        }
        refreshControl.endRefreshing()
        
    }

}
