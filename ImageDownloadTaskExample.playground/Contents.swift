import UIKit

enum JeongNetworkError: Error {
    case apiError
    case imageDownloadError
    case alreadyExistSessionError
    case urlError
}

actor ImageDownloader {

    private enum CacheEntry {
        case inProgress(Task<UIImage?, Error>)
        case ready(UIImage?)
    }

    private var cache: [URL: CacheEntry] = [:]

    func image(from url: URL) async throws -> UIImage? {
        if let cached = cache[url] {
            switch cached {
            case .ready(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }

        let task = Task {
            try await downloadImage(from: url)
        }

        cache[url] = .inProgress(task)

        do {
            let image = try await task.value
            cache[url] = .ready(image)
            return image
        } catch {
            cache[url] = nil
            throw error
        }
    }
    
    func cancel(url: URL) {
        if let cached = cache[url] {
            switch cached {
            case .inProgress(let task):
                if !task.isCancelled {
                    task.cancel()
                }
            default: break
            }
        }
    }
    
    func downloadImage(from url: URL) async throws -> UIImage? {
        return try await withCheckedThrowingContinuation { continuation in
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let self = self else {
                    continuation.resume(with: .failure(JeongNetworkError.apiError))
                    return
                }
                
                if let error = error {
                    continuation.resume(with: .failure(error))
                    return
                }
                
                guard let httpURLResponse = response as? HTTPURLResponse, (200..<400) ~= httpURLResponse.statusCode,
                      let data = data else {
                    continuation.resume(with: .failure(JeongNetworkError.imageDownloadError))
                    return
                }
                
                print("HERE")
                let image = UIImage(data: data)
                continuation.resume(with: .success(image))
            }
            task.resume()
        }
    }
}

//private let testItem: [String] = (100...200).map { "https://picsum.photos/\($0)" }
private let testItem: [String] = Array(repeating: "https://picsum.photos/100", count: 100)
let imageDownloader = ImageDownloader()


for str in testItem {
    guard let url = URL(string: str) else { continue }
    
    Task {
       do {
           let image = try await imageDownloader.image(from: url)
           print("image: \(image)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
