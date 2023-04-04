//
//  CardSearchView + DatasourceDelegate.swift
//  HearthStoneAPI
//
//  Created by Lugalu on 26/03/23.
//

import UIKit

extension CardSearchView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter, presenter.filteredContent.count > 1, let card = presenter.filteredContent[safe: indexPath.row]  else { return }
        
        let view = CardDetailsRouter.getView(withCard: card)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
}

extension CardSearchView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 10 }
        return presenter.filteredContent.count > 0 ? presenter.filteredContent.count : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCardCell.identifier, for: indexPath) as! SimpleCardCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cardCell = cell as? SimpleCardCell
        cardCell?.configure(withData: presenter?.filteredContent[safe: indexPath.row])
    }
    
}
