//
//  AboutUsViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 13/04/1444 AH.
//

import UIKit


class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    let theme: AppTheme = NewsAppTheme()
    weak var aboutUsPageViewController: AboutUsPageViewController?
    var transitionDirection: UIPageViewController.NavigationDirection = .forward
    var currentIndex = 0 {
        didSet {
            if oldValue > currentIndex {
                transitionDirection = .reverse
            } else {
                transitionDirection = .forward
            }
            pageControl.currentPage = currentIndex
            checkButtonsVisibility()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        checkButtonsVisibility()
    }
    
    // MARK: - Private Helpers
    
    private func styleElements() {
        
        previousBtn.setTitle("Previous", for: .normal)
        nextBtn.setTitle("Next", for: .normal)
        
        previousBtn.titleLabel?.font = theme.font.titleFourFont
        nextBtn.titleLabel?.font = theme.font.titleFourFont
        
        previousBtn.tintColor = theme.color.grayLightColor9fa1a1
        nextBtn.tintColor = theme.color.orangeLightColorEC8B3F
        
        previousBtn.isHidden = true
        
        pageControl.pageIndicatorTintColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = theme.color.orangeLightColorEC8B3F
        pageControl.numberOfPages = AboutUsSections.allCases.count
    }
    
    private func setPageViewController() {
        if let firstViewController = aboutUsPageViewController?.contentViewController(at: currentIndex) {
            aboutUsPageViewController?.setViewControllers([firstViewController], direction: transitionDirection, animated: true, completion: nil)
            
        }
    }
    
    private func checkButtonsVisibility() {
        if currentIndex == 0 {
            previousBtn.isHidden = true
        } else {
            previousBtn.isHidden = false
        }
        if currentIndex == 2 {
            nextBtn.isHidden = true
        } else {
            nextBtn.isHidden = false
        }
    }
    
    // MARK: - User Actions
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        currentIndex -= 1
        setPageViewController()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        currentIndex += 1
        setPageViewController()
    }
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        currentIndex = sender.currentPage
        setPageViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aboutUsPageViewController = segue.destination as? AboutUsPageViewController {
            aboutUsPageViewController.pageViewControllerDelagate = self
            self.aboutUsPageViewController = aboutUsPageViewController
        }
    }
}

// MARK: - AboutUsPageViewControllerDelegate

extension AboutUsViewController: AboutUsPageViewControllerDelegate {
    
    func turnPageController(to index: Int) {
        pageControl.currentPage = index
        currentIndex = index
    }
    
}
