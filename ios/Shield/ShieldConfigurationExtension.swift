import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        let pose = PetStore.pose % 3
        PetStore.log.info("configuration requested pose=\(pose) timestamp=\(Date().timeIntervalSince1970)")
        let image = UIImage(named: ["real-awake", "real-yawn", "real-sleep"][pose])
        let icon = image.map { source in
            UIGraphicsImageRenderer(size: CGSize(width: 150, height: 150)).image { _ in
                let ratio = min(150 / source.size.width, 150 / source.size.height)
                let size = CGSize(width: source.size.width * ratio, height: source.size.height * ratio)
                source.draw(in: CGRect(x: (150 - size.width) / 2, y: (150 - size.height) / 2, width: size.width, height: size.height))
            }
        }
        return ShieldConfiguration(backgroundBlurStyle: .systemUltraThinMaterial,
            backgroundColor: UIColor(red: 0.96, green: 0.94, blue: 0.90, alpha: 1), icon: icon,
            title: .init(text: "主人，陪我睡吧", color: .brown),
            subtitle: .init(text: "休息一下，糰子在這裡陪你。", color: .secondaryLabel),
            primaryButtonLabel: .init(text: "晚安", color: .white), primaryButtonBackgroundColor: .brown)
    }
}
