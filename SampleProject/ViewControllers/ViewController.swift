//
//  ViewController.swift
//  SampleProject
//
//  Created by neosoft on 24/01/23.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Variable Declaration
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var constEqualSize: NSLayoutConstraint!
    @IBOutlet weak var constTopSearchBar: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var constTopTableview: NSLayoutConstraint!
    @IBOutlet weak var verticalScrollView: UIScrollView!
    @IBOutlet weak var constEqualWidth: NSLayoutConstraint!
    @IBOutlet weak var horizontalScrollView: UIView!
    @IBOutlet weak var horizontalScroll: UIScrollView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: setup UI related components
    private func setupUI() {
        pageController.numberOfPages = viewModel.carousalData?.count ?? 0
        createTopHeader()
        listTableView.register(UINib(nibName: "CarousalDetailsCell", bundle: nil), forCellReuseIdentifier: "CarousalDetailsCell")
        constEqualSize.constant = CGFloat(((viewModel.carousalData?[Constant.selectedIndex].details?.count ?? 0) - Constant.visibleCell) * Constant.cellHeight) + CGFloat(Constant.space)
    }
    
    //MARK: Creating Header carousal using scroll view
    private func createTopHeader() {
        pageController.transform = CGAffineTransform(scaleX: 2, y: 2)
        guard let count = viewModel.carousalData?.count else { return }
        constEqualWidth.constant = CGFloat(Int(UIScreen.main.bounds.size.width) * (count-1))
        var X = 40
        if let carouselData = viewModel.carousalData {
            for obj in carouselData {
                let imageView = UIImageView(frame: CGRect(x: X, y: 10, width: Int(UIScreen.main.bounds.size.width)-Constant.cellHeight, height: Constant.scrollViewHeight-Constant.trailing))
                imageView.image = UIImage(named: obj.headerImage ?? "")
                imageView.layer.masksToBounds = true
                imageView.layer.cornerRadius = 10
                horizontalScrollView.addSubview(imageView)
                X += Int(imageView.bounds.size.width)+Constant.trailing
            }
            viewBg.bringSubviewToFront(pageController)
        }
    }
    
    //MARK: Pagecontroller(dot) clicked action
    @IBAction func pageControllerAction(_ sender: UIPageControl) {
        Constant.selectedIndex = Int(sender.currentPage)
        setscrollItemOfSelectedIndex()
    }
    
    //MARK: This method is used to set header carusel data item and Reload list data according to carusel header item
    public func setscrollItemOfSelectedIndex() {
        if ((viewModel.carousalData?[Constant.selectedIndex].details?.count ?? 0) > Constant.visibleCell) {
            constEqualSize.constant = CGFloat(((viewModel.carousalData?[Constant.selectedIndex].details?.count ?? 0) - Constant.visibleCell) * Constant.cellHeight) + CGFloat(Constant.space)
        } else {
            constEqualSize.constant = 0
        }
        searchBar.text = ""
        guard let details = viewModel.carousalData?[Constant.selectedIndex].details else { return }
        viewModel.data = details
        viewModel.listData = details
        listTableView.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.horizontalScroll.contentOffset.x = CGFloat((Int(UIScreen.main.bounds.size.width)-Constant.scrollLeftMargin) * Constant.selectedIndex)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: This method is used to Adjusting listview and scrollview after searching data
    private func setupScrollPosition() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
            if self.verticalScrollView.contentOffset.y >= Constant.searchBarYpos {
                Constant.isKeyboardVisible = false
                self.verticalScrollView.contentOffset.y = Constant.searchBarYpos
            }
        }
    }
}

//MARK: Searchbar delegates
extension ViewController: UISearchBarDelegate {
    //MARK: This method is used to search the product from the product list
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let workItem = DispatchWorkItem {
            self.viewModel.filterProduct(text: searchText)
            self.setupScrollPosition()
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(30), execute: workItem)
    }
    
    //MARK: This method is used when search button clicked from keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


