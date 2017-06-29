import Foundation
import UIKit

/// Root coordinator managing the window and it's child coordinators
class AppCoordinator {
    
    private var window: UIWindow
    private var rootViewController: UINavigationController!
    
    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
        rootViewController = UINavigationController()
        window.rootViewController = rootViewController
    }
    
    /// Init the application's first viewcontroller
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateInitialViewController() as? ArticleListViewController! {
            vc.presenter = ArticleListPresenter()
            vc.presenter.interactor = ArticleListInteractor()
            vc.presenter.view  = vc
            self.rootViewController.setViewControllers([vc], animated: true)
        }
    }
}
