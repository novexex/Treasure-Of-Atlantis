
import UIKit

extension UIImage {
    func noir() -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectMono") {
            filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            if let output = filter.outputImage,
               let cgImage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
            }
        }
        return nil
    }
}
