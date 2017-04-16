//
//  ViewController.swift
//  DocumentList
//
//  Created by Trai Nguyen on 4/14/17.
//  Copyright © 2017 Apps-Cyclone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var tbvMain: UITableView!

    var arrFile:[String] = []
    let fileMngr=FileManager.default;
    
    func listFilesFromDocumentsFolder()->[String]?{
        //full path to documents directory
        let docs=fileMngr.urls(for: .documentDirectory,in: .userDomainMask)[0].path;
        //list all contents of directory and return as [String] OR nil if failed
        return try? fileMngr.contentsOfDirectory(atPath:docs);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateList), name: NSNotification.Name(rawValue: "UPDATE_LIST"), object: nil)
    }

    func updateList() {
        self.arrFile = listFilesFromDocumentsFolder()!
        self.tbvMain.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        let name = self.arrFile[indexPath.row].components(separatedBy: "/").last
        cell?.textLabel?.text = name
        return cell!
    }
}
