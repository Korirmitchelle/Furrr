//
//  ViewController.swift
//  Furr
//
//  Created by Mitch on 24/02/2020.
//  Copyright © 2020 Mitrch. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var hundredthLabel: UILabel!
    @IBOutlet weak var tenthLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginButton.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        
    }
    @objc func fetchData(){
        Server().doSomething(completion: getResults(string:position:error:))
    }
    
    func getResults(string:String?, position:Int?, error:NSError?){
        guard error == nil else {
            return
        }
        guard let string = string else{return}
        DispatchQueue.main.async {
            switch position {
            case 0:
                self.hundredthLabel.text = string
            case 1:
                self.tenthLabel.text = string
            default:
                self.countLabel.text = string
            }
        }
        
    }
    
}
