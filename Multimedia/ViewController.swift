//
//  ViewController.swift
//  Multimedia
//
//  Created by Ángel González on 22/06/24.
//

import UIKit
import AVFoundation
import AVKit
import YouTubeiOSPlayerHelper

class ViewController: UIViewController {
    var avplayer:AVAudioPlayer!
    let btnPlay = UIButton(type: .system)
    let btnStop = UIButton(type: .system)
    let sliderDuration = UISlider()
    let sliderVolume = UISlider()
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let l1=UILabel()
        l1.text="AudioPlayer"
        l1.font=UIFont.systemFont(ofSize: 24)
        l1.autoresizingMask = .flexibleWidth
        l1.translatesAutoresizingMaskIntoConstraints=true
        l1.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        l1.textAlignment = .center
        self.view.addSubview(l1)
        
        btnPlay.setTitle("Play", for: .normal)
        btnPlay.autoresizingMask = .flexibleWidth
        btnPlay.translatesAutoresizingMaskIntoConstraints=true
        btnPlay.frame=CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(btnPlay)
        btnPlay.addTarget(self, action:#selector(btnPlayTouch), for: .touchUpInside)
        
        sliderDuration.autoresizingMask = .flexibleWidth
        sliderDuration.translatesAutoresizingMaskIntoConstraints=true
        sliderDuration.frame=CGRect(x: 20, y:150, width: self.view.frame.width-40, height: 50)
        view.addSubview(sliderDuration)
        sliderDuration.addTarget(self, action:#selector(sliderDurationChange), for:.valueChanged)
        
        btnStop.setTitle("Stop", for: .normal)
        btnStop.autoresizingMask = .flexibleWidth
        btnStop.translatesAutoresizingMaskIntoConstraints=true
        btnStop.frame=CGRect(x:self.view.frame.width-100, y: 100, width: 100, height: 40)
        view.addSubview(btnStop)
        btnStop.addTarget(self, action:#selector(btnStopTouch), for:.touchUpInside)
        
        let l2=UILabel()
        l2.text="Volumen"
        l2.autoresizingMask = .flexibleWidth
        l2.translatesAutoresizingMaskIntoConstraints=true
        l2.frame=CGRect(x: 20, y: 200, width: 100, height: 40)
        view.addSubview(l2)
        
        sliderVolume.autoresizingMask = .flexibleWidth
        sliderVolume.translatesAutoresizingMaskIntoConstraints=true
        sliderVolume.frame=CGRect(x: 20, y: 250, width: self.view.frame.width/2, height: 50)
        self.view.addSubview(sliderVolume)
        sliderVolume.addTarget(self, action:#selector(sliderVolumeChange), for:.valueChanged)
        
        cargarAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        let avpp = VideoPlayer()
        // hay que agregar el controller de la subvista, como un controller "hijo"
        self.addChild(avpp)
        self.view.addSubview(avpp.view)
         avpp.view.translatesAutoresizingMaskIntoConstraints = false
         avpp.view.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant:-80).isActive = true
         avpp.view.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:10).isActive = true
         avpp.view.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10).isActive = true
         avpp.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        */
        let avpp = YTPlayerView()
        self.view.addSubview(avpp)
        avpp.translatesAutoresizingMaskIntoConstraints = false
        avpp.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant:-80).isActive = true
        avpp.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:10).isActive = true
        avpp.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10).isActive = true
        avpp.heightAnchor.constraint(equalToConstant: 320).isActive = true
        //avpp.load(withVideoId: "DoyA619L9MQ")
        let playerVars: [String: Any] = [ "autoplay": 1, "controls": 1, "showinfo": 0, "index": 2] // Índice del video en la lista de reproducción (comienza desde 0) ]
        avpp.load(withPlaylistId: "PLWz5rJ2EKKc8L8WlmqPD6zPEyVSKrL5PJ", playerVars:playerVars)
    }
    
    func cargarAudio(){
        guard let audioURL = Bundle.main.url(forResource:"Parcels - Gamesofluck (Live from Hansa Studios, Berlin)", withExtension:"mp3")
        else { return }
        do {
            avplayer = try AVAudioPlayer(contentsOf:audioURL)
            sliderVolume.value = avplayer.volume
            sliderDuration.maximumValue = Float(avplayer.duration)
            timer = Timer.scheduledTimer(withTimeInterval:1.0, repeats:true, block: { tmr in
                self.sliderDuration.value = Float(self.avplayer.currentTime)
            })
        }
        catch {
            print ("ocurrió un error")
        }
    }
    
    @objc func btnPlayTouch() {
        avplayer.play()
    }
    @objc func sliderDurationChange() {
        avplayer.currentTime = TimeInterval(sliderDuration.value)
    }
    @objc func btnStopTouch(){
        avplayer.stop()
    }
    @objc func sliderVolumeChange(){
        avplayer.volume = sliderVolume.value
    }
}
    

