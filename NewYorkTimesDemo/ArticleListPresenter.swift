import UIKit

class ArticleListPresenter: ArticleListPresenterInput {
    var view: ArticleListView?
    var interactor: ArticleListInteractorInput!
    var coordinator: AppCoordinator!
    
    init(coordinator:AppCoordinator!) {
        self.coordinator = coordinator
    }
    
    func getMostPopularArticles() {
        interactor.fetchMostPopularArticles {[view] (success, articles) in
            if success {
                var articlePMs = [ArticlePM]()
                for article in articles {
                    articlePMs.append(ArticlePM(model: article))
                }
                view?.showArticles(articles: articlePMs)
            } else {
                view?.showError(message: NSLocalizedString("error_text_something_went_wrong", comment: ""))
            }
        }
    }
    
    func showContentForArticle(id: Int64) {
        guard let articles = interactor.getArticles() else {
            return
        }
        for article in articles {
            if let aId = article.id, aId == id, let url = article.url {
                coordinator.showSafariController(uri: url)
                break
            }
        }
    }
}
