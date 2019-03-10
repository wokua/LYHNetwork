//
//  ViewController.swift
//  LYHNetwork
//
//  Created by lrk on 2019/3/1.
//  Copyright © 2019 LYH. All rights reserved.
//

import UIKit
import ESPullToRefresh
import SnapKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let api = JokerApi()
    let tableView = UITableView()
    var dataArr : [JokeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 50, width: 200, height: 40))
        btn.setTitle("刷新", for: UIControl.State.normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(request), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        
        self.view.backgroundColor = UIColor.white
        tableView.frame = CGRect.init(x: 0, y: 200, width: self.view.frame.width, height: self.view.frame.height)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
 
    @objc func request(){
        api.manager.showHUD().on(success: { [weak self](arr) in
            self?.dataArr = arr
            self?.tableView.reloadData()
        }) { (error) in
            
        }.request()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.dataArr?[indexPath.row].content
        return cell
    }
}

