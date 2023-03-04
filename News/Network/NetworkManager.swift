//
//  NetworkManager.swift
//  News
//
//  Created by Афанасьев Александр Иванович on 05.02.2023.
//

import UIKit
import SystemConfiguration

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var isFetching = false
    
    func getNews(page: Int = 1, completion: @escaping () -> ()) {
        isFetching = true
        let urlString = "https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&language=en&pageSize=10&page=\(page)&apiKey=f6783a5612064d0398c6233144748a80"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let newsData = try? JSONDecoder().decode(TeslaNews.self, from: data) {
                CoreDataManager.shared.saveArticlesToCoreData(articles: newsData.articles)
                completion()
                self.isFetching = false
            } else {
                print("failed decoding")
            }
        }.resume()
    }
    
    func loadImage(with url: String?, completion: @escaping (Data) -> Void)  {
        var image: UIImage
        
        guard let url = url else {
            image = UIImage(named: "newsDefaultPic")!
            completion(convertImageToData(image: image))
            return
        }
        
        if let url = URL(string: url) {
            do {
                let data = try Data(contentsOf: url)
                image = UIImage(data: data) ?? UIImage(named: "newsDefaultPic")!
                completion(convertImageToData(image: image))
            } catch {
                print("Error = ", error.localizedDescription)
                image = UIImage(named: "newsDefaultPic")!
                completion(convertImageToData(image: image))
            }
        }
    }
    
    func convertImageToData(image: UIImage) -> Data {
        return image.jpegData(compressionQuality: 1)!
    }
    
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
        
    }
    
}
