//
//  FolderNotesController.swift
//  NotesiOS
//
//  Created by Nabil Rahman on 10/23/19.
//  Copyright © 2019 Nabil Rahman. All rights reserved.
//

import UIKit

extension FolderNotesController: NoteDelegate {
    func saveNewNote(title: String, date: Date, text: String) {
        let newNote = CoreDataManager.shared.createNewNote(title: title, date: date, text: text, noteFolder: self.folderData)
        notes.append(newNote)
        filteredNotes.append(newNote)
        self.tableView.insertRows(at: [IndexPath(row: notes.count - 1, section: 0)], with: .fade)
    }
}

class FolderNotesController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var folderData: NoteFolder! {
          didSet {
            notes = CoreDataManager.shared.fetchNotes(from: folderData)
            filteredNotes = notes
          }
    }
    
    fileprivate var notes = [Note]()
    fileprivate var filteredNotes = [Note]()
    
    fileprivate let CELL_ID: String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notes"
        setupTableView()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let items: [UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.createNewNote)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "\(notes.count) Notes", style: .done, target: nil, action: nil)
        ]
        self.toolbarItems = items
        tableView.reloadData()
    }
    
    @objc fileprivate func createNewNote() {
        let noteDetailController = NoteDetailController()
        noteDetailController.delegate = self
        navigationController?.pushViewController(noteDetailController, animated: true)
    }
    
    fileprivate func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    var cachedText: String = ""
}

extension FolderNotesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotes = notes.filter({ (note) -> Bool in
            return note.title?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        if searchBar.text!.isEmpty && filteredNotes.isEmpty {
            filteredNotes = notes
        }
        cachedText = searchText
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !cachedText.isEmpty && !filteredNotes.isEmpty {
            searchController.searchBar.text = cachedText
        }
    }
}

extension FolderNotesController {
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actions = [UITableViewRowAction]()
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("Trying to delete row at indexpath:", indexPath)
            let targetRow = indexPath.row
            if CoreDataManager.shared.deleteNote(note: self.notes[targetRow]) {
                self.notes.remove(at: targetRow)
                self.filteredNotes.remove(at: targetRow)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        actions.append(deleteAction)
        return actions
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        let noteForRow = self.filteredNotes[indexPath.row]
        cell.noteData = noteForRow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailController = NoteDetailController()
        let noteForRow = self.filteredNotes[indexPath.row]
        noteDetailController.noteData = noteForRow
        navigationController?.pushViewController(noteDetailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


