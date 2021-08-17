//
//  CurController.swift
//  Currency
//
//  Created by Dima Chirukhin on 13.08.2020.
//  Copyright © 2020 Dima Chirukhin. All rights reserved.
//

import UIKit

class CurController: UITableViewController {

    
    @IBAction func ref(_ sender: Any) {
        model.shared.LoadXML(data: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = model.shared.curdata
        NotificationCenter.default.addObserver(forName: NSNotification.Name("data"), object: nil, queue: nil) { (Notification) in
            print("not catch")
            DispatchQueue.main.async {
                self.navigationItem.title = model.shared.curdata
                self.tableView.reloadData()
                let bar = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.ref(_:)))
                self.navigationItem.rightBarButtonItem = bar
                
            }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("start"), object: nil, queue: nil) { (Notification) in
            DispatchQueue.main.async {
                let activ = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
                activ.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activ
            }
        }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("error"), object: nil, queue: nil) { (Notification) in
                let erorname = Notification.userInfo?["name"]
                print(erorname)
                DispatchQueue.main.async {
                let bar = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.ref(_:)))
                self.navigationItem.rightBarButtonItem = bar
            }
            print("reload")
        }
        }
        /*var bb : Bool = false
        NotificationCenter.default.addObserver(forName: NSNotification.Name("data"), object: nil, queue: nil) {
            (Notification) in
        print("not catch")
        bb = true
        }
        if bb == true {
            tableView.reloadData()
            bb = false
            print("reload")
        }*/
        
        
   
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.shared.currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let CurCell = model.shared.currencies[indexPath.row]
        
        /*cell.textLabel?.text = CurCell.Name
        cell.detailTextLabel?.text = CurCell.Value*/
        cell.initcell(curency: CurCell)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
