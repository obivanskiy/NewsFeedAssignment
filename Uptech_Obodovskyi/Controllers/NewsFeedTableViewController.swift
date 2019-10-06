//
//  ViewController.swift
//  Uptech_Obodovskyi
//
//  Created by Ivan Obodovskyi on 10/2/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import RealmSwift

//"ArticleDetails"
class NewsFeedTableViewController: UITableViewController {
  
  private var viewModel: NewsFeedPresenter?
  
  private var articles: Results<ArticleObject>? {
    didSet {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
        self?.tableRefreshControl.endRefreshing()
      }
    }
  }
  
  lazy var tableRefreshControl: UIRefreshControl = {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
    
    return refresh
  }()
  
  private var notificationToken: NotificationToken?
  
  override func viewDidLoad() {
    NotificationCenter.default.addObserver(self, selector: #selector(requestError), name: NotificationEndpoints.requestError, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(fetchArtcilesFromDatabase), name: NotificationEndpoints.articleDataFetched, object: nil)
    viewModel = NewsFeedPresenter()
    setUpRefreshControl()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    notificationToken?.invalidate()
  }
  
  private func setUpRefreshControl() {
    DispatchQueue.main.async {
      self.tableView.refreshControl = self.tableRefreshControl

    }
}
  
  
  @objc private func fetchArtcilesFromDatabase() {
    DispatchQueue.main.async { [weak self] in
      self?.articles = self?.viewModel?.fetchArticlesFromDatabase()
    }
  }
  
  @objc private func refreshTableData(_ sender: UIRefreshControl) {
    sender.beginRefreshing()
    fetchArtcilesFromDatabase()
  }
  
  @objc private func requestError() {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "Request Error", message: "Please, check your internet connection or try again later.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
        self?.fetchArtcilesFromDatabase()
      }
      alert.addAction(okAction)
      
      self.present(alert, animated: true, completion: nil)
    }
  }
}

extension NewsFeedTableViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let articles = articles else { return 0}
    return articles.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier) as? NewsFeedTableViewCell else { return UITableViewCell() }
    
    if let data = articles?[indexPath.row] {
        cell.setUpCellData(from: data)
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.articleDetails) as! ArticleViewController
    
    if let article = self.articles?[indexPath.row] {
      vc.articleDetails = article
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}


