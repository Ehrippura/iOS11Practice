//
//  VideoCapture.swift
//  ImagePredictor
//
//  Created by Wayne Lin on 2017/6/16.
//  Copyright © 2017年 Kingwaytek. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

@objc protocol VideoCaptureDelegate: class {
    func capture(_ capture: VideoCapture, didCaptureImageBuffer buffer: CVPixelBuffer)
}

class VideoCapture: NSObject {

    private let session = AVCaptureSession()

    private let videoOutput = AVCaptureVideoDataOutput()

    private let videoProcessingQueue = DispatchQueue(label: "videoQueue", qos: .utility)

    var delegate: VideoCaptureDelegate?

    override init() {
        super.init()
        configSession()
    }

    private func configSession() {

        session.beginConfiguration()

        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)

                if session.canAddInput(input) {
                    session.addInput(input)
                } else {
                    throw NSError()
                }

                let output = AVCaptureVideoDataOutput()
                output.alwaysDiscardsLateVideoFrames = true
                output.setSampleBufferDelegate(self, queue: videoProcessingQueue)

                if session.canAddOutput(output) {
                    session.addOutput(output)
                } else {
                    throw NSError()
                }

            } catch {
                fatalError("cannot create video session")
            }
        }

        session.commitConfiguration()
    }

    func addPreviewLayer(layer: AVCaptureVideoPreviewLayer) {
        layer.session = session
    }

    func startSession() {
        session.startRunning()
    }

    func stopSession() {
        session.stopRunning()
    }
}

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if let buffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            let size = CVImageBufferGetCleanRect(buffer).size
            var ciImage = CIImage(cvImageBuffer: buffer)
            ciImage = ciImage.applying(CGAffineTransform(scaleX: 224.0 / size.width, y: 224.0 / size.height))
            if let imageBuffer = ImageProcessor.pixelBuffer(from: ciImage, size: CGSize(width: 224.0, height: 224.0)) {
                delegate?.capture(self, didCaptureImageBuffer: imageBuffer)
            }
        }
    }
}
