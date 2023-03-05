//
//  RequestCharactersBuilder.swift
//  Rick and Morty
//
//  Created by Anton Ivanov on 02.03.2023.
//

import UIKit

class RequestCharactersBuilder {
	
	static func build() throws -> URLRequest {
		
		let base = "https://rickandmortyapi.com"
		
		let path = "/api/" + "character"
		
		let method = "GET"
		
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
		
		request.httpMethod = method
		
		return request
	}
}
