import ViaCep

extension DataCep {
    static func fixture(
        cep: String = "0000-000",
        logradouro: String = "logradouro",
        bairro: String = "bairro",
        localidade: String = "localidade"
    ) -> Self {
        
        .init(
            cep: cep,
            logradouro: logradouro,
            bairro: bairro,
            localidade: localidade
        )
    }
}
