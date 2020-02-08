//
//  Chart_ViewController.swift
//  BienestarDigital
//
//  Created by alumnos on 22/01/2020.
//  Copyright © 2020 ivanOdP. All rights reserved.
//

import Charts
import Alamofire
import UIKit

class Chart_ViewController: UIViewController {
    
    var url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showAllAppUseToday"
    var nameArray: Array<String> = []
    var useArray: Array<Double> = []
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func segmentedControlAction(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showAllAppUseToday"
            nameArray = []
            useArray = []
            
            removeLimits()
            downloadDataFromAPI(url: url)
            break
        case 1:
            url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showAllAppUseThisWeek"
            nameArray = []
            useArray = []
            removeLimits()
            downloadDataFromAPI(url: url)
            break
        case 2:
            url = "http://localhost:8888/laravel-ivanodp/BienestarDigital/public/index.php/api/showAllAppUseThisMonth"
            nameArray = []
            useArray = []
            removeLimits()
            downloadDataFromAPI(url: url)
            break
        default:
            break
        }
    }
    
    @IBOutlet weak var barChartView: BarChartView!
    var months: [String]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadDataFromAPI(url: url)
    }
    
    
    var jsonArray: NSArray?
    var seconds = "0"
    var useDouble: Double = 0.0
    
    var sumArray = 0.0
    var avgArrayValue = 0.0
    var avgMark = ChartLimitLine()
    
    
    /// Función que crea la gráfica de barras
    ///
    /// - Parameters:
    ///   - dataPoints: Datos de tiempo de uso
    ///   - values: Nombre de las apps
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "Se necesitan datos para mostrar en el gráfico"
        var dataEntries = [BarChartDataEntry]()
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
            
        }
        removeLimits()
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Apps")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        chartDataSet.colors = ChartColorTemplates.colorful()
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.data = chartData
        
        sumArray = useArray.reduce(0.0, +)
        avgArrayValue = sumArray/Double(useArray.count)
        
        avgMark = ChartLimitLine(limit: avgArrayValue, label: "Media de uso")
        barChartView.rightAxis.addLimitLine(avgMark)
        
        
        
        
        
        
    }
    
    /// Elimina los límites de la gráfica anterior.
    func removeLimits(){
        barChartView.rightAxis.removeLimitLine(self.avgMark)
    }
    
    func downloadDataFromAPI(url: String){
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let header = ["Authorization" : user_token]
        
        Alamofire.request(url, headers: header) .responseJSON { response in
            if let JSON = response.result.value{
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary]{
                    let name = item["name"] as? String
                    self.seconds = item["seconds"] as? String ?? "0"
                    
                    self.nameArray.append((name)!)
                    let usage: Double = self.stringToDouble(seconds: self.seconds)
                    self.useArray.append(usage)
                }
                self.setChart(dataPoints: self.nameArray, values: self.useArray)
            }
        }
        
    }
    
    func stringToDouble(seconds: String)->Double{
        if seconds == "0" {
            useDouble = 0.0
            return useDouble
        } else{
            useDouble = Double(Double(seconds)!/60.0)
            return useDouble
        }
        return useDouble
    }
}

