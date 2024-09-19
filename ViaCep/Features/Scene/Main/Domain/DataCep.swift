import Foundation

public struct DataCep: Codable, Hashable, Equatable {
    public var cep: String
    public var logradouro: String
    public var bairro: String
    public var localidade: String
    
    public init(
        cep: String,
        logradouro: String,
        bairro: String,
        localidade: String) {
            
        self.cep = cep
        self.logradouro = logradouro
        self.bairro = bairro
        self.localidade = localidade
    }
}
