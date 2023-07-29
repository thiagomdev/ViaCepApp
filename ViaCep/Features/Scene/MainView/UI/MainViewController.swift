import UIKit

// MARK: - MainViewControlling / Protocol
protocol MainViewControlling: AnyObject {
    func didShowCep(_ cep: DataCep)
    func didShowError(_ message: String)
    func didDisplayInvalidCepMessage(_ message: String)
}

final class MainViewController: UIViewController {
    // MARK: - Properties
    private let interactor: MainInteracting
    
    // MARK: - Components
    private lazy var stackViewContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var inputedCepTextField: UITextField = {
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didSearchCep), for: .touchUpInside)
        return button
    }()
    
    private lazy var logradouroLabel = makeLabel()
    private lazy var bairroLabel = makeLabel()
    private lazy var localidadeLabel = makeLabel()

    // MARK: - Initializers
    init(interactor: MainInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cycle
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

// MARK: - Selector Methods
extension MainViewController {
    @objc
    private func didSearchCep() {
        guard let cep = inputedCepTextField.text else { return }
        interactor.showCep(cep)
        inputedCepTextField.text = interactor.clearText()
    }
}

// MARK: - MainViewControlling / Protocol
extension MainViewController: MainViewControlling {
    func didShowCep(_ cep: DataCep) {
        DispatchQueue.main.async { [weak self] in
            self?.logradouroLabel.text = "Logradouro: \(cep.logradouro)"
            self?.bairroLabel.text = "Bairro: \(cep.bairro)"
            self?.localidadeLabel.text = "Localidade: \(cep.localidade)"
        }
    }
    
    func didShowError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "ALERT ⚠️", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "FECHAR", style: .default))
            
            self?.logradouroLabel.text = self?.interactor.clearText()
            self?.bairroLabel.text = self?.interactor.clearText()
            self?.localidadeLabel.text = self?.interactor.clearText()
            
            self?.present(alert, animated: true)
        }
    }
    
    func didDisplayInvalidCepMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "ALERT ⚠️", message: "Este CEP não existe.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "FECHAR", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - MainViewController / ViewConfiguration
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
                constant: 16
            ),
            stackViewContainer.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            stackViewContainer.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            searchCepButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func extraConfig() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - MainViewController / Created UILabel
extension MainViewController {
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }
}
