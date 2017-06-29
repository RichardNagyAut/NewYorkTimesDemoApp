import Foundation

protocol ArticleListView: class {
    var presenter: ArticleListPresenterInput! {get set}
    
    func showArticles(articles: [ArticlePM])
    func showError(message: String)
}
