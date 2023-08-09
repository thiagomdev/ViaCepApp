@testable import ViaCep

extension DataCep {
    static func fixture(
        cep: String = "01150011",
        logradouro: String = "Praça Marechal Deodoro",
        bairro: String = "Santa Cecília",
        localidade: String = "São Paulo"
    ) -> DataCep {
        
        DataCep(
            cep: cep,
            logradouro: logradouro,
            bairro: bairro,
            localidade: localidade
        )
    }
}
