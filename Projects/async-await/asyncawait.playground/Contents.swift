import Foundation
/*
 Playground — sem IA

 Cria struct User e struct Avatar (só 1 propriedade cada)
 Escreve fetchUser(id:completion:) com Result → simula demora com DispatchQueue.global().asyncAfter
 Escreve fetchAvatar(for user:completion:) do mesmo jeito
 Chama os dois encadeados (user → avatar) → sente a pirâmide
 Reescreve os dois como async throws e encadeia de novo
 */


struct User {
    let name: String
}

struct Avatar {
    let imageUrl: String
}


enum MeusErrors: Error {
    case userNotFound
    case avatarNotFound
}

// A funcao retorna um usuario
// -> engraçado que o retorno dela E da completion é Void
// mas como quem chama ela de fora que quer o User
// ele vai como um PARAMETRO DA COMPLETION
func fetchUser(id: String, completion: @escaping @Sendable (Result<User, Error>) -> Void) {

    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
        if Bool.random() {
            completion(.success(User(name: "Sucesso")))
        } else {
            completion(.failure(MeusErrors.userNotFound))
        }
    }
}

func fetchAvatar(for user: User, completion: @escaping @Sendable (Result<Avatar, Error>) -> Void) {
    // Fazer uma chamada com o user que vem
    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
        if Bool.random() {
            completion(.success(Avatar(imageUrl: "path/to/image")))
        } else {
            completion(.failure(MeusErrors.avatarNotFound))
        }
    }
}

func loadData() {
    fetchUser(id: "") { userResult in
        switch userResult {
        case .success(let user):
            fetchAvatar(for: user) { avatarResult in

            }
        case .failure(_):
            return
        }

    }
}


// Agora com async
func fetchUserAsync(id: String) async throws -> User {
    try await Task.sleep(for: .seconds(3))

    if Bool.random() {
        return User(name: "Sucesso")
    } else {
        throw MeusErrors.userNotFound
    }
}

func fetchAvatarAsync(for user: User) async throws -> Avatar  {
    try await Task.sleep(for: .seconds(3))

    if Bool.random() {
        return Avatar(imageUrl: "path/to/image")
    } else {
        throw MeusErrors.avatarNotFound
    }
}

func loadDataAsync() async throws -> Avatar {
    let user = try await fetchUserAsync(id: "")
    let avatar = try await fetchAvatarAsync(for: user)
    return avatar
}

Task {
    do {
        let avatar = try await loadDataAsync()
        print(avatar.imageUrl)
    } catch {
        print(error)
    }
}
