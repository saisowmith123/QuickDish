//  Vardan Malik - varmmalik@iu.edu
//  Sai Sowmith Reddy Katkuri – skatkuri@iu.edu
//  QuickDish
//  05/07/2025 04:15 AM
//
//  IngredientsViewController.swift
//  QuickDish
//
//  Created by Vardan Malik on 05/04/25.
//

import UIKit

class IngredientsViewController: UIViewController, UIScrollViewDelegate {

    // MARK: – Public API
    var selectedRecipe: RecipeModel!

    // MARK: – IBOutlets (hook these up in storyboard)
    @IBOutlet private weak var startPauseButton: UIButton!

    // MARK: – UI Elements

    private let heroImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let vev = UIVisualEffectView(effect: blur)
        vev.translatesAutoresizingMaskIntoConstraints = false
        return vev
    }()

    private let metadataStack: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.spacing = 16
        s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let contentStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 24
        s.alignment = .fill
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private var ingredientButtons = [UIButton]()
    private var checkedStates = [Bool]()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    private let timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = .white
        lbl.text = "00:00"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    // MARK: – Timer State

    private var cookTimer: Timer?
    private var elapsedSeconds = 0
    private var totalSeconds = 0

    // MARK: – Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        guard selectedRecipe != nil else {
            fatalError("selectedRecipe must be provided")
        }
        
        configureNavBar()
        setupUI()
        
        // Style the storyboard button
        startPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        startPauseButton.tintColor = .systemGreen
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Make sure the button is on top
        view.bringSubviewToFront(startPauseButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentStack.alpha = 0
        UIView.animate(withDuration: 0.6) {
            self.contentStack.alpha = 1
        }
    }

    // MARK: – Nav Bar

    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareRecipe)
        )
    }

    @objc private func shareRecipe() {
        let text = "\(selectedRecipe.name)\n\n\(selectedRecipe.instructions)"
        let ac = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(ac, animated: true)
    }

    // MARK: – Build UI

    private func setupUI() {
        let r = selectedRecipe!

        // Hero + Blur
        heroImageView.image = UIImage(named: r.imageName)
        view.addSubview(heroImageView)
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: view.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        heroImageView.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: heroImageView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor)
        ])

        // Metadata
        let items = [
            ("clock", r.prepTime),
            ("fork.knife", "\(r.servings)"),
            ("star.fill", r.difficulty.capitalized)
        ]
        for (icon, text) in items {
            let iv = UIImageView(image: UIImage(systemName: icon))
            iv.tintColor = .white
            iv.setContentHuggingPriority(.required, for: .horizontal)
            let lbl = UILabel()
            lbl.text = text
            lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
            lbl.textColor = .white
            lbl.adjustsFontForContentSizeCategory = true
            let mini = UIStackView(arrangedSubviews: [iv, lbl])
            mini.spacing = 4
            metadataStack.addArrangedSubview(mini)
        }
        view.addSubview(metadataStack)
        NSLayoutConstraint.activate([
            metadataStack.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 8),
            metadataStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // ScrollView + ContentStack
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.contentInset = UIEdgeInsets(
            top: 0, left: 0,
            bottom: tabBarController?.tabBar.frame.height ?? 0,
            right: 0
        )
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: metadataStack.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32)
        ])

        // Title
        let titleLbl = UILabel()
        titleLbl.text = r.name
        titleLbl.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        titleLbl.adjustsFontForContentSizeCategory = true
        contentStack.addArrangedSubview(titleLbl)

        // Checklist state
        let key = "\(r.name)-checked"
        if let saved = UserDefaults.standard.array(forKey: key) as? [Bool],
           saved.count == r.ingredients.count {
            checkedStates = saved
        } else {
            checkedStates = Array(repeating: false, count: r.ingredients.count)
        }

        // Ingredients Card
        let ingCard = makeCardView()
        ingCard.addArrangedSubview(makeSectionHeader(text: "Ingredients"))
        let ingList = UIStackView()
        ingList.axis = .vertical
        ingList.spacing = 8
        for (i, ing) in r.ingredients.enumerated() {
            let btn = UIButton(type: .system)
            btn.setTitle(ing, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
            btn.contentHorizontalAlignment = .leading
            let iconName = checkedStates[i] ? "checkmark.circle.fill" : "circle"
            btn.setImage(UIImage(systemName: iconName), for: .normal)
            btn.tintColor = .white
            btn.imageEdgeInsets = .init(top: 0, left: -4, bottom: 0, right: 8)
            btn.tag = i
            btn.addTarget(self, action: #selector(toggleIngredient(_:)), for: .touchUpInside)
            ingredientButtons.append(btn)
            ingList.addArrangedSubview(btn)
        }
        ingCard.addArrangedSubview(ingList)
        contentStack.addArrangedSubview(ingCard)

        // Instructions Card
        let instCard = makeCardView()
        instCard.addArrangedSubview(makeSectionHeader(text: "Instructions"))
        let detail = RecipeDetailView()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.configure(with: r.instructions)
        instCard.addArrangedSubview(detail)
        instCard.addArrangedSubview(progressView)
        instCard.addArrangedSubview(timerLabel)
        contentStack.addArrangedSubview(instCard)
    }

    // MARK: – Actions

    @IBAction private func startPauseTapped(_ sender: UIButton) {
        if cookTimer == nil {
            // Starting
            // Parse prep time into totalSeconds
            let parts = selectedRecipe.prepTime.split(separator: " ")
            let mins = Int(parts.first ?? "0") ?? 0
            totalSeconds = mins * 60

            // Reset on first start
            if elapsedSeconds == 0 {
                progressView.progress = 0
                timerLabel.text = "00:00"
            }

            // Switch to pause icon
            sender.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)

            // Create and schedule timer in common modes
            cookTimer = Timer(timeInterval: 1, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
            RunLoop.main.add(cookTimer!, forMode: .common)
            cookTimer!.fire()  // immediate first tick
        } else {
            // Pausing
            cookTimer?.invalidate()
            cookTimer = nil
            sender.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }

    @objc private func timerTick() {
        elapsedSeconds += 1
        let m = elapsedSeconds / 60
        let s = elapsedSeconds % 60
        timerLabel.text = String(format: "%02d:%02d", m, s)
        if totalSeconds > 0 {
            let prog = Float(elapsedSeconds) / Float(totalSeconds)
            progressView.setProgress(min(prog, 1), animated: true)
        }
    }

    @objc private func toggleIngredient(_ sender: UIButton) {
        let i = sender.tag
        checkedStates[i].toggle()
        let icon = checkedStates[i] ? "checkmark.circle.fill" : "circle"
        sender.setImage(UIImage(systemName: icon), for: .normal)
        UserDefaults.standard.set(checkedStates, forKey: "\(selectedRecipe.name)-checked")
    }

    // MARK: – Parallax

    func scrollViewDidScroll(_ sv: UIScrollView) {
        let y = sv.contentOffset.y
        heroImageView.transform = y < 0
            ? CGAffineTransform(scaleX: 1 + abs(y/200), y: 1 + abs(y/200))
            : .identity
    }

    // MARK: – Helpers

    private func makeCardView() -> UIStackView {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 12
        s.alignment = .fill
        s.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        s.isLayoutMarginsRelativeArrangement = true
        s.backgroundColor = UIColor(white: 0.15, alpha: 1)
        s.layer.cornerRadius = 12
        s.layer.shadowColor = UIColor.black.cgColor
        s.layer.shadowOpacity = 0.2
        s.layer.shadowRadius = 6
        s.layer.shadowOffset = CGSize(width: 0, height: 4)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }

    private func makeSectionHeader(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.adjustsFontForContentSizeCategory = true
        lbl.textColor = .white
        return lbl
    }
}
