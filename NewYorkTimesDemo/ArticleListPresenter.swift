import UIKit

class ArticleListPresenter: ArticleListPresenterInput {
    var view: ArticleListView?
    var interactor: ArticleListInteractorInput!
    
    func getMostPopularArticles() {
        interactor.fetchMostPopularArticles {[view] (success, articles) in
            if success {
                var articlePMs = [ArticlePM]()
                for article in articles {
                    articlePMs.append(ArticlePM(model: article))
                }
                view?.showArticles(articles: articlePMs)
            } else {
                view?.showError(message: "Error")
            }
        }
    }
    
}
