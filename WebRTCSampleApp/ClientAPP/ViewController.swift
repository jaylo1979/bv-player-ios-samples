//
//  ViewController.swift
//  ClientAPP
//
//  Created by Tsung Cheng Lo on 2023/4/19.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var playbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play Me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        playbackButton.addTarget(self,
                                 action: #selector(handlePlaybackButton(_:)),
                                 for: .touchUpInside)
        view.addSubview(playbackButton)
        NSLayoutConstraint.activate([
            playbackButton.widthAnchor.constraint(equalToConstant: 200.0),
            playbackButton.heightAnchor.constraint(equalToConstant: 44.0),
            playbackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playbackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    func handlePlaybackButton(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: RTCDemoViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

