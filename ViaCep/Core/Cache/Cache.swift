import CryptoKit
import Foundation

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    return hashedData.compactMap { String(format: "%02x", $0) }.joined()
}

func cacheObject<T: Codable>(_ object: T, forURL url: URL) {
    do {
        let fileManager = FileManager.default
        let cacheDirectory = try fileManager.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        
        let filename = sha256(url.absoluteString) // Gerar o hash SHA256 da URL para usar como nome do arquivo
        let fileURL = cacheDirectory.appendingPathComponent(filename)

        let data = try JSONEncoder().encode(object)
        try data.write(to: fileURL)
    } catch {
        print("Erro ao fazer o cache do objeto: \(error)")
    }
}
