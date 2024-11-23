import UIKit

public final class MainViewController: UIViewController {
    private let main: MainView
    
    init(_ main: MainView) {
        self.main = main
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func loadView() {
        super.loadView()
        view = main
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
