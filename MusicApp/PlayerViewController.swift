//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Dor Levi on 25/04/2020.
//  Copyright © 2020 Dor Levi. All rights reserved.
//

import AVFoundation
import UIKit



class PlayerViewController: UIViewController {

    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player:AVAudioPlayer?
    
    private let albumImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songName: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistName: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumName: UILabel = {
           
           let label = UILabel()
           label.textAlignment = .center
           label.numberOfLines = 0
           return label
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
            
        }
    }
  
    func configure(){
        
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
            
          try AVAudioSession.sharedInstance().setMode(.default)
          try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
          
          guard let urlString = urlString else{
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else{
                return
            }
            player.volume = 0.5
            player.play()
        }
        catch{
            
            print("Error!!")
        }
        albumImage.frame = CGRect(x:12,
                                  y:12,
                                  width: holder.frame.size.width-25,
                                  height: holder.frame.size.width-25)
        albumImage.image = UIImage(named: song.imageName)
        holder.addSubview(albumImage)
        
        
        songName.frame = CGRect(x:12,
                                y:albumImage.frame.size.height + 12 + 70,
                                   width: holder.frame.size.width-25,
                                   height:75)
        albumName.frame = CGRect(x:12,
                                 y:albumImage.frame.size.height + 12,
                                 width: holder.frame.size.width-25,
                                 height:75)
        artistName.frame = CGRect(x:12,
                                y:albumImage.frame.size.height + 12 + 140,
                                width: holder.frame.size.width-25,
                                height:75)
        
        songName.text = song.name
        albumName.text = song.artistName
        
        
        
        holder.addSubview(songName)
        holder.addSubview(albumName)
        holder.addSubview(artistName)

        
        //Player Buttons
        let PlayPauseButton = UIButton()
        let NextButton = UIButton()
        let PrevButton = UIButton()
        
        
        
        let yPosition = artistName.frame.origin.y + 70 + 15
        let size: CGFloat = 80
        
        PlayPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: 50,
                                       height: 50)
        NextButton.frame = CGRect(x: holder.frame.size.width - size - 0,
                                             y: yPosition,
                                             width: 50,
                                             height: 50)
        PrevButton.frame = CGRect(x: 15,
                                  y: yPosition,
                                  width: 50,
                                  height: 50)
        
        
        
        PlayPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        NextButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        PrevButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        
        
        PlayPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"),for: .normal)
        NextButton.setBackgroundImage(UIImage(systemName: "forward.fill"),for: .normal)
        PrevButton.setBackgroundImage(UIImage(systemName: "backward.fill"),for: .normal)
        
        
        PlayPauseButton.tintColor = .red
        NextButton.tintColor = .red
        PrevButton.tintColor = .red

        
        holder.addSubview(PlayPauseButton)
        holder.addSubview(NextButton)
        holder.addSubview(PrevButton)


        
        //Valume Slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-55,
                                            width: holder.frame.size.width-35,
                                            height: 45))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)

        
    }

    
    @objc func didTapPlayPauseButton(){
        
    
        
    }
    @objc func didTapNexButton(){
           
       
           
       }
    @objc func didTapPrevButton(){
           
       
           
       }
    
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player{
            player.stop()
        }
    }
}
