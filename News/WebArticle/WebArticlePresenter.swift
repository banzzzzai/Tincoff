//
//  WebArticlePresenter.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation

protocol WebArticlePresenterProtocol: AnyObject {
    func viewDidLoad()
    func requestAccepted(urlRequest: URLRequest)
}

class WebArticlePresenter {
    weak var view: WebArticleViewProtocol?
    var router: WebArticleRouterProtocol?
    var interactor: WebArticleInteractorProtocol?
    
    init(router: WebArticleRouterProtocol, interactor: WebArticleInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension WebArticlePresenter: WebArticlePresenterProtocol {

    func viewDidLoad() {
        interactor?.createRequest()
    }
    
    func requestAccepted(urlRequest: URLRequest) {
        view?.openWebPage(urlRequest: urlRequest)
    }
    
}
