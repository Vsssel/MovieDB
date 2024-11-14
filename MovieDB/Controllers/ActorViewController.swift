import UIKit

class ActorViewController: UIViewController {
    
    private var actor: Actor?
    private var actorInfoView: ActorInfoView?

    init(id: Int) {
        super.init(nibName: nil, bundle: nil)
        NetworkingManager.shared.getActorDetails(id: id) { [weak self] actor in
            guard let self = self else { return }
            self.actor = actor
            DispatchQueue.main.async {
                self.setupActorDetails()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    private func setupActorDetails() {
        guard let actor = actor else { return }
        title = "Actor"
        

        let actorInfoView = ActorInfoView(actorInfo: actor)
        view.addSubview(actorInfoView)
        actorInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.actorInfoView = actorInfoView
    }
}
