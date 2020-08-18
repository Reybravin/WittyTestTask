//
//  BankAccountCell.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 15.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

protocol BankAccountCellDelegate : AnyObject {
    func didChangeTap()
}

class BankAccountCell: UITableViewCell {
    
    @IBOutlet weak var bankTitle: UILabel!
    @IBOutlet weak var cardTitle: UILabel!
    
    weak var delegate : BankAccountCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView(bankTitle: String, cardTitle: String){
        self.bankTitle.text = bankTitle
        self.cardTitle.text = cardTitle
    }
    
    @IBAction func changeAction(_ sender: Any) {
        delegate?.didChangeTap()
    }
}
