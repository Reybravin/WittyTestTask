//
//  AddMoneyTableViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class AddMoneyMethodsViewController: UITableViewController {
        
    private let rowHeight : CGFloat = 80
    private let headerHeight : CGFloat = 100
    private let defaultPadding : CGFloat = 20

    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: UI Setup
    
    private func setupView(){
        title = "Add Money with"
        tabBarController?.tabBar.isHidden = true
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.tableHeaderView = makeTableHeaderView()
        tableView.tableFooterView = UIView()
    }
    
    private func makeTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: headerHeight))
        let labelFrame = CGRect(x: defaultPadding, y: 0, width: headerView.frame.width - defaultPadding, height: headerView.frame.height)
        let label = UILabel(frame: labelFrame)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Select how to add money"
        headerView.addSubview(label)
        return headerView
    }
    
    //MARK: Navigation
    
    private func showCardDetailsViewController(){
        let vc = CardDetailsViewController(nibName: String(describing: CardDetailsViewController.self), bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Table view data source

extension AddMoneyMethodsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = "Debit or credit card"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

}

// MARK: - Table view delegate

extension AddMoneyMethodsViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showCardDetailsViewController()
    }
    
}

