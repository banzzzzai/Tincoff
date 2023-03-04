//
//  CoreDataManager.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Public
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveArticlesToCoreData(articles: [ArticleModel]) {
        let context = persistentContainer.viewContext
        for article in articles {
            var flag = 0
            do {
                let results = try context.fetch(Article.fetchRequest())
                for result in results {
                    if result.url == article.url {
                        flag = 1
                        break
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
            if flag == 0 {
                let articleObject = Article(context: context)
                articleObject.author = article.author
                articleObject.title = article.title
                articleObject.url = article.url
                articleObject.desc = article.description
                articleObject.content = article.content
                articleObject.publishingTime = article.publishedAt
                articleObject.viewsCount = 0
                NetworkManager.shared.loadImage(with: article.urlToImage) { binaryDataImage in
                    articleObject.imageData = binaryDataImage
                }
                saveContext()
            }
        }
    }
    
    func fetchAllArticles(completion: @escaping ([Article]) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = Article.fetchRequest()
        do {
            let articles = try context.fetch(fetchRequest)
            let sortedArticles = articles.sorted { $0.publishingTime > $1.publishingTime }
            completion(sortedArticles)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateViewsCounter(with url: String) {
        let context = persistentContainer.viewContext
        do {
            let results = try context.fetch(Article.fetchRequest())
            for result in results {
                if result.url == url {
                    result.setValue(result.viewsCount + 1, forKey: "viewsCount")
                    saveContext()
                    return
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
