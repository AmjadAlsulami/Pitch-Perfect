//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Amjad khalid  on 03/11/2018.
//  Copyright © 2018 Amjad khaled. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - PlaySoundsViewController: UIViewController
class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: ButtonType (raw values correspond to sender type)
    enum ButtonType: Int {
        case slow = 0, fast, highPitch, lowPitch, echo,reverb
    }
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Enable all the playing buttons, and Disable the stop playing button
        configureUI(.notPlaying)
        //Set the contentMode to images of buttons
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        
    }
    
    // MARK: play Sound For Button function (value correspond to sender type)
    @IBAction func playSoundForButton(_ sender: Any) {
        
        switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo:true)
        case .reverb:
            playSound(reverb:true)
            
        }
        //Disable all the playing buttons , and Enable the stop playing button
        configureUI(.playing)
    }
    
    // MARK: stop Button Pressed funnction
    @IBAction func stopButtonPressed(_ sender: Any) {
        stopAudio()
    }
    
}
