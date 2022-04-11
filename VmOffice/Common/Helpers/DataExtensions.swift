import Foundation

extension Data {
    func parse<Model: Decodable>() -> Result<Model, Error> {
        let decoder = JSONDecoder()
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601withFractionalSeconds

        do {
            return .success(try decoder.decode(Model.self, from: self))
        } catch {
            let decodingError = error as? DecodingError
            let descr = decodingError?.description ?? "\(error)"

            print(descr)
            return .failure(error)
        }
    }
}
