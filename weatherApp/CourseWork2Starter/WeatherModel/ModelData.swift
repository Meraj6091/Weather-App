import Foundation
class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published  var userLocation: String = ""
    @Published var airPollution : AirPollutionModel?
    
    init() {
        self.forecast = load("london.json")
        print(userLocation)
    }
    
    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=83ad30075e8266509f5e1ee5aeef9521")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
    
        do {
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            print("forecastData: \(forecastData)")
            DispatchQueue.main.async {
                self.forecast = forecastData 
            }
            print(forecastData)
            return forecastData
        } catch {
            throw error
        }
    }
    
    func loadAirPollutionData() async throws {
        guard let lat = forecast?.lat, let lon = forecast?.lon else {
            fatalError("Coudn't find in lat & lon in forecast data")
        }
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=83ad30075e8266509f5e1ee5aeef9521")
        let session = URLSession(configuration: .default)

        let (data, _) = try await session.data(from: url!)

        do {
            let airDataLoad = try JSONDecoder().decode(AirPollutionModel.self, from: data)
            DispatchQueue.main.async {
                self.airPollution = airDataLoad  //assing fetched obj to forecast obj
            }
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
    
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}

