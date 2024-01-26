//
//  ViewController.swift
//  playVideoApp
//
//  Created by 윤규호 on 1/25/24.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var playVideoTableView: UITableView = UITableView()
    var videoData: [videoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        getURL()
        
        self.playVideoTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.playVideoTableView.dataSource = self
        self.playVideoTableView.delegate = self
        self.playVideoTableView.register(myTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(self.playVideoTableView)
        
    }
    
    func getURL() {
        let session = URLSession.shared

        if let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json") {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode([videoModel].self, from: data)
                        self.videoData = decodedData
                        // UI 갱신을 메인 스레드에서 수행
                        DispatchQueue.main.async {
                            self.playVideoTableView.reloadData()
                        }
                    } catch let error as NSError {
                        print("Error: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = playVideoTableView.dequeueReusableCell(withIdentifier: "Cell") as! myTableViewCell
        cell.selectionStyle = .none // Cell Click 시 배경색 변경 안되게 설정
        cell.textLabel?.text = self.videoData[indexPath.row].title
        print("cell.textLabel : ", self.videoData[indexPath.row].title)
        if let imageUrl = URL(string: self.videoData[indexPath.row].thumbnailUrl) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                    }
                }
            }.resume()
        }

        print("cell.imageView : ", self.videoData[indexPath.row].thumbnailUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: self.videoData[indexPath.row].videoUrl)
        
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: url!)
        
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}
