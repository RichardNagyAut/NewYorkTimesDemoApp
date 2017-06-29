import Foundation

typealias mostPopularCompletionHandler = (Bool, [Article]) -> ()

protocol ArticleListInteractorInput {
    func fetchMostPopularArticles(completionHandler:mostPopularCompletionHandler?)
}
