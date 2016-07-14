//
//  DetailViewController.swift
//  A0
//
//  Created by yao xiao on 7/13/16.
//  Copyright © 2016 yao xiao. All rights reserved.
//

import UIKit


protocol DetailViewControllerDelegate: class {
    func actionDidSave()
}


class DetailViewController: UIViewController, ActionDelegate, UserDefaults {
    
    var action: [String]!
    
    var textView: UITextView!
    var contentLabels: [ContentLabel]!
    var tableView: UITableView!
    
    let cellHeight = ScreenHeight * 0.45
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor.colorOfStatus(action[1])
        saveColorStatusOfBar(action[1])
        title = action[2]
        
//        let titleItem = UIBarButtonItem(customView: TitleLabel(text: action[2]))
//        navigationItem.leftBarButtonItem = titleItem
        
        let statusButton = UIBarButtonItem(title: action[1], style: .Plain, target: self, action: #selector(changeStatus))
        navigationItem.rightBarButtonItem = statusButton
        
        contentLabels = [3, 4, 5].map({
            return ContentLabel(text: action[$0], status: String($0 - 3))
        })
   
        tableView = UITableView(frame: view.bounds)
        tableView.frame.size.height -= 64
        tableView.separatorStyle = .None
        tableView.dataSource = self
        tableView.delegate = self
        let marginView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 10))
        marginView.backgroundColor = tableView.backgroundColor
        tableView.tableHeaderView = marginView
        tableView.tableFooterView = marginView
        view.addSubview(tableView)
    }
    
    
    func quit() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveAndQuit() {
        let action: [String] = ["", self.action[1], self.action[2], textView.text, "", ""]
        saveAction(action) {
            self.delegate?.actionDidSave()
            self.quit()
        }
    }
    
    func changeStatus() {
        let alertController = UIAlertController(title: "Change Status", message: nil, preferredStyle: .ActionSheet)
        let actions = [
            UIAlertAction(title: "PLANING", style: .Default) { (_) in self.statusChanged("0") },
            UIAlertAction(title: "DOING", style: .Default) { (_) in self.statusChanged("1") },
            UIAlertAction(title: "DONE", style: .Default) { (_) in self.statusChanged("2") },
            UIAlertAction(title: "Cancel", style: .Cancel) { (_) in self.statusChanged(self.action[1]) }
        ]
        
        actions.forEach({ alertController.addAction($0) })
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func statusChanged(status: String) {
        action[1] = status
        navigationController?.navigationBar.barTintColor = UIColor.colorOfStatus(action[1])
        tableView.reloadData()
        
        editAction(action)
        delegate?.actionDidSave()
    }
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Int(action[1])! + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return contentLabels[indexPath.section].frame.height + 5
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["GOALS", "RESULTS", "CONCLUSION"][section]
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRectMake(0, 0, 30, ScreenWidth))
        label.backgroundColor = tableView.backgroundColor
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = .Center
        label.text = ["GOALS", "OUTCOMES", "LESSONS"][section]
        return label
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, 30, ScreenWidth))
        view.backgroundColor = tableView.backgroundColor
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.contentView.addSubview(contentLabels[indexPath.section])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let inputVC = InputViewController()
        inputVC.index = indexPath.section
        inputVC.oldText = action[indexPath.section + 3]
        inputVC.delegate = self
        presentViewController(NavigationController(rootViewController: inputVC), animated: true, completion: nil)
    }
}

extension DetailViewController: InputViewControllerDelegate {
    
    func inputTextViewDidReturn(index: Int, text: String) {
        action[index + 3] = text
        contentLabels[index].setContent(text)
        tableView.reloadData()
        
        editAction(action)
        delegate?.actionDidSave()
    }
}


