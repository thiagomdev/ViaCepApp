//
//  MainViewControllerSpy.swift
//  ViaCep
//
//  Created by Thiago Monteiro on 10/05/25.
//

import Foundation
@testable import ViaCep
final class MainViewControllerSpy: MainViewProtocol {
    enum Message: Hashable {
        case didShowCep(_ cep: ViaCep.DataCep)
        case didShowError(_ message: String)
    }
    
    private(set) var messages = [Message]()
        
    func didPresentCep(_ cep: ViaCep.DataCep) {
        messages.append(.didShowCep(cep))
    }
    
    func didShowErrorMessage(_ message: String) {
        messages.append(.didShowError(message))
    }
}
