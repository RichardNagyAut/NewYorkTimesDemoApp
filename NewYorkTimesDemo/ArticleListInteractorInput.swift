import Foundation

typealias mostPopularCompletionHandler = (success: Bool, [Article])

protocol ArticleListInteractorInput {
    func getMostPopularArticles(completionHandler:mostPopularCompletionHandler)
}
