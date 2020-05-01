//
//  ViewController.swift
//  MusicApp
//
//  Created by Dor Levi on 25/04/2020.
//  Copyright © 2020 Dor Levi. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        
        table.delegate = self
        table.dataSource = self
    }
    func configureSongs(){
        
        songs.append(Song(name: "Loop",
                          artistName: "Amir & Ben",
                          imageName: "Cover1",
                          trackName: "song1"))
        songs.append(Song(name: "Trip",
        artistName: "New Born",
        imageName: "Cover2",
        trackName: "song2"))
        songs.append(Song(name: "Further up",
        artistName: "Static & Ben El",
        imageName: "Cover3",
        trackName: "song3"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        let song = songs[indexPath.row]
        
        //config
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController  else{
            return
        }
        
        vc.songs = songs
        vc.position = position
        present(vc,animated: true)
    }
    
}
    
    struct Song{
        let name: String
        let artistName: String
        let imageName: String
        let trackName: String
    }


  

