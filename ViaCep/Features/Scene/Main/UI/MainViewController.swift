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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showAlert() {
        main.alert = { [weak self] message in
            let alert = UIAlertController(title: "Hey there!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "FECHAR", style: .default))
            self?.present(alert, animated: true)
        }
    }
}
