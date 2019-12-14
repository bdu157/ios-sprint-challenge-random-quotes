//
//  RandomQuoteFetcher.swift
//  RandomQuotes
//
//  Created by Dongwoo Pae on 12/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

//https://andruxnet-random-famous-quotes.p.rapidapi.com?cat=famous&count=1
//setValue header
//addValue - "x-rapidapi-key": "f0ad5ef351mshc6c5fd3b7d66f5fp16cc14jsn11efc4d5eb08"



class RandomQuoteFetcher {
    
    //var quotes: [Quote] = []
    
    var baseUrl = URL(string: "https://andruxnet-random-famous-quotes.p.rapidapi.com")!
    
    let apiKey = "f0ad5ef351mshc6c5fd3b7d66f5fp16cc14jsn11efc4d5eb08"
    
    func fetchQuotes(count: Int, completion: @escaping (Quote?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        let catQueryItem = URLQueryItem(name: "cat", value: "famous")
        let countQueryItem = URLQueryItem(name: "count", value: "\(count)")
        urlComponents?.queryItems = [catQueryItem, countQueryItem]
        
        let url = urlComponents?.url
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("andruxnet-random-famous-quotes.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue("f0ad5ef351mshc6c5fd3b7d66f5fp16cc14jsn11efc4d5eb08", forHTTPHeaderField: "x-rapidapi-key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(nil, error)
                return
            }
            
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let quotes = try jsonDecoder.decode([Quote].self, from: data)
                //self.quotes = quotes
                print(quotes[0])
                completion(quotes[0],nil)
            } catch {
                NSLog("Error decoding animal objects: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    
}
