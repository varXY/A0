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
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = " "
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth - 60, 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.text = "GOAL OUTCOME LESSON"
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
        
        actions = getAllActions()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView = UITableView(frame: view.bounds)
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        let marginView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 5))
        marginView.backgroundColor = tableView.backgroundColor
        tableView.tableHeaderView = marginView
        tableView.tableFooterView = marginView
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
                self.presentViewController(NavigationController(rootViewController: detailVC), animated: true, completion: nil)
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

