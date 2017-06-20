//
//  ViewController.swift
//  ImagePredictor
//
//  Created by Wayne Lin on 2017/6/16.
//  Copyright © 2017年 Kingwaytek. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var previewView: VideoCapturePreview!

    @IBOutlet weak var predictLabel: UILabel!

    let capture = VideoCapture()

    private let model = GoogLeNetPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()
        capture.delegate = self
        capture.addPreviewLayer(layer: previewView.captureLayer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        capture.startSession()
    }
}

extension ViewController: VideoCaptureDelegate {
    func capture(_ capture: VideoCapture, didCaptureImageBuffer buffer: CVPixelBuffer) {
        if let predication = try? model.prediction(sceneImage: buffer) {
            DispatchQueue.main.async {
                self.predictLabel.text = predication.sceneLabel + String(format: " (%.1f%%)", (predication.sceneLabelProbs[predication.sceneLabel] ?? 0) * 100)
            }
        }
    }
}

