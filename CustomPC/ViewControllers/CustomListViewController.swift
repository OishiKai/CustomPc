//
//  ViewController.swift
//  CustomPC
//
//  Created by Kai on 2022/02/11.
//

import UIKit

class CustomListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var customTable: UITableView!
    var addBarButtonItem: UIBarButtonItem!
    
    var customs:[Custom]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customs"
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
        customs = AccessData.getCustoms()
        print(customs.count)
        
        for i in customs {
            let a = i.parts?.allObjects as! [Parts]
            for j in a {
                print(j.title)
            }
        }
        
        let nib = UINib(nibName: SearchPartsTableViewCell.cellIdentifier, bundle: nil)
        customTable.register(nib, forCellReuseIdentifier: SearchPartsTableViewCell.cellIdentifier)
        customTable.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchPartsTableViewCell.cellIdentifier, for: indexPath) as! SearchPartsTableViewCell
        cell.setupCustomListCell(custom: customs[indexPath.row])
        return cell
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "NewCustomViewController", bundle: nil)
            let nextVC = storyboard.instantiateViewController(identifier: "NewCustomViewController")as! NewCustomViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

