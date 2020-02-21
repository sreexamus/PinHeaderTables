//
//  UITableViewHeaderFooterView.swift
//  PinHeaderTables
//
//  Created by sreekanth reddy iragam reddy on 2/17/20.
//  Copyright © 2020 TablesPinHeader. All rights reserved.
//

import UIKit

class TableViewHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var myLable: UILabel!
    @IBOutlet weak var leadingCons: NSLayoutConstraint!
    @IBOutlet weak var trailingCons: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.backgroundColor = .white
        configureContents()
    }

    func configureContents() {
        myLable.layer.masksToBounds = true
        myLable.layer.cornerRadius = 20
    }

    func expand() {
        leadingCons.constant = 0
        trailingCons.constant = 0
        setNeedsLayout()
    }

    func collapse() {
        leadingCons.constant = 50
        trailingCons.constant = 50
        setNeedsLayout()
    }
}
