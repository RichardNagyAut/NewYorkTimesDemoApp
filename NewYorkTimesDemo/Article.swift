import UIKit

class Article: NSObject {
    var imageURL: String?
    var publishedDate: Date?
    var title: String?
    var id: Int64?
    var by: String?
    var url: String?
    
    init(dto: ArticleDTO) {
        self.imageURL = dto.imageURL
        self.id = dto.id
        self.by = dto.by
        self.title = dto.title
        self.url = url
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dto.publishedDate {
            self.publishedDate = dateFormatter.date(from: date)
        }
    }
}
