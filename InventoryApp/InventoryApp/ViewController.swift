//
//  ViewController.swift
//  InventoryApp
//
//  Created by Biplove lamsal on 03/8/22.
//

import UIKit

protocol CreateItemDelegate {
    func onCreateItem(inventary:InventoryDataModel)
    func onUpdateItem(inventary:InventoryDataModel)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewInventory: UITableView!
    lazy var dataSource = configureDataSource()
    var snapshot = NSDiffableDataSourceSnapshot<Section, InventoryDataModel>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableViewInventory.delegate = self
        tableViewInventory.dataSource = dataSource
        tableViewInventory.register(InventaryTableViewCell.self, forCellReuseIdentifier: "InventaryTableViewCell")
        tableViewInventory.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        let rightButtonItem = UIBarButtonItem.init(title: "New",style: .done,target:self,action: #selector(onTapBtnCreate))
        let leftButtonItem = UIBarButtonItem.init(title: "Edit",style: .done,target: self,action: #selector(onTapBtnEditUpdate)
        )
        self.navigationItem.leftBarButtonItem = leftButtonItem
        self.navigationItem.rightBarButtonItem = rightButtonItem
        updateDataSource()
    }
    
    private func updateDataSource() {
            snapshot.appendSections([.puzzle])
            snapshot.appendItems([InventoryDataModel(title: "Map puzzles", qty: 23, itemType: .puzzle),InventoryDataModel(title: "Animal puzzles", qty: 45, itemType: .puzzle)], toSection: .puzzle)
            snapshot.appendSections([.science])
            snapshot.appendItems([InventoryDataModel(title: "Robots", qty: 51, itemType: .science),InventoryDataModel(title: "Telescopes", qty: 72, itemType: .science)], toSection: .science)
            snapshot.appendSections([.figure])
            snapshot.appendItems([InventoryDataModel(title: "Superman", qty: 3, itemType: .figure),InventoryDataModel(title: "Spiderman", qty: 6, itemType: .figure)], toSection: .figure)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
     
    
    @objc func onTapBtnEditUpdate() {
        
    }
    
    @objc func onTapBtnCreate() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
        vc.createItemDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ViewController : UITableViewDelegate {
    func configureDataSource() -> UITableViewDiffableDataSource<Section, InventoryDataModel> {
        let dataSource = UITableViewDiffableDataSource<Section,InventoryDataModel>(tableView: self.tableViewInventory) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "InventaryTableViewCell", for: indexPath) as! InventaryTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "\(item.qty)"
            return cell
        }
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        vc.inventory = item ?? InventoryDataModel()
        vc.createItemDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        switch section {
        case 0:
            headerView.lblHeaderTitle.text = "Puzzle"
        case 1:
            headerView.lblHeaderTitle.text = "Science"
        case 2:
            headerView.lblHeaderTitle.text = "Figure"
        default:
            print("Oops")
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension ViewController : CreateItemDelegate {
    
    func onUpdateItem(inventary: InventoryDataModel) {
        let items = snapshot.itemIdentifiers(inSection: inventary.itemType)
        guard let index = items.firstIndex(where: {$0.title == inventary.title}) else { return }
        var tempItems = items
        tempItems[index] = inventary
        snapshot.deleteItems(items)
        snapshot.appendItems(tempItems, toSection: inventary.itemType)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func onCreateItem(inventary: InventoryDataModel) {
        snapshot.appendItems([inventary], toSection: inventary.itemType)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
