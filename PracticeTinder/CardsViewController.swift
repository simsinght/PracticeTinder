//
//  CardsViewController.swift
//  PracticeTinder
//
//  Created by Simrandeep Singh on 4/26/17.
//  Copyright © 2017 Sim. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var faceCardImageView: UIImageView!
    
    var cardInitialCenter: CGPoint!
    var grabbedAt: CGPoint!
    var rotatesPos = 0
    var rotatesNeg = 0
    var reverse = 0 as CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardInitialCenter = faceCardImageView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanFaceCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        let location = sender.location(in: nil)
        
        if sender.state == .began {
            grabbedAt = location
            if ( location.y >= cardInitialCenter.y){
                print("touched bottom")
                reverse = -1
            } else{
                print("touched top")
                reverse = 1
            }
            
        } else if sender.state == .changed {
            
            faceCardImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y + translation.y)
            
            let xVariableInLineEquation = cardInitialCenter.x - faceCardImageView.center.x
            let resultOfFunction = -523599/188000000 * xVariableInLineEquation * reverse
            print(cardInitialCenter.x - faceCardImageView.center.x)
            faceCardImageView.transform = CGAffineTransform(rotationAngle: resultOfFunction)
            
        } else if sender.state == .ended {
            print("Did Pan Face ended")
            if(abs(faceCardImageView.center.x - cardInitialCenter.x) >= 50){
                UIView.animate(withDuration:0.4, animations: {
                    self.faceCardImageView.center.x = 900 * min(1, max(-1, self.faceCardImageView.center.x - self.cardInitialCenter.x))
                })
                
            } else {
                UIView.animate(withDuration:0.4, animations: {
                    self.faceCardImageView.center = self.cardInitialCenter
                    self.faceCardImageView.transform = .identity
                })
            }
            
            print(rotatesPos, rotatesNeg)
        }
    }
    
    @IBAction func didTapFaceCard(_ sender: Any) {
        performSegue(withIdentifier: "fullScreen", sender: self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
