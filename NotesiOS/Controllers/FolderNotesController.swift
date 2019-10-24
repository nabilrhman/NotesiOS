//
//  FolderNotesController.swift
//  NotesiOS
//
//  Created by Nabil Rahman on 10/23/19.
//  Copyright © 2019 Nabil Rahman. All rights reserved.
//

import UIKit

class FolderNotesController: UITableViewController {
    
    var folderData: NoteFolder! {
          didSet {
            self.notes = folderData.notes
          }
    }
    
    fileprivate var notes = [Note]()
    
    fileprivate let CELL_ID: String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notes"
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let items: [UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "5 Notes", style: .done, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.createNewNote))
        ]
        self.toolbarItems = items
    }
    
    @objc fileprivate func createNewNote() {
        let noteDetailController = NoteDetailController()
        navigationController?.pushViewController(noteDetailController, animated: true)
    }
    
    fileprivate func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: CELL_ID)
    }
}

extension FolderNotesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        let noteForRow = self.notes[indexPath.row]
        cell.noteData = noteForRow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailController = NoteDetailController()
        navigationController?.pushViewController(noteDetailController, animated: true)
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


