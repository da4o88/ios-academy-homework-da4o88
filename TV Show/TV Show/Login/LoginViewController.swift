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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view.
      
        roundedButtons()
       
        // Call function to start activity indicator
        activityIndicatorStarted()
        // Call function to stop activity indicator after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.activityIndicatorStopped()
         }
               

    }
  
    // create edges around buttons
    func roundedButtons(){
        for button in myRoundedButtons {
            button.layer.cornerRadius = 15.0
            button.layer.masksToBounds = true
        
        }
    }
    
    // Section for Activity Indicator
    var isActivityIndicatorPressed = true
    
    func activityIndicatorStarted(){
        activityIndicator.startAnimating()
        isActivityIndicatorPressed = false
    }
    
    func activityIndicatorStopped(){
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        isActivityIndicatorPressed = true
    }
    
    // Show/Hide activity indicator when button is clicked
    func activityIndicatorPressed(){
        if isActivityIndicatorPressed{
            activityIndicatorStarted()
        } else {
            activityIndicatorStopped()
        }
        
    }
    
    // Section for events when buttons are clicked
    var tapsCounter = 0
    @IBAction func countNumberOfTaps(){
        tapsCounter += 1
        viewNumberOfTaps.text = String(format: "%d", tapsCounter)
        activityIndicatorPressed()
        
    }
    
    
    @IBAction func resetCounter(){
        tapsCounter = 0
        viewNumberOfTaps.text = String(format: "%d", tapsCounter)
        activityIndicatorStopped()
    }
    
   

}

