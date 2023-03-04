//
//  WebArticleViewController.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit
import WebKit

protocol WebArticleViewProtocol: AnyObject {
    func openWebPage(urlRequest: URLRequest)
}

class WebArticleViewController: UIViewController {
    
    var presenter: WebArticlePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private let webView = WKWebView()
    
}

private extension WebArticleViewController {
    
    func initialize() {
        view.addSubview(webView)
        webView.frame = view.bounds
        
        presenter?.viewDidLoad()
    }
    
}

extension WebArticleViewController: WebArticleViewProtocol {
    
    func openWebPage(urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
    
}
