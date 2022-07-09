//
//  LoginViewController.swift
//  TV Show
//
//  Created by infinum on 08/07/2022.
//
//
//
import UIKit

class LoginViewController: UIViewController {
//
    
    @IBOutlet weak var myViewController: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var viewNumberOfTaps: UILabel!
 
    @IBOutlet weak var doRoundedButton: UIButton!
    
    @IBOutlet var myRoundedButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view.
        myViewController.backgroundColor = .purple
        roundedButtons()

        
                   
                

    }
    
    func roundedButtons(){
        for button in myRoundedButtons {
            button.layer.cornerRadius = 15.0
            button.layer.masksToBounds = true
         }
    }
    
    var tapsCounter = 0
    @IBAction func countNumberOfTaps(){
        tapsCounter += 1
        viewNumberOfTaps.text = String(format: "%d", tapsCounter)
        
    }
    
    
    @IBAction func resetCounter(){
        tapsCounter = 0
        viewNumberOfTaps.text = String(format: "%d", tapsCounter)
    }
    
   

}

