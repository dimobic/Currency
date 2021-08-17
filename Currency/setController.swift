//
//  setController.swift
//  Currency
//
//  Created by Dima Chirukhin on 15.08.2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import UIKit

class setController: UIViewController {
    @IBOutlet weak var datepick: UIDatePicker!
    @IBAction func can(_ sender: Any) {
        dismiss(animated: true, completion: nil)}
    @IBAction func show(_ sender: Any) {
        Currency.model.shared.LoadXML(data: datepick.date)
        dismiss(animated: true, completion: nil)}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
