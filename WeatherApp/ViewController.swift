//
//  ViewController.swift
//  WeatherApp
//
//  Created by 이정찬 on 2022/06/11.
//

import UIKit

class ViewController: UIViewController {
    // 받아온 데이터를 저장할 프로퍼티
        var weather: Weather?
        var main: Main?
        var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // data fetch
                WeatherService().getWeather { result in
                    switch result {
                    case .success(let weatherResponse):
                        DispatchQueue.main.async {
                            self.weather = weatherResponse.weather.first
                            self.main = weatherResponse.main
                            self.name = weatherResponse.name
                            self.setWeatherUI()
                        }
                    case .failure(_ ):
                        print("error")
                    }
                }
    }
    
    //api접근 함수
    private var apiKey: String {
        get {
            // 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find file 'KeyList.plist'.")
            }
            
            // .plist를 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 값 찾기
            guard let value = plist?.object(forKey: "OPENWEATHERMAP_KEY") as? String else {
                fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.")
            }
            return value
        }
    }

    private func setWeatherUI() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(self.weather?.icon ?? "00")@2x.png")
        let data = try? Data(contentsOf: url!)
    }

}

