//
//  ViewController.swift
//  FayHat
//
//  Created by enes öztürk on 30.03.2023.
//

import UIKit

enum SortingOption {
    case byDate
    case byMagnitude
}

class ViewController: UIViewController {
    var viewModel = EarthquakeViewModel()
    var nm = NotificationManager()
    var currentSortingOption: SortingOption = .byDate
    var eq = [Result]()
    var sendButtonClicked = false

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        nm.requestNotificationPermission()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EarthQuakeCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    @IBAction func scDidChange(_ sender: UISegmentedControl) {
        if sendButtonClicked == true {
            switch sender.selectedSegmentIndex {
            case 0:
                currentSortingOption = .byDate
            case 1:
                currentSortingOption = .byMagnitude
            default:
                break
            }

            tableView.reloadData()
        }
    }

    @IBAction func fetchButtonPressed(_ sender: UIButton) {
        sendButtonClicked = true
        viewModel.fetchJSON { [weak self] resultArray in
            self?.eq = resultArray
            self?.nm.handleEventNotificationIfNeeded(event: resultArray)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eq.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EarthQuakeCell
        // cell.delegate = self
        var sortedResult: [Result] = []
        // let result = eq[indexPath.row]
        // let maginString = String(result.mag)
        
        switch currentSortingOption {
            
        case .byDate:
            sortedResult = eq

        case .byMagnitude:
            let uniqueResults = NSOrderedSet(array: eq.sorted(by: { $0.mag ?? 0 > $1.mag ?? 0 })).array as! [Result]
            sortedResult = uniqueResults
        }
        
        let currentResult = sortedResult[indexPath.row]
        cell.titleLabel.text = currentResult.title?.lowercased()
        cell.dateLabel.text = "date : \(currentResult.date!)"
        
        if let mag = currentResult.mag {
            //let magInt = Int(mag)
            cell.magLabel.text = "büyüklük : \(String(mag))"
            switch mag {
            case 0...1:
                cell.backgroundColor = UIColor(named: "1")
            case 1...2:
                cell.backgroundColor = UIColor(named: "2")
            case 2...3:
                cell.backgroundColor = UIColor(named: "3")
            case 3...4:
                cell.backgroundColor = UIColor(named: "4")
            case 4...5:
                cell.backgroundColor = UIColor(named: "5")
            case 5...6:
                cell.backgroundColor = UIColor(named: "6")
            case 6...7:
                cell.backgroundColor = UIColor(named: "7")
            case 7...8:
                cell.backgroundColor = UIColor(named: "8")
            case 8...9:
                cell.backgroundColor = UIColor(named: "9")
            default: break
            }
        }

//        if let magValue = Double(result) {
//            cell.magLabel.text = String(magValue)
//        } else {
//            print("Error: could not convert mag property to a numeric value")
//        }

        // cell.magLabel.text = String(describing: result.mag)
        // cell.magLabel.text = "büyüklük : \(maginString)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMapVC", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let indexPath = sender as? IndexPath {
            let mapVC = segue.destination as! MapViewController
            mapVC.eqDetails = eq
        }
    }
}
