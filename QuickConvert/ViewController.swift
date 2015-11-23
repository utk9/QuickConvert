//
//  ViewController.swift
//  QuickConvert
//
//  Created by Utkarsh Lamba on 2015-11-20.
//  Copyright © 2015 Utkarsh Lamba. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var toPicker: UIPickerView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var numInputView: UITextField!
    
    var fromCurrency: String = "CAD"
    var toCurrency: String = "USD"
    var rate: Double = 1
        

    var pickerData: [String] = [String]()
    var toPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.toPicker.delegate = self
        self.toPicker.dataSource = self
        

        
        pickerData = ["CAD", "USD", "GBP", "AUD"]
        toPickerData = ["CAD", "USD", "GBP", "AUD"]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker {
            return pickerData.count
            //return 3;
        }
        else {
            return toPickerData.count

        }
        
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == picker {
            fromCurrency = pickerData[row]
            return pickerData[row]
        }
        else {
            
            toCurrency = toPickerData[row]
            return toPickerData[row]
            
        }


        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        numInputView.endEditing(true)
        numInputView.resignFirstResponder()
    }

    
//    @IBAction func convertCurrency(){
//        if numInputView.text == "" {
//            let alert = UIAlertController(title: "Blank field",
//                message: "Please enter in value to convert.", preferredStyle: .Alert)
//            let action = UIAlertAction(title: "Awesome", style: .Default, handler: nil)
//            alert.addAction(action)
//            presentViewController(alert, animated: true, completion: nil)
//        }
//        else {
//            
//        
//        
//        if fromCurrency == toCurrency {
//            rate = 1
//        }
//        else {
//            let endpoint = NSURL(string: "https://api.fixer.io/latest?symbols=\(toCurrency)&base=\(fromCurrency)")
//
//            var data = NSData(contentsOfURL: endpoint!)
//            
//            do{
//                if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                    if let items = json["rates"] as? [String:AnyObject] {
//                        if let toCurrencyTemp = items[self.toCurrency] as? Double{
//                            self.rate = toCurrencyTemp
//                        }
//                    }
//                }
//            }
//            catch {}
//            
//        }
//        
//        resultLabel.text = String((rate) * Double(numInputView.text!)!)
//        
//    }
//    
//    }
    
    @IBAction func convertCurrency(){

        
                let endpoint = NSURL(string: "https://api.fixer.io/latest?symbols=\(toCurrency)&base=\(fromCurrency)")
                
                var data = NSData(contentsOfURL: endpoint!)
                
                do{
                    if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        if let items = json["rates"] as? [String:AnyObject] {
                            if let toCurrencyTemp = items[self.toCurrency] as? Double{
                                self.rate = toCurrencyTemp
                            }
                        }
                    }
                }
                catch {}
        
            
            resultLabel.text = String((rate) * Double(numInputView.text!)!)
    }
    



}

