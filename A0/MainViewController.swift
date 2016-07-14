//
//  ViewController.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, ActionDelegate, UserDefaults {
    
    var tableView: UITableView!
    var actions: [[String]]!
    
    var newActionName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.colorOfStatus(getColorStatusOfBar())
        title = " "
        
        let titleItem = UIBarButtonItem(customView: TitleLabel(text: "GOAL OUTCOME LESSON"))
        navigationItem.leftBarButtonItem = titleItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        actions = getAllActions()
        
        tableView = UITableView(frame: view.bounds)
        tableView.frame.size.height -= 64
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        let marginView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 2.5))
        marginView.backgroundColor = tableView.backgroundColor
        tableView.tableHeaderView = marginView
        tableView.tableFooterView = marginView
        view.addSubview(tableView)
    }

    func addButtonTapped() {
        let alertController = UIAlertController(title: "Action Title", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (_) in
            alertController.textFields?[0].resignFirstResponder()
        })
        let doneAction = UIAlertAction(title: "Done", style: .Default) { (_) in
            alertController.textFields?[0].resignFirstResponder()
            if let name = alertController.textFields![0].text {
                if name == "" { return }
                self.newActionName = name
                let inputVC = InputViewController()
                inputVC.index = 0
                inputVC.oldText = ""
                inputVC.delegate = self
                self.presentViewController(NavigationController(rootViewController: inputVC), animated: true, completion: nil)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }

}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ActionTitleCell(style: .Default, reuseIdentifier: "cell")
        cell.configureCell(actions[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.action = actions[indexPath.row]
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        deleteAction(actions[indexPath.row])
        actions = getAllActions()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
}

extension MainViewController: DetailViewControllerDelegate {
    
    func actionDidSave() {
        actions = getAllActions()
        tableView.reloadData()
    }
}

extension MainViewController: InputViewControllerDelegate {
    
    func inputTextViewDidReturn(index: Int, text: String) {
        let newAction: [String] = ["", "0", newActionName, text, "", ""]
        saveAction(newAction) { 
            self.actions = self.getAllActions()
            self.tableView.reloadData()
        }
    }
}

