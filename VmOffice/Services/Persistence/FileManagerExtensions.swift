import Foundation

extension FileManager {
    func write<T: Encodable>(data: T, with key: String) {
        guard let file = cacheURL(with: key) else {
            return
        }

        guard let data = try? JSONEncoder().encode(data) else {
            assertionFailure("Error: Failed to serialize data!")
            return
        }

        do {
            try data.write(to: file)
            print("Saved \(key)")
        } catch {
            assertionFailure("Save failed!")
        }
    }

    func read<T: Decodable>(with key: String) -> Result<T, Error> {
        guard let url = cacheURL(with: key), self.fileExists(atPath: url.path) else {
            return .failure(PersistenceError.notPersisted(key))
        }

        guard let data = try? Data(contentsOf: url) else {
            return .failure(PersistenceError.readFailed)
        }

        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            return .failure(PersistenceError.deseralizationFailed)
        }

        return .success(decodedData)
    }

    func read<T: Decodable>(with key: String, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().async {
            guard let url = self.cacheURL(with: key), self.fileExists(atPath: url.path) else {
                completion(.failure(PersistenceError.notPersisted(key)))
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                completion(.failure(PersistenceError.readFailed))
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(PersistenceError.deseralizationFailed))
                return
            }
            
            completion(.success(decodedData))
        }
    }

    private func cacheURL(with key: String) -> URL? {
        guard let documentDirURL = try? self.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            print("Error: Failed to get the directory!")
            return nil
        }

        return documentDirURL.appendingPathComponent(key).appendingPathExtension("dat")
    }
}

