//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Amjad khalid  on 03/11/2018.
//  Copyright © 2018 Amjad khaled. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate
class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled=false
    }
    
    // MARK: UI Recording Function
    @IBAction func recordAudio(_ sender: Any) {
        
        //Set the UI elements to state: recording
        configureUI(true)
        
        //Starting The record process
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: Stop recording Function
    @IBAction func stopRecording(_ sender: Any) {
        
        //Set the UI elements to state: stop recording
        configureUI(false)
        
        //Stop recording process
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: UI Functions
    func configureUI(_ isRecording:Bool = false) {
        recordingLabel.text = isRecording ? "Recording in Progress": "Tap to Record"
        if isRecording{
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }
        else{
            recordButton.isEnabled=true
            stopRecordingButton.isEnabled=false
        }
    }
    
    //MARK: performing Segue when the recording process successfuly finishd
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
            performSegue(withIdentifier:"stopRecording", sender: audioRecorder.url)
        }
            
        else{
            print("Recording was not Successful")
        }
    }
    
    //MARK: preparing Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL=recordedAudioURL
        }
    }
}

