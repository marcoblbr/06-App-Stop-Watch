//
//  ViewController.swift
//  06 - Demp App
//
//  Created by Marco Linhares on 6/10/15.
//  Copyright (c) 2015 Marco Linhares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var seconds     = 0
    var minutes     = 0
    var hours       = 0
    var miliseconds = 0
    
    var timer = NSTimer ()

    var playButton = false
    
    @IBOutlet weak var labelTime: UILabel!

    @IBOutlet weak var labelMiliseconds: UILabel!
    
    @IBAction func buttonCancel(sender: AnyObject) {
        playButton  = false
        
        timer.invalidate()
        
        resetTime ()
        
        self.StartFigButtonLabel.setTitle("Start", forState: UIControlState.Normal)
        
        self.StartFigButtonLabel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)

    }
    
    @IBAction func buttonStart(sender: AnyObject) {
        self.StartFigButtonLabel.setTitle("Stop", forState: UIControlState.Normal)
            
        self.StartFigButtonLabel.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        // parâmetros
        // 1o = intervalo de tempo em que a função é chamada. 1 significa a cada segundo. Se fosse 0.5 seria a cada meio segundo
        // 2o = target. é a classe em que ele vai atuar
        // 3o = função que vai ser chamada a cada 1 segundo
        // 4o = se for passar algum valor pra função
        // 5o = se a função deve se repetir ou se ocorre apenas 1 vez
        
        // cria um timer que roda a cada 0.01 segundo
        
        if playButton == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector ("result"), userInfo: nil, repeats: true)
        
            playButton = true
        }
    }
    
    @IBAction func buttonPause(sender: AnyObject) {
        playButton  = false
        
        timer.invalidate()
        
        self.StartFigButtonLabel.setTitle("Start", forState: UIControlState.Normal)
        
        self.StartFigButtonLabel.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    }
    
    @IBAction func StartFigButton(sender: AnyObject) {
        
        // caso já esteja rodando, vira um botão de pause
        if playButton == true {
            self.buttonPause(self)
        } else {
            self.buttonStart(self)
        }
    }
    
    
    @IBAction func CancelFigButton(sender: AnyObject) {
        self.buttonCancel(self)
    }
    
    @IBOutlet weak var StartFigButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    
        resetTime ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetTime () {
        seconds     = 0
        minutes     = 0
        hours       = 0
        miliseconds = 0
        
        labelTime.text = "0"
        labelMiliseconds.text = ""
    }
    
    func result (){
        if playButton == true {
            miliseconds++
        }
        
        if miliseconds == 100 {
            miliseconds = 0
            seconds++
        }
        
        if seconds == 60 {
            seconds = 0
            minutes++
        }
        
        if minutes == 60 {
            minutes = 0
            hours++
        }

        if hours == 24 {
            resetTime ()
        }
        
        if hours == 0 {
            if minutes == 0 && seconds == 0 && miliseconds == 0 {
                labelTime.text = "0"
                labelMiliseconds.text = ""
            }
            else if minutes == 0 {
                labelTime.text = String (seconds)
                labelMiliseconds.text = String (format: ".%02d", miliseconds)
            } else {
                labelTime.text = String (format: "%02d:%02d", minutes, seconds)
                labelMiliseconds.text = String (format: ".%02d", miliseconds)
            }
        } else {
            labelTime.text = String (format: "%02d:%02d:%02d", hours, minutes, seconds)
            labelMiliseconds.text = String (format: ".%02d", miliseconds)
        }
    }
}

