import Foundation
import Tagged

typealias GammaCache = [Int: [UInt8]]

final class GammaEncryptor: Encryption {
  private static let gammaCacheFile = "gammaCache.json"
  private var gammaCache: GammaCache = [:]

  init() {
    loadCache()
  }

  func encrypt(_ text: String) -> Tagged<Encrypted, String> {
    let textData = Array(text.utf8)
    let gamma = generateGamma(length: textData.count)

    var encryptedData = [UInt8]()
    for (index, byte) in textData.enumerated() {
      encryptedData.append(byte ^ gamma[index])
    }

    let string = Data(encryptedData).base64EncodedString()
    return Tagged<Encrypted, String>(string)
  }

  private func generateGamma(length: Int) -> [UInt8] {
    if let cached = gammaCache[length] {
      assert(cached.count == length)
      return cached
    } else {
      var gamma = [UInt8]()
      for _ in 0..<length {
        gamma.append(UInt8(arc4random_uniform(256)))
      }
      gammaCache[length] = gamma
      saveCache()
      return gamma
    }
  }

  private func loadCache() {
    if let data = try? Data(contentsOf: getFilePath()) {
      if let decoded = try? JSONDecoder().decode(GammaCache.self, from: data) {
        gammaCache = decoded
      }
    }
  }

  private func saveCache() {
    if let encoded = try? JSONEncoder().encode(gammaCache) {
      try? encoded.write(to: getFilePath())
    }
  }

  private func getFilePath() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0].appendingPathComponent(GammaEncryptor.gammaCacheFile)
  }
}
