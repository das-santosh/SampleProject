//
//  ViewController.swift
//  SampleProject
//
//  Created by neosoft on 24/01/23.
//

import UIKit

//MARK: TableViewDelagates
extension ViewController: UITableViewDataSource {
    //MARK: This method returning number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data?.count ?? 0
    }
    
    //MARK: configuring visible cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarousalDetailsCell", for: indexPath) as! CarousalDetailsCell
        if let object = viewModel.data?[indexPath.row] {
            cell.configureData(object)
        }
        return cell
    }
    
    //MARK: returning automatic height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



