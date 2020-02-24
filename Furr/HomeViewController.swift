//
//  ViewController.swift
//  Furr
//
//  Created by Mitch on 24/02/2020.
//  Copyright © 2020 Mitch. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class HomeViewController: UIViewController {
    
    @IBOutlet weak var animationView: NVActivityIndicatorView!
    @IBOutlet weak var hundredthLabel: UILabel!
    @IBOutlet weak var tenthLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.type = .ballPulse
        animationView.color = .systemPurple
        animationView.isHidden = true
        beginButton.isHidden = false
        beginButton.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        
    }
    @objc func fetchData(){
        Server().fetchData(completion: getResults(string:position:error:))
        showAnimation()
    }
    
    func showAnimation(){
        DispatchQueue.main.async {
            self.beginButton.isHidden = true
            self.animationView.isHidden = false
            self.animationView.startAnimating()
        }
    }
    
    func hideAnimation(){
        DispatchQueue.main.async {
            self.animationView.stopAnimating()
            self.animationView.isHidden = true
            self.beginButton.isHidden = false
        }
    }
    
    func getResults(string:String?, position:Int?, error:NSError?){
        hideAnimation()
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
