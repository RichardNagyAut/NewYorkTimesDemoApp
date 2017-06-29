import UIKit

class ArticleListViewController: UIViewController, ArticleListView {
    var presenter: ArticleListPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showArticles(articles: [ArticlePM]) {
        
    }

}
