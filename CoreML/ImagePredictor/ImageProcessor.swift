//
//  ImageProcessor.swift
//  ImagePredictor
//
//  Created by Tzu-Yi Lin on 2017/6/16.
//  Copyright © 2017年 Kingwaytek. All rights reserved.
//

import Foundation
import CoreImage
import CoreVideo

struct ImageProcessor {

    static func pixelBuffer(from ciImage: CIImage, size: CGSize) -> CVPixelBuffer? {

        var pixelBuffer: CVPixelBuffer? = nil

        CVPixelBufferCreate(kCFAllocatorDefault,
                            Int(size.width),
                            Int(size.height),
                            kCVPixelFormatType_32BGRA,
                            nil, &pixelBuffer)

        guard let buffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])

        let ciContext = CIContext(options: nil)
        ciContext.render(ciImage, to: buffer)

        CVPixelBufferUnlockBaseAddress(buffer, [])

        return buffer
    }
}
