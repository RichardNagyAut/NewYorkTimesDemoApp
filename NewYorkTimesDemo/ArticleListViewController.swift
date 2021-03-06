import UIKit

class ArticleListViewController: UIViewController, ArticleListView {
    var presenter: ArticleListPresenterInput!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIView!
    
    fileprivate var articles = [ArticlePM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView properties
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshButtonTouchUpInside), for: .valueChanged)
        
        self.loadingIndicator.isHidden = false
        self.navigationItem.title = NSLocalizedString("articleListTitle", comment: "")
        self.presenter.getMostPopularArticles()
    }

    func showArticles(articles: [ArticlePM]) {
        self.articles = articles
        DispatchQueue.main.async { [weak tableView = self.tableView, loadingIndicator = self.loadingIndicator] in
            if let tableView = tableView {
                tableView.reloadData()
            }
            if let loadingIndicator = loadingIndicator {
                loadingIndicator.isHidden = true
            }
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = true
        }
        
        let alert = UIAlertController(title: NSLocalizedString("error_title", comment: ""), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("error_ok_button_title", comment: ""), style: .cancel)
        let refreshAction = UIAlertAction(title: NSLocalizedString("error_refresh", comment: ""), style: .default) {[weak self, loadingIndicator = self.loadingIndicator] (_) in
            if let loadingIndicator = loadingIndicator {
                DispatchQueue.main.async {
                    loadingIndicator.isHidden = false
                }
                if let strongSelf = self {
                    strongSelf.presenter.getMostPopularArticles()
                }
            }
        }
        alert.addAction(okAction)
        alert.addAction(refreshAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonTouchUpInside(_ sender: Any) {
        self.tableView.refreshControl?.endRefreshing()
        self.loadingIndicator.isHidden = false
        self.presenter.getMostPopularArticles()
    }
}


extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        if let id = articles[indexPath.row].id {
            presenter.showContentForArticle(id: id)
        }
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
