import SwiftUI



@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var alertMessage: String?
    @Published var isShowingAlert = false
    let networkService = FWNetworkService(provider: URLSessionNetworkProvider())
    

    func fetchUsers() {
        
        Task {
            let result = await networkService.requestWithQuery(
                method: .get,
                url: "https://jsonplaceholder.typicode.com/users",
                responseType: [User].self
            )

            await MainActor.run {
                switch result {
                case .success(let fetchedUsers):
                    self.users = fetchedUsers
                case .failure(let error):
                    self.alertMessage = error.errorDescription
                    self.isShowingAlert = true
                }
            }
        }
    }
}
