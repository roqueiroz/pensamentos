//
//  SettingsViewController.swift
//  pensamentos
//
//  Created by Rodrigo Queiroz on 06/08/20.
//  Copyright © 2020 Rodrigo Queiroz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var swAutoRefresh: UISwitch!
    @IBOutlet weak var lblTimerInterval: UILabel!
    @IBOutlet weak var sldTimerInterval: UISlider!
    @IBOutlet weak var sgCtrlColorScheme: UISegmentedControl!
    
    let config = Configuration.shared
    
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
    
    //MARK: Functions
    func initialConfigView() {
        swAutoRefresh.setOn(config.autoRefresh, animated: false)
        sldTimerInterval.setValue(Float(config.timeInterval), animated: false)
        sgCtrlColorScheme.selectedSegmentIndex = config.colorScheme
        
        changeLabelTimerInterval(with: config.timeInterval)
    }
    
    func changeLabelTimerInterval(with value: Double) {
        lblTimerInterval.text = "Mudar após \(Int(value)) segundos"
    }
    
    //MARK: Actions
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    @IBAction func changeTimerInverval(_ sender: UISlider) {
        
        let value = Double(round(sender.value))
        config.timeInterval = value
        changeLabelTimerInterval(with: value)
        
    }
    
    @IBAction func changeColorSchema(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
    
    
}
