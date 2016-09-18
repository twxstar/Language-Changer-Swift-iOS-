//
//  ViewController.swift
//  LanguageChangerSwift
//
//  Created by Harish-Uz-Jaman Mridha Raju on 9/17/16.
//  Copyright © 2016 Raju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var localePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.flagImageView.contentMode = .ScaleAspectFit
        let languageManager = LanguageManager.sharedLanguageManager()
        var selectedIndex = 0
        let selectedLocale = languageManager.getSelectedLocale()
        selectedIndex = languageManager.availableLocales.indexOf(selectedLocale)!
        // Move the picker to match what was selected previously.
        self.localePicker.selectRow(selectedIndex, inComponent: 0, animated: true)
        self.setupLocalisableElements()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Scroll back to the top of the text.
        self.textView.contentOffset = CGPointZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setupLocalisableElements() {
        
        self.title = Localised("Title")
        self.textView.text = Localised("Text")
        self.textView.contentOffset = CGPointZero
        // Flag images are named after the country code of the Localisation.
        let flagImage = UIImage(named: LanguageManager.sharedLanguageManager().getSelectedLocale().countryCode!)!
        self.flagImageView.image = flagImage
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageManager.sharedLanguageManager().availableLocales.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        let localeForRow = LanguageManager.sharedLanguageManager().availableLocales[row]
        return localeForRow.name!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let languageManager = LanguageManager.sharedLanguageManager()
        let localeForRow = languageManager.availableLocales[row]
        print("Language selected: \(localeForRow.name)")
        languageManager.setLanguageWithLocale(localeForRow)
        self.setupLocalisableElements()
    }
}

