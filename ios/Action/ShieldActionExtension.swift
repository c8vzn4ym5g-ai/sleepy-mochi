import ManagedSettings

class ShieldActionExtension: ShieldActionDelegate {
    override func handle(action: ShieldAction, for application: ApplicationToken,
                         completionHandler: @escaping (ShieldActionResponse) -> Void) {
        PetStore.clear()
        PetStore.pose = (PetStore.pose + 1) % 3
        completionHandler(.close)
    }
}
