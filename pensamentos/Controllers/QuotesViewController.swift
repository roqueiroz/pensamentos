//
//  QuotesViewController.swift
//  pensamentos
//
//  Created by Rodrigo Queiroz on 06/08/20.
//  Copyright © 2020 Rodrigo Queiroz. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var imgAuthor: UIImageView!
    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var constraintLblQuoteTop: NSLayoutConstraint!
    
    //MARK: Variables
    let quotesManager = QuoteManager()
    var timer: Timer?
    let config = Configuration.shared
    let darkColor = UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
    let defaultLabelColor = UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: "RefreshSettings"),
            object: nil,
            queue: nil,
            using:  {
                (notification) in
                self.initialConfigView()
                
            }
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialConfigView()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
   
    //MARK: Functions
    func prepareQuote() {
        
        timer?.invalidate()
        
        if config.autoRefresh {
            
            timer = Timer.scheduledTimer(
                withTimeInterval: config.timeInterval,
                repeats: true,
                block: {
                    (timer) in
                    self.showQuote()
            })
        }
        
        showQuote()
    }
    
    func showQuote() {
        
        let quote = quotesManager.getRandomQuote()
        lblQuote.text = quote.quote
        lblAuthor.text = quote.author
        imgAuthor.image = UIImage(named: quote.image)
        imgBackGround.image = imgAuthor.image
        
        lblQuote.alpha = 0.0
        lblAuthor.alpha = 0.0
        imgAuthor.alpha = 0.0
        imgBackGround.alpha = 0.0
        
        constraintLblQuoteTop.constant = 50
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.lblQuote.alpha = 1.0
            self.lblAuthor.alpha = 1.0
            self.imgAuthor.alpha = 1.0
            self.imgBackGround.alpha = 0.25
            
            self.constraintLblQuoteTop.constant = 10
                   
            self.view.layoutIfNeeded()
        }
        
    }
    
    func initialConfigView() {
        
        view.backgroundColor = config.colorScheme == 0 ? .white : darkColor
        lblQuote.textColor = config.colorScheme == 0 ? .black : .white
        lblAuthor.textColor = config.colorScheme == 0 ? defaultLabelColor : .yellow
        
        prepareQuote()
        
    }

}
