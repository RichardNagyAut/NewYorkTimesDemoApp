import Foundation

protocol ArticleListPresenterInput{
    weak var view: ArticleListView? {get set}
    
    var interactor: ArticleListInteractorInput! {get set}

    func getMostPopularArticles()
}
