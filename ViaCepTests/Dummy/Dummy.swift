import ViaCep

extension DataCep {
    static func dummy(
        cep: String = "01150011",
        logradouro: String = "Praça Marechal Deodoro",
        bairro: String = "Santa Cecília",
        localidade: String = "São Paulo"
    ) -> Self {
        
        .init(
            cep: cep,
            logradouro: logradouro,
            bairro: bairro,
            localidade: localidade
        )
    }
}
