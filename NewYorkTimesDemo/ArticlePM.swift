import Foundation
import UIKit

// Article presentation model
struct ArticlePM {
    var imageURL: String?
    var publishedDate: String?
    var title: String?
    var id: Int64?
    var by: String?
    
    init(model: Article) {
        self.imageURL = model.imageURL
        self.title = model.title
        self.by = model.by
        self.id = model.id
        if let date = model.publishedDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            self.publishedDate = formatter.string(from: date)
        }
    }
}
