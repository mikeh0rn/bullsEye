//
//  ViewController.swift
//  Bulls Eye
//
//  Created by Mike Horn on 9/1/15.
//  Copyright (c) 2015 Mike Horn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  var currentValue = 0;
  var targetValue = 0;
  var score = 0;
  var round = 0;
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
      super.viewDidLoad();
      startNewGame();
      updateLabels();
      
      let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
      slider.setThumbImage(thumbImageNormal, forState: .Normal)
      
      let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
      slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
      
      let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
      
      if let trackLeftImage = UIImage(named: "SliderTrackLeft"){
        let trackLeftResizable =
                              trackLeftImage.resizableImageWithCapInsets(insets)
        slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
      }
      
      if let trackRightImage = UIImage(named: "SliderTrackRight") {
        let trackRightResizable =
                              trackRightImage.resizableImageWithCapInsets(insets)
        slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
      }
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func startNewRound(){
    round += 1
    targetValue = 1 + Int(arc4random_uniform(100))
    currentValue = 50
    slider.value = Float(currentValue)
  }
  
  func startNewGame(){
    score = 0
    round = 0
    startNewRound()
  }
  
  func updateLabels(){
    targetLabel.text = String(targetValue);
    scoreLabel.text = String(score);
    roundLabel.text = String(round);
    // can optionally iterpolate instead of String(targetValue). same difference.
  }
    
    @IBAction func showAlert(){
      let difference = abs(targetValue - currentValue)
      var points = 100 - difference

      
      var title: String
      if difference == 0 {
        title = "Perfect!"
        points += 100
      } else if difference < 5 {
        title = "You almost had it!"
        if difference == 1 {
          points += 50
        }
      } else if difference < 10 {
        title = "Pretty good!"
      } else {
        title = "Not even close..."
      }
      
      score += points
      
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
      let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
                                                                            self.startNewRound()
                                                                            self.updateLabels()
                                                                          })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    // the storyboard and the Swift file – together form the design and implementation of a view controller. A lot of the work in building iOS apps is making view controllers. The job of a view controller is to manage a single screen from your app.
    
    @IBAction func sliderMoved(slider: UISlider){
      currentValue = lroundf(slider.value)
      println("The value of the slider is now: \(slider.value)")
    }
  
  @IBAction func startOver() {
    startNewGame()
    updateLabels()
  }

}

