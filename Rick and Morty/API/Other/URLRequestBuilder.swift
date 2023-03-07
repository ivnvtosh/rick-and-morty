//
//  RequestCharactersBuilder.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 02.03.2023.
//

import UIKit

class URLRequestBuilder {
	
    var base: String
    
    var path: String
    
    var method: HTTPMethod = .get
    
    var headers: [String: Any]?
    
    init(base: String, path: String) {
        
        self.base = base
        self.path = path
    }
    
    func set(path: String) -> Self {
        
        self.path = path
        
        return self
    }
    
    func set(method: HTTPMethod) -> Self {
        
        self.method = method
        
        return self
    }
    
    // FIXME: Нужно?
    @discardableResult
    func set(headers: [String: Any]) -> Self {
        
        self.headers = headers
        
        return self
    }
    
    func build() throws -> URLRequest {
				
		guard let base = URL(string: base) else {
			
			throw RickAndMortyError.invalidBase
		}
		
		guard let url = URL(string: path, relativeTo: base) else {
			
			throw RickAndMortyError.invalidPath
		}
		
		guard UIApplication.shared.canOpenURL(url) else {
			
			throw RickAndMortyError.canNotOpenURL
		}
        
		var request = URLRequest(url: url,
								 cachePolicy: .returnCacheDataElseLoad,
								 timeoutInterval: 10)
		
        request.httpMethod = method.rawValue
        
        headers?.forEach { request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
		return request
	}
}
