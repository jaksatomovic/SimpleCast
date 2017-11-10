//
//  ViewController.swift
//  SimpleCast
//
//  Created by Jakša Tomović on 08/11/2017.
//  Copyright © 2017 Jakša Tomović. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import CodableAlamofire


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
let APP_ID = "b7282b40e9db1bc04cb2a422d3d5b12e"


class MainController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Croatia"
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "--"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 80)
        return label
    }()
    

    
    lazy var sunriseIconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunrise").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var windSpeedIconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "wind").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var humidityIconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "humidity").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var humidityPercentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    
    lazy var moreInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(locationLabel)
        view.addSubview(iconImage)
        view.addSubview(temperatureLabel)
        view.addSubview(moreInfoView)
        moreInfoView.addSubview(sunriseTimeLabel)
        moreInfoView.addSubview(humidityPercentLabel)
        moreInfoView.addSubview(windSpeedLabel)
        moreInfoView.addSubview(sunriseIconImage)
        moreInfoView.addSubview(humidityIconImage)
        moreInfoView.addSubview(windSpeedIconImage)
        
        locationLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: iconImage.topAnchor, right: nil, topConstant: 36, leftConstant: view.frame.width/2-50, bottomConstant: 44, rightConstant: 0, widthConstant: 100, heightConstant: 20)
        iconImage.anchor(locationLabel.bottomAnchor, left: view.leftAnchor, bottom: temperatureLabel.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: view.frame.width/2-100, bottomConstant: -50, rightConstant: view.frame.width/2-100, widthConstant: 200, heightConstant: 200)
        temperatureLabel.anchor(iconImage.bottomAnchor, left: iconImage.leftAnchor, bottom: nil, right: iconImage.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        view.bringSubview(toFront: temperatureLabel)
        moreInfoView.anchor(temperatureLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: view.frame.width/2-55, bottomConstant: 0, rightConstant: view.frame.width/2-55, widthConstant: 110, heightConstant: 110)
        sunriseIconImage.anchor(moreInfoView.topAnchor, left: moreInfoView.leftAnchor, bottom: humidityIconImage.topAnchor, right: sunriseTimeLabel.leftAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 12, rightConstant: 0, widthConstant: 22, heightConstant: 22)
        humidityIconImage.anchor(sunriseIconImage.bottomAnchor, left: moreInfoView.leftAnchor, bottom: windSpeedIconImage.topAnchor, right: humidityPercentLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 0, widthConstant: 22, heightConstant: 22)
        windSpeedIconImage.anchor(humidityIconImage.bottomAnchor, left: moreInfoView.leftAnchor, bottom: nil, right: windSpeedLabel.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 22, heightConstant: 22)
        
        sunriseTimeLabel.anchor(sunriseIconImage.topAnchor, left: sunriseIconImage.rightAnchor, bottom: nil, right: moreInfoView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 22)
        
        humidityPercentLabel.anchor(humidityIconImage.topAnchor, left: humidityIconImage.rightAnchor, bottom: nil, right: moreInfoView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 22)
        
        windSpeedLabel.anchor(windSpeedIconImage.topAnchor, left: windSpeedIconImage.rightAnchor, bottom: nil, right: moreInfoView.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 22)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count-1] as CLLocation
        
        if(location.horizontalAccuracy > 0) {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            self.updateWeatherInfo(latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude)
            locationManager.stopUpdatingLocation()
        }
    }
    
   
    
    func updateWeatherInfo(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        
        //        let parameters: Parameters = ["lat":latitude, "lon":longtitude, "appid": APP_ID]
        let url = BASE_URL + "?lat=\(latitude)&lon=\(longtitude)&appid=\(APP_ID)"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        
        Alamofire.request(url).responseDecodableObject(keyPath: nil, decoder: decoder) { (response: DataResponse<Forecast>) in
            let weatherResponse = response.result.value
            self.updateUISuccess(weatherObject: weatherResponse!)
        }
        
    }
    
    
    func updateUISuccess(weatherObject: Forecast) {
        
//        self.conditionLabel.text = weatherObject.weather?.description.uppercased()

        self.locationLabel.text = weatherObject.name!

        let weatherId = weatherObject.weather![0].id!
        self.updateWeatherIcon(weatherId: weatherId)
 
        if let tempResult = weatherObject.main?.temp {
            let temp = Int(round(tempResult - 273.15))
            self.temperatureLabel.text = "\(temp)°"
        }
        
        let unixTime = weatherObject.sys?.sunrise!
        let utcTime = changeUTCtoDate(timeStamp: unixTime!)
        self.sunriseTimeLabel.text = utcTime as String
        
        self.windSpeedLabel.text = "\(weatherObject.wind?.speed! ?? 0) km/h"

        self.humidityPercentLabel.text = "\(weatherObject.main?.humidity! ?? 0)%"
        
        
    }
    
    
    func updateWeatherIcon(weatherId: Int) {
        var imageName:String
        switch weatherId {
        case 200..<300:
            imageName = "thunderstorm"
        case 300..<400:
            imageName = "drizzle"
        case 500..<600:
            imageName = "rainy"
        case 700..<800:
            imageName = "snowy"
        case 800:
            imageName = "sunny"
        case 801..<805:
            imageName = "cloudy"
        default:
            imageName = "default"
            break
        }
        self.iconImage.image = UIImage(named: imageName)
    }
    
    func changeUTCtoDate(timeStamp:Int) -> String{
        let date = NSDate(timeIntervalSince1970: Double(timeStamp))
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: date as Date)
        return str
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

