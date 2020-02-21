//
//  ViewController.swift
//  PinHeaderTables
//
//  Created by sreekanth reddy iragam reddy on 2/16/20.
//  Copyright © 2020 TablesPinHeader. All rights reserved.
//

import UIKit

struct DataForCell {
    var data: String
}

struct DataForSection {
    var list: [DataForCell]
    var noOfRows: Int
    var isAnimation: Bool

    mutating func setAnimation(_ isAnim: Bool) {
        isAnimation = isAnim
    }
}

class ViewModelTable {
    var data: [DataForSection]?

    func getData() {
        var data = [DataForSection]()
        for _ in 1...5 {
            var cells = [DataForCell]()
            for index in 1...5 {
                cells.append(DataForCell(data: "\(index) Cell Index"))
            }
            data.append(DataForSection(list: cells, noOfRows: 5, isAnimation: false))
        }
        self.data = data
    }
}

class ViewController: UIViewController {
    var viewModelTable: ViewModelTable?
    var lastSelectedSection = -1

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelTable = ViewModelTable()
        viewModelTable?.getData()
     let headerNib = UINib.init(nibName: "TableViewHeaderFooterView", bundle: Bundle.main)
     tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MySectionHeader")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelTable?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelTable?.data?[section].noOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath)
        cell.textLabel?.text = "row in \(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MySectionHeader") as? TableViewHeaderFooterView
        view?.myLable.text = "\(section) In Section"
        return view
    }

//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section == 0 {
//            lastSelectedSection = 1
//
//        }
//    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("did scroll offset \(scrollView.contentOffset.y)")
        let visisbleRowsFirst = tableView.indexPathsForVisibleRows?.first
        print("visisbleRowsFirst... \(visisbleRowsFirst)")
        print("lastSelectedSection... \(lastSelectedSection)")
        if let visisbleRowsFirst = visisbleRowsFirst {
            // scroll up
            if scrollView.contentOffset.y > 0 {
                if visisbleRowsFirst.section >= 0 {
                    print("when they are diff  lastSelectedSection \(lastSelectedSection) visisbleRowsFirst.section \(visisbleRowsFirst.section) ")

                    let headerView =  tableView.headerView(forSection: visisbleRowsFirst.section) as? TableViewHeaderFooterView
                    headerView?.expand()


                    if let counts = viewModelTable?.data?.count {
                        for index in 0...counts-1 {
                            if index != visisbleRowsFirst.section {
                                let headerView =  tableView.headerView(forSection: index) as? TableViewHeaderFooterView
                                headerView?.collapse()

                            }
                        }
                    }
                }
            } 
        }
    }
}

