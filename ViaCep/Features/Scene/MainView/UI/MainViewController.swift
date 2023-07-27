import UIKit

protocol MainViewControlling: AnyObject {
    func didShowCep(_ cep: DataCep)
}

final class MainViewController: UIViewController {
    
    private let interactor: MainInteracting
    
    private lazy var stackViewContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var inputedCepTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite um cep válido"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc
    private func didSearchCep() {
        guard let cep = inputedCepTextField.text else { return }
        interactor.showCep(cep)
        inputedCepTextField.text = interactor.clearText()
    }
}

extension MainViewController: MainViewControlling {
    func didShowCep(_ cep: DataCep) {
        DispatchQueue.main.async {
            self.logradouroLabel.text = "Logradouro: \(cep.logradouro)"
            self.bairroLabel.text = "Bairro: \(cep.bairro)"
            self.localidadeLabel.text = "Localidade: \(cep.localidade)"
        }
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
        NSLayoutConstraint.activate([
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
            )
        ])
    }
    
    func extraConfig() {
        view.backgroundColor = .systemBackground
    }
}

extension MainViewController {
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
