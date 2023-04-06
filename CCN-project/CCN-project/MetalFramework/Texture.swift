import Foundation
import Metal

public class Texture {
    let texture: MTLTexture
    let textureKey: String

    public init(texture: MTLTexture, textureKey: String = "") {
        self.texture = texture
        self.textureKey = textureKey
    }

    public convenience init(_ width: Int, _ height: Int, pixelFormat: MTLPixelFormat = .bgra8Unorm, textureKey: String = "") {
        let textureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: pixelFormat,
                                                                         width: width,
                                                                         height: height,
                                                                         mipmapped: false)
        textureDescriptor.usage = [.renderTarget, .shaderRead, .shaderWrite]

        guard let newTexture = sharedMetalRenderingDevice.device.makeTexture(descriptor: textureDescriptor) else {
            fatalError("Could not create texture of size: (\(width), \(height))")
        }

        self.init(texture: newTexture, textureKey: textureKey)
    }
}
