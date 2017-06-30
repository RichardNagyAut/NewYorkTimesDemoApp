class ArticleListInteractor: ArticleListInteractorInput {
    
    var articles: [Article]?
    
    func fetchMostPopularArticles(completionHandler:mostPopularCompletionHandler?) {
        NetworkService().fetchMostPopularArticles(successHandler: { (array) in
            print(array)
            var articles = [Article]()
            for item in array {
                articles.append(Article(dto: item))
            }
            self.articles = articles
            completionHandler?(true, articles)
        }) { (error) in
            completionHandler?(false,[Article]())
        }
    }
    
    func getArticles() -> [Article]? {
        return articles
    }
}
