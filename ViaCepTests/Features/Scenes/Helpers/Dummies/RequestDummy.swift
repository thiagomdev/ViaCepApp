//
//  RequestDummy.swift
//  ViaCep
//
//  Created by Thiago Monteiro on 08/02/25.
//

import Foundation
@testable import ViaCep

final class RequestDummy: Request {
    var endpoint: String = ""
    
    var method: ViaCep.HttpMethod = .get
    
    var parameters: [String : String]?
    
    var headers: [String : String]?
    
    var body: Data?
}
