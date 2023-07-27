@testable import ViaCep

extension DataCep {
    static func fixture(
        cep: String = "",
        logradouro: String = "",
        bairro: String = "",
        localidade: String = ""
    ) -> DataCep {
        
        DataCep(
            cep: cep,
            logradouro: logradouro,
            bairro: bairro,
            localidade: localidade
        )
    }
}
