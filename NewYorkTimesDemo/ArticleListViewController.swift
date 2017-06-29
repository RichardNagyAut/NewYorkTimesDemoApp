import UIKit

class ArticleListViewController: UIViewController, ArticleListView {
    var presenter: ArticleListPresenterInput!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var articles = [ArticlePM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView properties
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.title = NSLocalizedString("articleListTitle", comment: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        self.presenter.getMostPopularArticles()
    }
    
    func showArticles(articles: [ArticlePM]) {
        self.articles = articles
        DispatchQueue.main.async { [weak tableView = self.tableView] in
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    
    func showError(message: String) {
        // TODO: show error message
    }
    
}


extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ArticleListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleListTableViewCell! {
            cell.article = articles[indexPath.row]
            return cell
        }
        // Can't degueue cell
        return UITableViewCell()
    }
}
