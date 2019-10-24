//
//  FolderNotesController.swift
//  NotesiOS
//
//  Created by Nabil Rahman on 10/23/19.
//  Copyright © 2019 Nabil Rahman. All rights reserved.
//

import UIKit

class FolderNotesController: UITableViewController {
    
    fileprivate let CELL_ID: String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Folder Notes"
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
    }
}

extension FolderNotesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        cell.textLabel?.text = "The first note! yay!"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}


