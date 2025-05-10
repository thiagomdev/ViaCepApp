//
//  ServiceMock.swift
//  ViaCep
//
//  Created by Thiago Monteiro on 10/05/25.
//

@testable import ViaCep
final class ServiceMock: MainServicing {
    var expectedResponse: (Result<ViaCep.DataCep, Error>)?

    func fetchDataCep(
        _ cep: String,
        callback: @escaping (Result<ViaCep.DataCep, Error>) -> Void) {
        if let expectedResponse {
            callback(expectedResponse)
        }
    }
}
