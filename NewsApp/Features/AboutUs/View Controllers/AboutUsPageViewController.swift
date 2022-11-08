//
//  AboutUsPageViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 13/04/1444 AH.
//

import UIKit

protocol AboutUsPageViewControllerDelegate: AnyObject {
    func turnPageController(to index: Int)
}

class AboutUsPageViewController: UIPageViewController {
    
    weak var pageViewControllerDelagate: AboutUsPageViewControllerDelegate?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPageViewController()
    }
    
    // MARK: - Private Helpers
    
    private func setUpPageViewController() {
        dataSource = self
        delegate = self
        
        if let firstViewController = contentViewController(at: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource and Delegate

extension AboutUsPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = (viewController as? AboutUsContentViewController)?.index {
            return contentViewController(at: index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = (viewController as? AboutUsContentViewController)?.index{
            return contentViewController(at: index + 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let pageContentViewController = pageViewController.viewControllers?.first as? AboutUsContentViewController {
            currentIndex = pageContentViewController.index
            self.pageViewControllerDelagate?.turnPageController(to: currentIndex)
        }
    }
    
    
    func contentViewController(at index: Int) -> AboutUsContentViewController? {
        if index < 0 || index >= AboutUsSections.allCases.count {return nil}
        
        if let pageContentViewController = UIStoryboard.aboutUs.instantiateViewController(withIdentifier: "AboutUsContentViewController") as? AboutUsContentViewController {
            pageContentViewController.section = AboutUsSections.allCases[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
}
