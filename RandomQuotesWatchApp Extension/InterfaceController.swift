//
//  InterfaceController.swift
//  RandomQuotesWatchApp Extension
//
//  Created by Dongwoo Pae on 12/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import WatchKit
import Foundation
import UIKit

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    
    let fetcher = RandomQuoteFetcher()
    
    var quote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //self.label.setText("hello thereasdfasdfasdfasdfasdfdfsdfasdfasdfasdfsadfsdfa")
        
    }
    
    @IBAction func buttonTapped() {
        fetcher.fetchQuotes(count: 1) { (data, error) in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.quote = data
                }
            }
        }
    }
    
    private func updateViews() {
        guard let quote = quote else {return}
        self.label.setText(quote.quote)
        self.authorLabel.setText("-\(quote.author)")
    }
}
