//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    
    
    var searchBar: UISearchBar!
    var businesses: [Business]!
    var searchSettings : SearchSettings!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BusinessTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BusinessTableViewCell")
        //tableView.rowHeight = UITableViewAutomaticDimension
        searchSettings = SearchSettings()
        
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        
        navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        self.executeSearch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.searchSettings =  searchSettings.copy() as! SearchSettings
        settingsViewController.delegate = self
        
    }
    
    func executeSearch() {
        searchSettings.executeSearch(completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            }
        )
    }
    
  
 
    
}


extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.businesses ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath as IndexPath) as! BusinessTableViewCell
        

        cell.business = businesses![indexPath.row]
        cell.repaint()

        
        return cell
    }
    
}

extension BusinessesViewController: SettingsViewControllerDelegate{
    func settingsViewControllerDidSaveSettings(controller: SettingsViewController, newValue: SearchSettings) {
        self.searchSettings = newValue
        self.executeSearch()
    }
}

// SearchBar methods
extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchSettings.searchTerm = searchBar.text!
        self.executeSearch()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchSettings.searchTerm = searchBar.text!
        self.executeSearch()
        searchBar.resignFirstResponder()
    }
}
