//
//  CardSearchView + DatasourceDelegate.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 26/03/23.
//

import UIKit

extension CardSearchView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if content.count < 1 { return }
        
        //go to new Screen
    }
    
    
}

extension CardSearchView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredContent.count > 0 ? filteredContent.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCardCell.identifier, for: indexPath) as! SimpleCardCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cardCell = cell as! SimpleCardCell
        
        cardCell.configure(withData: filteredContent.count > 0 ? filteredContent[indexPath.row] : nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
}
