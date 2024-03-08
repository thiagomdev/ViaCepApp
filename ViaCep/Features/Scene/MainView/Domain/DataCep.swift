import Foundation

struct DataCep: Codable, Hashable {
    var cep: String
    var logradouro: String
    var bairro: String
    var localidade: String
}
