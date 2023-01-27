//
//  ViewController.swift
//  SampleProject
//
//  Created by neosoft on 24/01/23.
//

import UIKit

//MARK: Scroll view delgates
extension ViewController: UIScrollViewDelegate {
    //MARK: configure page number of horizontal scroll item
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == horizontalScroll {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageController.currentPage = Int(pageNumber)
            Constant.selectedIndex = Int(pageNumber)
            setscrollItemOfSelectedIndex()
        }
    }
    
    //MARK: This method used for search bar top configuration
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Constant.isKeyboardVisible {
            searchBar.resignFirstResponder()
        } else {
            Constant.isKeyboardVisible = true
        }
        
        if scrollView != horizontalScroll {
            if scrollView.contentOffset.y > Constant.searchBarYpos {
                let value = scrollView.contentOffset.y - Constant.searchBarYpos
                constTopSearchBar.constant = Constant.searchBarYpos + value
                constTopTableview.constant = Constant.tableviewYpos + Double(Constant.space)
                viewBg.bringSubviewToFront(searchBar)
            } else {
                constTopSearchBar.constant = Constant.searchBarYpos
                constTopTableview.constant = Constant.tableviewYpos
            }
            if scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y = 0
            }
        }
    }
}

