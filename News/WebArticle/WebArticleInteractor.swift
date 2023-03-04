//
//  WebArticleInteractor.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol WebArticleInteractorProtocol: AnyObject {
    func createRequest()
}

class WebArticleInteractor: WebArticleInteractorProtocol {
    weak var presenter: WebArticlePresenterProtocol?
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
}

extension WebArticleInteractor {
    
    func createRequest() {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        presenter?.requestAccepted(urlRequest: request)
    }
    
}
