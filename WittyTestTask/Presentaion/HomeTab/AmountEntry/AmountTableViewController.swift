//
//  AmountTableViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 15.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class AmountTableViewController: UITableViewController {
    
    static func create(with card : BankCard) -> AmountTableViewController {
        let vc = AmountTableViewController()
        vc.card = card
        return vc
    }
    
    private let sectionHeaderHeight : CGFloat = 70
    private let rowHeight : CGFloat = 80
    private let headerHeight : CGFloat = 100
    private let defaultPadding : CGFloat = 20
    
    private enum CellType : CaseIterable {
        case amount
        case bank
        case account
        
        var title : String? {
            switch self {
            case .amount: return nil
            case .bank : return "Add money with"
            case .account : return "Add to"
            }
        }
    }
    
    private var card : BankCard!
    private let cells : [CellType] = [.amount, .bank, .account]
    
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: UI Setup
    
    private func setupView(){
        title = "Amount"
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.tableHeaderView = makeTableHeaderView()
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: AmountCell.self)
        tableView.registerNib(cellClass: BankAccountCell.self)
        tableView.registerNib(cellClass: WittyAccountCell.self)
    }

    private func makeTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: headerHeight))
        let labelFrame = CGRect(x: defaultPadding, y: 0, width: headerView.frame.width - defaultPadding, height: headerView.frame.height)
        let label = UILabel(frame: labelFrame)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "How much do you want to add?"
        headerView.addSubview(label)
        return headerView
    }
    
    //MARK: Navigation
    
    private func showPaymentVerificationViewController(){
        let vc = PaymentVerificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAdddMoneyMethodsViewController() {
        navigationController?.popToViewControllerOfType(ofClass: AddMoneyMethodsViewController.self)
    }

}


// MARK: - Table view data source
extension AmountTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return CellType.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.section]
        switch cellType {
        case .amount:
            let cell : AmountCell = tableView.dequeueReusableCell(indexPath: indexPath)
            addToolBar(textField: cell.amountTextField, button: makeToolBarButton())
            return cell
        case .bank:
            let cell : BankAccountCell = tableView.dequeueReusableCell(indexPath: indexPath)
            let cardTitle = "\(card.paymentSystem) *\(card.cardNumber.suffix(4))"
            cell.delegate = self
            cell.configureView(bankTitle: card.bankTitle, cardTitle: cardTitle)
            return cell
        case .account:
            let cell : WittyAccountCell = tableView.dequeueReusableCell(indexPath: indexPath)
            return cell
        }
    }
    
    private func makeToolBarButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Add Money", for: .normal)
        button.backgroundColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        return button
    }
    
    @objc func donePressed() {
        view.endEditing(true)
        showPaymentVerificationViewController()
    }
    
}


// MARK: - Table view delegate
extension AmountTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellType = cells[section]
        if cellType == .amount {
            return 0
        }
        return sectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellType = cells[section]
        if cellType != .amount {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: sectionHeaderHeight))
            let label = UILabel()
            label.text = cellType.title
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.frame = CGRect(x: defaultPadding, y: 0, width: view.frame.width - defaultPadding, height: view.frame.height)
            view.addSubview(label)
            return view
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - BankAccountCellDelegate

extension AmountTableViewController : BankAccountCellDelegate {
    func didChangeTap() {
        showAdddMoneyMethodsViewController()
    }
}
