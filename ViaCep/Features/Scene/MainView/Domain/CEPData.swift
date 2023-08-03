import Foundation

struct CEPData: Codable, Equatable {
    var cep: String
    var logradouro: String
    var bairro: String
    var localidade: String
}
