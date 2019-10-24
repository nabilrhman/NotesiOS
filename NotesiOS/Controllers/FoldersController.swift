//
//  ViewController.swift
//  NotesiOS
//
//  Created by Nabil Rahman on 10/23/19.
//  Copyright © 2019 Nabil Rahman. All rights reserved.
//

import UIKit

extension FoldersController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        cell.textLabel?.text = "The first note folder! yay!"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderNotesController = FolderNotesController();
        navigationController?.pushViewController(folderNotesController, animated: true)
    }
    
}

class FoldersController: UITableViewController {

    fileprivate let CELL_ID: String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = "Folders"
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
    }


}

