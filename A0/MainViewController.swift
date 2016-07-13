//
//  ViewController.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ActionDelegate {
    
    var tableView: UITableView!
    var actions: [[String]]!
    
    let testActions = [
        ["1", "1", "Action 1", "goal", "result", "conclusion"],
        ["2", "0", "Action 2", "goal", "result", "conclusion"],
        ["3", "2", "Action 3", "goal", "result", "conclusion"],
        ["4", "1", "Action 4", "goal", "result", "conclusion"],
        ["5", "0", "Action 5", "goal", "result", "conclusion"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = "Actions"
        
        let savedActions = getAllActions()
        actions = savedActions.count == 0 ? testActions : savedActions
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView = UITableView(frame: view.bounds)
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    func addButtonTapped() {
        let alertController = UIAlertController(title: "Action Title", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let doneAction = UIAlertAction(title: "Done", style: .Default) { (_) in
            if let name = alertController.textFields![0].text {
                if name == "" { return }
                let detailVC = DetailViewController()
                detailVC.detailType = .Add
                detailVC.action = ["", "0", name, "", "", ""]
                detailVC.delegate = self
                self.presentViewController(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
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
        detailVC.detailType = .See
        detailVC.action = actions[indexPath.row]
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: DetailViewControllerDelegate {
    
    func actionDidSave() {
        actions = getAllActions()
        tableView.reloadData()
    }
}

