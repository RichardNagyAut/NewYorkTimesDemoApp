//
//  ArticleListTableViewCell.swift
//  NewYorkTimesDemo
//
//  Created by Richárd Nagy on 2017. 06. 29..
//  Copyright © 2017. com.autsoft. All rights reserved.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var article: ArticlePM? {
        didSet {
            guard let article = article else {
                return
            }
            if let title = article.title {
                self.titleLabel.text = title
            } else {
                self.titleLabel.text = ""
            }
            if let by = article.by {
                self.byLabel.text = by
            } else {
                self.byLabel.text = ""
            }
            if let imageURL = article.imageURL, let url = URL(string: imageURL) {
                do {
                    let data = try Data(contentsOf: url)
                    self.articleImage.image = UIImage(data: data)
                }
                catch {
                    self.articleImage.image = UIImage(named: "placeholder")
                }
            } else {
                self.articleImage.image = UIImage(named: "placeholder")
            }
            if let date = article.publishedDate {
                self.dateLabel.text = date
            } else {
                self.dateLabel.text = ""
            }
        }
    }
    
    
    override func layoutIfNeeded() {
        articleImage.layer.cornerRadius = 30
    }
}
