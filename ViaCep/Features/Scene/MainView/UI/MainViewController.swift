import UIKit

protocol MainViewControlling: AnyObject {
    func didPresentCep(_ cep: DataCep)
    func didShowErrorMessage(_ message: String)
    func didDisplayInvalidCepMessage(_ message: String)
    
    func didCreateUser(from email: String, password: String)
}

final class MainViewController: UIViewController {
    public enum Layout { }
    private let interactor: MainInteracting
    
    private lazy var stackViewContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
     lazy var inputedCepTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite um cep válido"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var searchCepButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar Cep", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didSearchCep), for: .touchUpInside)
        return button
    }()
    
    private lazy var logradouroLabel = makeLabel()
    private lazy var bairroLabel = makeLabel()
    private lazy var localidadeLabel = makeLabel()

    init(interactor: MainInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        pin()
        extraConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController {
    @objc
    private func didSearchCep() {
        searchCep()
    }
}

extension MainViewController: MainViewControlling {
    func didPresentCep(_ cep: DataCep) {
        didDisplayCep(cep)
    }
    
    func didShowErrorMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(
                title: "ALERT ⚠️",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "FECHAR",
                    style: .default)
            )
            
            didClearText()
            present(alert, animated: true)
        }
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(
                title: "ALERT ⚠️",
                message: "Este CEP não existe.",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(
                    title: "FECHAR",
                    style: .default)
            )
            self?.present(alert, animated: true)
        }
    }
}

extension MainViewController {
    func didClearText() {
        logradouroLabel.text = interactor.clearText()
        bairroLabel.text = interactor.clearText()
        localidadeLabel.text = interactor.clearText()
    }
    
    private func didDisplayCep(_ cep: DataCep) {
        DispatchQueue.main.async { [weak self] in
            self?.logradouroLabel.text = "Logradouro: \(cep.logradouro)"
            self?.bairroLabel.text = "Bairro: \(cep.bairro)"
            self?.localidadeLabel.text = "Localidade: \(cep.localidade)"
        }
    }
    
     func searchCep() {
         if let cep = inputedCepTextField.text {
             interactor.displayCep(cep)
             inputedCepTextField.text = interactor.clearText()
         }
    }
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: Layout.Size.constant)
        return label
    }
    
    func didCreateUser(from email: String, password: String) {
        interactor.createUser(from: email, password: password)
    }
}

extension MainViewController {
    private func buildViews() {
        stackViewContainer.addArrangedSubview(inputedCepTextField)
        stackViewContainer.addArrangedSubview(searchCepButton)
        
        stackViewContainer.addArrangedSubview(logradouroLabel)
        stackViewContainer.addArrangedSubview(bairroLabel)
        stackViewContainer.addArrangedSubview(localidadeLabel)
        
        view.addSubview(stackViewContainer)
    }
    
    private func pin() {
        NSLayoutConstraint.didActivePin([
            stackViewContainer.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Layout.Size.constant
            ),
            stackViewContainer.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: Layout.Size.constant
            ),
            stackViewContainer.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -Layout.Size.constant
            ),
            searchCepButton.heightAnchor.constraint(
                equalToConstant: Layout.Size.height
            )
        ])
    }
    
    func extraConfig() {
        view.backgroundColor = .systemBackground
    }
}

private extension MainViewController.Layout {
    enum Size {
        static let constant: CGFloat = 16
        static let height: CGFloat = 40
    }
}
