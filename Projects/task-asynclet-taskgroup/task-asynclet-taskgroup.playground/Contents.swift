import Foundation

/*
 Setup

 Crie fetchScore(for id: Int) async -> Int
 Ela espera 1s com Task.sleep e retorna um número qualquer (pode ser o próprio id * 10)
 */
func fetchScore(for id: Int) async throws -> Int {
    try await Task.sleep(for: .seconds(1))

    return id * 10
}

let clock = ContinuousClock()

/*
 Parte 1: sequência vs async let

 Busque os IDs 1, 2 e 3 em sequência (um await depois do outro) e some

 Faça o mesmo com async let

 Meça o tempo dos dois com ContinuousClock e imprima
 */

func part1Sequence() async {
    do {
        let duration = try await clock.measure {
            let id1 = try await fetchScore(for: 1)
            let id2 = try await fetchScore(for: 2)
            let id3 = try await fetchScore(for: 3)

            let sum = id1 + id2 + id3
            print("sum sequence: \(sum)")
        }

        print(duration)
    } catch {
        print("cai aqui no erro!!! \(error)")
    }

}

func part1AsyncLet() async {
    do {
        let duration = try await clock.measure {
            async let id1 = fetchScore(for: 1)
            async let id2 = fetchScore(for: 2)
            async let id3 = fetchScore(for: 3)

            let sum = try await id1 + id2 + id3
            print("sum async let: \(sum)")
        }

        print(duration)
    } catch {
        print("cai aqui no erro!!! \(error)")
    }
}

//Task {
//    await part1Sequence()
//    await part1AsyncLet()
//}


/*
 Parte 2: TaskGroup

 Crie uma função part2TaskGroup() async

 Array com os IDs de 1 a 10

 Use withTaskGroup pra chamar fetchScore de todos em paralelo

 Colete os resultados e some

 Meça com o clock e imprima a soma e o tempo

 Chama dentro da mesma Task { } lá embaixo
 */

func part2TaskGroup() async {
    do {
        let duration = try await clock.measure {

            let ids = 1...10

            let sum = try await withThrowingTaskGroup(of: Int.self) { group in
                for id in ids {
                    group.addTask {
                        return try await fetchScore(for: id)
                    }
                }

                var scores = [Int]()

                for try await score in group {
                    scores.append(score)
                }

                return scores.reduce(0, +)
            }

            print("sum task group: \(sum)")
        }

        print(duration)
    } catch let error as CancellationError {
        print("[part2TaskGroup] task cancelada !! \(error)")
    } catch {
        print("[part2TaskGroup] erro generico !! \(error)")
    }

}

//Task {
//    await part2TaskGroup()
//}


/*
 Parte 3: cancelamento

 Guarda numa variável uma Task que chama a part2TaskGroup()
 Depois de 1,5s, cancela essa task
 A função tem que parar de verdade e imprimir que foi cancelada
 */

func part3CancellingTask() async {
    let task = Task {
        await part2TaskGroup()
    }

    try? await Task.sleep(for: .seconds(0.5))

    task.cancel()
}

Task {
    await part3CancellingTask()
}
