//
//  ListVoteViewController.swift
//  YouVote
//
//  Created by Алексей on 30.05.2021.
//

import UIKit

class ListVoteViewController: UIViewController, ListVoteViewControllerProtocol {

    var presenter: ListVoteViewPresenterProtocol!
    var timerSearch:Timer?
    var voteData = VoteResponce()
    var votes: [Vote] = []
    var curPage:Int = 1
    var isPage:Bool = true
    var textSearch = ""
  
    
    let homeScroll: UIScrollView = {
      let scroll = UIScrollView()
      scroll.isScrollEnabled = true
      scroll.showsVerticalScrollIndicator = true
      scroll.showsHorizontalScrollIndicator = false
      scroll.translatesAutoresizingMaskIntoConstraints = false
      return scroll
    }()
    
    let topicFilterLabel:UILabel = {
       let topicFilter = UILabel()
        topicFilter.font = Fonts.Text.textSemiboldFont(size: 16.0)
        topicFilter.numberOfLines = 0
        topicFilter.textAlignment = .center
        topicFilter.text = Localization.ListVote.topicFilter
        topicFilter.textColor = Colors.Common.brownColor
        topicFilter.translatesAutoresizingMaskIntoConstraints = false
        return topicFilter
    }()
     
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = Localization.ListVote.searchPlaceholder
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
  
    let listTableView: UITableView = {
        let list = UITableView()
        list.register(VoteTableViewCell.self, forCellReuseIdentifier: VoteTableViewCell.reuseId)
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = Localization.ListVote.title
        let exitItem = UIBarButtonItem(image: Images.ListVote.filter, style: .plain, target: self, action: #selector(pageOpenFilter))
        self.navigationItem.rightBarButtonItems = [exitItem]
        
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(homeScroll)
        homeScroll.addSubview(topicFilterLabel)
        homeScroll.addSubview(searchBar)
        homeScroll.addSubview(listTableView)
        
        homeScroll.refreshControl = UIRefreshControl()
        homeScroll.refreshControl?.addTarget(self, action: #selector(refreshHome(sendrer:)), for: .valueChanged)

        listTableView.delegate = self
        listTableView.dataSource = self
        
        searchBar.delegate = self
     
        setConstraints()
        self.presenter.getCurTopic()
        resetVotePage()
    }
    
    
    func resetVotePage() {
        self.curPage = 1
        self.presenter.getVote(page:  self.curPage, isPage: false, filter: [:], search:  self.textSearch)
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.isPrevShowFilterListVoteScene()
    }
  
    func setCurTopic(topic: TopicTable){
        topicFilterLabel.text = topic.name
    }
    
    @objc func pageOpenFilter(){
        self.presenter.pageOpenFilter()
    }
    
    
    @objc func refreshHome(sendrer:UIRefreshControl){
        self.resetVotePage()
        homeScroll.refreshControl?.endRefreshing()
    }
    
    func setData(voteData: VoteResponce) {
        self.isPage = true
        if self.curPage == 1 {
            self.votes = voteData.votes
        }else{
            self.votes = self.votes + voteData.votes
        }
        self.voteData = voteData
        listTableView.reloadData()
    }
    
    func showMessage(message: String) {
       self.isPage = true
       self.showAlert(message: message)
    }
    
    
    func startProgress() {
        searchBar.endEditing(true)
        self.showProgressHUD()
    }
    
    func endProgress() {
        searchBar.endEditing(false)
        listTableView.tableFooterView = nil
        self.hideProgressHUD()
    }
    
    private func setConstraints() {
    
    
        homeScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        homeScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        homeScroll.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        homeScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
     
        homeScroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        topicFilterLabel.leadingAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.leadingAnchor, constant: 0).isActive = true
        topicFilterLabel.trailingAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.trailingAnchor, constant: 0).isActive = true
       topicFilterLabel.topAnchor.constraint(equalTo: homeScroll.contentLayoutGuide.topAnchor, constant: 10).isActive = true
        topicFilterLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width ).isActive = true
        
        
      searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      searchBar.topAnchor.constraint(equalTo: topicFilterLabel.bottomAnchor, constant: 10).isActive = true
      searchBar.widthAnchor.constraint(equalToConstant: view.frame.size.width - 20).isActive = true
         
                            
      listTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
      listTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
      listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        
    }
}


extension ListVoteViewController:  UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.votes.count
    }
      
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VoteTableViewCell.reuseId, for: indexPath) as? VoteTableViewCell else {
            return UITableViewCell()
        }
        
        cell.countLabel.text = Localization.ListVote.countParam.replacingOccurrences(of: "%s", with: "\(self.votes[indexPath.row].countVote)")
        cell.dateLabel.text = Localization.ListVote.dateParam.replacingOccurrences(of: "%s", with: "\(self.votes[indexPath.row].endDate)")
        cell.questionLabel.text = self.votes[indexPath.row].question
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
           
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.onVoteDetail(vote:self.votes[indexPath.row])
    }

    
    func createSpinerFooter() -> UIView{
  
        let view = UIView(frame: CGRect(x: 0, y: 0, width:self.view.frame.size.width, height: 50))
        let spiner = UIActivityIndicatorView()
        spiner.startAnimating()
        spiner.center = view.center
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(spiner)
        return view
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.size.height {
              
                if scrollView is UITableView {
                                    
                    if isPage {
                        if voteData.isPage{
                            isPage = false
                            curPage = curPage + 1
                            listTableView.tableFooterView = self.createSpinerFooter()
                            self.presenter.getVote(page: curPage, isPage: true, filter: [:], search: textSearch)
                         }else{
                           listTableView.tableFooterView = nil
                        }
                        
                        
                    }
                    
                }
           
             }
     }
}


extension ListVoteViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        changeeSearch(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            changeeSearch(searchText: searchText)
        }
    }

    func changeeSearch(searchText:String = "") {
        timerSearch?.invalidate()
        timerSearch = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.searchAction(timer:)), userInfo: ["search": searchText], repeats: false)
    }


    @objc func searchAction(timer: Timer) {
           if  let userInfo = timer.userInfo as? [String: String],
                let search = userInfo["search"] {
                curPage = 1
                textSearch = search
                self.presenter.getVote(page: curPage, isPage: false, filter: [:], search: textSearch)
            }
    }


}

