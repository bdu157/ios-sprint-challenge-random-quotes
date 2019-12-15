//
//  TodayViewController.swift
//  RandomQuotesWidget
//
//  Created by Dongwoo Pae on 12/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var textView: UITextView!
    
    
    let randomQuoteFetcher = RandomQuoteFetcher()
    
    var quote: Quote? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomQuoteFetcher.fetchQuotes(count: 1) { (data, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else {return}

            DispatchQueue.main.async {
                 self.quote = data
            }
        }
    }
    
    private func updateViews() {
        guard let quote = quote else {return}
        self.textView.text = quote.quote
    }
    
    

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

