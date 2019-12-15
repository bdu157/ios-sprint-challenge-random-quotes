//
//  MainViewController.swift
//  RandomQuotes
//
//  Created by Dongwoo Pae on 12/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var quoteTextView: UITextView!
    
    let randomQuoteFetcher = RandomQuoteFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    var quote: Quote? {
        didSet {
            updateViews()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonTapped(_ sender: Any) {
        randomQuoteFetcher.fetchQuotes(count: 1) { (data, error) in
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
        guard let quote = quote, isViewLoaded else {return}
        self.quoteTextView.text = quote.quote
    }
}
