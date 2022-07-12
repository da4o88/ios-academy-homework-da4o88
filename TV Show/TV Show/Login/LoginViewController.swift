//
//  LoginViewController.swift
//  TV Show
//
//  Created by infinum on 08/07/2022.
//
//
//
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var myViewController: UIView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var viewNumberOfTaps: UILabel!
    @IBOutlet private weak var doRoundedButton: UIButton!
    @IBOutlet private var myRoundedButtons: [UIButton]!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    private var tapsCounter = 0
    private var isActivityIndicatorPressed = true
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      // Do any additional setup after loading the view.
      
        roundedButtons()
       
        // Call function to start activity indicator
        
        activityIndicatorStarted()
        
        // Call function to stop activity indicator after 3 seconds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.activityIndicatorStopped()
            
         }
    }
  
    // MARK: - Actions
    
    @IBAction private func countNumberOfTaps(){
        
        tapsCounter += 1
        viewNumberOfTaps.text = String(format: "%d", tapsCounter)
        activityIndicatorPressed()
        
    }
    
    @IBAction private func resetCounter(){
        
        tapsCounter = 0
        viewNumberOfTaps.text = String(format: "%d", tapsCounter)
        activityIndicatorStopped()
        
    }
    
    //MARK: Utility methods
    
    // create edges around buttons
    
    private func roundedButtons(){
        
        for button in myRoundedButtons {
            
            button.layer.cornerRadius = 15.0
            button.layer.masksToBounds = true
            
        }
    }
    
    // Section for Activity Indicator when is started or stopped
    
    private func activityIndicatorStarted(){
        
        activityIndicator.startAnimating()
        isActivityIndicatorPressed = false
        
    }
    
    private func activityIndicatorStopped(){
        
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        isActivityIndicatorPressed = true
        
    }
    
    // Show-Hide activity indicator when button is clicked
    
    private func activityIndicatorPressed(){
        
        if isActivityIndicatorPressed{
            
            activityIndicatorStarted()
            
        } else {
            
            activityIndicatorStopped()
            
        }
    }
}
