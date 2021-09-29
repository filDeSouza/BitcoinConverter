//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {


    @IBOutlet weak var labelValor: UILabel!
    @IBOutlet weak var labelNomeMoeda: UILabel!
    @IBOutlet weak var moedasPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moedasPicker.dataSource = self
        moedasPicker.delegate = self
        
        coinManager.delegate = self
    }

}

extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        coinManager.currencyArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
        
    }
    
}

extension CoinViewController: CoinManagerDelegate{
    
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.labelValor.text = String(format: "%.2f", coin.currentRate)
            self.labelNomeMoeda.text = coin.id
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
