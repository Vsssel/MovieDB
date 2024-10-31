import Foundation
import UIKit

class NetworkingManager {
    static let shared = NetworkingManager()
    private let apiKey = "6554c74af13dcfd22ad84f0d6003da73"
    
    private let imageUrl = "https://media.themoviedb.org/t/p/w220_and_h330_face/"
    
    private let session = URLSession(configuration: .default)
    
    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        return components
    }()
    
    init() {}
}

extension NetworkingManager {
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        urlComponents.path = "/3/movie/popular"
        guard let url = urlComponents.url else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let datas = try JSONDecoder().decode(Movies.self, from: data)
                DispatchQueue.main.async {
                    completion(datas.results)
                }
            } catch {
                print("Failed to decode movies: \(error)")
            }
        }
        task.resume()
    }
    
    func getMovieDetails(id: Int, completion: @escaping (MovieDetail) -> Void) {
            urlComponents.path = "/3/movie/\(id)"
            guard let url = urlComponents.url else { return }
            
            let task = session.dataTask(with: url) { data, response, error in
                guard let data, let response else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                do {
                    let datas = try JSONDecoder().decode(MovieDetail.self, from: data)
                    DispatchQueue.main.async {
                        completion(datas)
                    }
                    
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    
    func loadImage(posterPath: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl + posterPath) else {
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
