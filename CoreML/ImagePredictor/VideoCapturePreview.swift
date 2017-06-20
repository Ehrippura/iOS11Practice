//
//  VideoCapturePreview.swift
//  ImagePredictor
//
//  Created by Wayne Lin on 2017/6/16.
//  Copyright © 2017年 Kingwaytek. All rights reserved.
//

import UIKit
import AVFoundation

class VideoCapturePreview: UIView {

    var captureLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        captureLayer.videoGravity = .resize
    }
}
