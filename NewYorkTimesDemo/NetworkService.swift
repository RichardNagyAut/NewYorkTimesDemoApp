//
//  NetworkService.swift
//  NewYorkTimesDemo
//
//  Created by Richárd Nagy on 2017. 06. 29..
//  Copyright © 2017. com.autsoft. All rights reserved.
//

import Foundation

typealias fetchSuccess = ([ArticleDTO]) -> ()
typealias fetchFailure = (Error?) -> ()

class NetworkService: NSObject {
    
    func fetchMostPopularArticles(successHandler: fetchSuccess?, failure: fetchFailure?) {
        let session = URLSession.shared
        guard let url = URL(string: NetworkConstants.baseURL.appending("mostpopular/v2/mostviewed/all-sections/7.json").appending(NetworkConstants.apiKey) ) else { return }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                failure?(error)
                return
            }
            if let resp = response as? HTTPURLResponse, resp.statusCode != 200 {
                failure?(error)
            }
            guard let data = data else { return }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                guard let dict = parsedData as? NSDictionary else {
                    failure?(nil)
                    return
                }
                var articles = [ArticleDTO]()
                if let articlesArray = dict["results"] as? NSArray {
                    for articleDic in articlesArray {
                        var article = ArticleDTO()
                        if let articleDic = articleDic as? NSDictionary {
                            article.by = articleDic.value(forKey: "byline") as? String
                            article.title = articleDic.value(forKey: "title") as? String
                            article.publishedDate = articleDic.value(forKey: "published_date") as? String
                            article.id = articleDic.value(forKey: "id") as? Int64
                            article.url = articleDic.value(forKey: "url") as? String
                            if let media = articleDic.value(forKey: "media") as? NSArray {
                                for mediaItem in media {
                                    if let mediaItem = mediaItem as? NSDictionary {
                                        guard let type = mediaItem.value(forKey: "type") as? String,
                                            let subtype = mediaItem.value(forKey: "subtype") as? String,
                                            let mediameta = mediaItem.value(forKey: "media-metadata") as? NSArray,
                                            subtype == "photo",
                                            type == "image"
                                            else {
                                                continue
                                        }
                                        for metaData in mediameta {
                                            if let metaData = metaData as? NSDictionary,
                                                let format = metaData.value(forKey: "format") as? String,
                                                format == "Standard Thumbnail" {
                                                article.imageURL = metaData.value(forKey: "url") as? String
                                                break
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        articles.append(article)
                    }
                }
                
                successHandler?(articles)
            }
                //else throw an error detailing what went wrong
            catch let error as NSError {
                failure?(error)
            }
            
        }
        dataTask.resume()
    }
    
}
