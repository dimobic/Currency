//
//  conController.swift
//  Currency
//
//  Created by Dima Chirukhin on 16.08.2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import UIKit

class conController: UIViewController {

    @IBOutlet weak var TextToOutlet: UITextField!
    @IBOutlet weak var TextFromOutlet: UITextField!
    @IBOutlet weak var dste: UILabel!
    @IBOutlet weak var butto: UIButton!
    @IBOutlet weak var burfrom: UIButton!
    
    @IBAction func from(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(identifier: "sel") as! UINavigationController
        (nc.viewControllers[0] as! TableViewController).flagcur = .from
        present(nc,animated: true, completion: nil)
        viewWillAppear(false)
        }
    
    @IBAction func to(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(identifier: "sel") as! UINavigationController
        (nc.viewControllers[0] as! TableViewController).flagcur = .to
        present(nc,animated: true, completion: nil)
        //viewWillAppear(false)
        }
    
    
    @IBOutlet weak var ButDoneOut: UIBarButtonItem!
    @IBAction func DoneBut(_ sender: Any) {
        TextFromOutlet.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    @IBAction func TextFromChan(_ sender: Any) {
        let amount = Double(TextFromOutlet.text!)
        TextToOutlet.text = model.shared.convert(amount: amount)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TextFromOutlet.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        TextFromChan(self)
        dste.text = "Курсы за дату: \(model.shared.curdata)"
        navigationItem.rightBarButtonItem = nil
        refresh()
    }
    
    func refresh()  {
        burfrom.setTitle(model.shared.from.CharCode, for: UIControl.State.normal)
        butto.setTitle(model.shared.to.CharCode, for: UIControl.State.normal)   }
}


extension conController: UITextFieldDelegate {
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
            navigationItem.rightBarButtonItem = ButDoneOut
            return true
        }
    
    }

