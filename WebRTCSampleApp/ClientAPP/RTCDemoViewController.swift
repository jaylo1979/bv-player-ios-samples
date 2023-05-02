//
//  RTCDemoViewController.swift
//  KKSPlayerSample
//
//  Created by Tsung Cheng Lo on 2023/4/17.
//

import UIKit
import KKSPlayer

struct RTCConstants {
    static let rtcUrl = "https://cloudfront-webrtc.kkstream.tech/api/whep/MykTR3/02177c62bcad4592b9271c9d5c1cff84"
    static let rtcToken = "50ca0998cd8287830edd3bc3037448d06394978d0f48abad7032f3a6b8aff46f"
}

class RTCDemoViewController: UIViewController {

    let labelSubscribeStart = "Start Subscribe"
    let labelSubscribeStop = "Stop Subscribe"
    let labelAudioMute = "Mute Audio"
    let labelAudioUnmute = "Unmute Audio"

    var rtcRenderView: RTCRenderView!
    var rtcPlayer: RTCPlayer!
    
    var rtcUrl: String = RTCConstants.rtcUrl
    var rtcToken: String = RTCConstants.rtcToken
    
    var isAudioTrackEnabled: Bool = true

    var volume: Float = 0.0 {
        didSet {
            rtcPlayer?.volume = oldValue
        }
    }

    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [startButton, enableAudioTrackButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        return view
    }()

    lazy var startButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        button.setTitle(labelSubscribeStart, for: .normal)
        return button
    }()

    lazy var enableAudioTrackButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(enableAudioTrack(_:)), for: .touchUpInside)
        button.setTitle(labelAudioMute, for: .normal)
        return button
    }()

    let volumeBar: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.maximumValueImage = UIImage(systemName: "speaker.plus")
        slider.minimumValueImage = UIImage(systemName: "speaker.minus")
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Web RTC Demo"
        view.backgroundColor = .darkGray

        let closeButton = UIBarButtonItem(barButtonSystemItem: .close,
                                          target: self,
                                          action: #selector(dismiss(_:)))
        navigationItem.rightBarButtonItems = [closeButton]

        /// Create RTC subscriber with the config
        rtcPlayer = RTCPlayer()
        rtcRenderView = RTCRenderView(player: rtcPlayer)
        rtcRenderView.translatesAutoresizingMaskIntoConstraints = false
        rtcRenderView.delegate = self

        /// Setup UIs
        volumeBar.addTarget(self, action: #selector(onValueChanged(_:)), for: .valueChanged)
        volumeBar.value = 0.5

        view.addSubview(rtcRenderView)
        view.bringSubviewToFront(rtcRenderView)
        view.addSubview(volumeBar)
        view.addSubview(stackView)
        addConstraints()
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            rtcRenderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rtcRenderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rtcRenderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rtcRenderView.bottomAnchor.constraint(equalTo: volumeBar.topAnchor, constant: -8.0)
        ])

        NSLayoutConstraint.activate([
            volumeBar.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0
            ),
            volumeBar.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0
            ),
            volumeBar.bottomAnchor.constraint(
                equalTo: stackView.topAnchor, constant: -8.0
            )
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc
    func dismiss(_ sender: UIBarButtonItem) {
        rtcPlayer.destroy()
        navigationController?.dismiss(animated: true)
    }

    @objc
    func start(_ sender: UIButton) {
        if !rtcPlayer.isSubscribed {
            guard let url = URL(string: rtcUrl),
                  let config = RTCSourceConfig(url: url, token: rtcToken) else {
                print("RTC URL is invalid")
                return
            }
            rtcPlayer.load(sourceConfig: config)
            sender.setTitle(labelSubscribeStop, for: .normal)
        } else {
            rtcPlayer.unload()
            sender.setTitle(labelSubscribeStart, for: .normal)
        }
    }

    @objc
    func enableAudioTrack(_ sender: UIButton) {
        isAudioTrackEnabled.toggle()
        rtcPlayer.isMuted = isAudioTrackEnabled
        sender.setTitle(isAudioTrackEnabled ? labelAudioMute : labelAudioUnmute, for: .normal)
    }

    @objc
    func onValueChanged(_ sender: UISlider) {
        volume = sender.value
    }
}

extension RTCDemoViewController: RTCRenderViewEventDelegate {

    func rednerView(_ view: RTCRenderView, didTapAtPoint point: CGPoint) {
        debugPrint("#### x=\(point.x) y =\(point.y)")
    }
}
