import UIKit
/*
 Playground (sem IA, sem autocomplete de IA)

 Simula um “carregar perfil”: faz um trabalho lento num global() queue (use Thread.sleep) e depois “atualiza a UI” na main.
 Imprime Thread.isMainThread em cada etapa

 Depois: cria um contador, incrementa 1000x de dentro de um concurrentPerform. Vê o resultado errado. Conserta usando uma fila serial privada

 💡 Hint 1: no Playground, pra o código async rodar até o fim, procura PlaygroundPage.current.needsIndefiniteExecution
 💡 Hint 2: pra proteger o contador, pensa em qual operação (sync ou async) você quer na leitura vs na escrita
 */


func loadProfile() {
    let globalQueue = DispatchQueue.global(qos: .userInitiated)

    // async: nao trava a main thread
    globalQueue.async {
        print("2) To na fila global - que é concurrent/background")
        print("3) fila global - eh MainThread: \(Thread.isMainThread)")
        Thread.sleep(forTimeInterval: 3)
        print("4) pronto, agora carreguei perfil")

        // async: não trava a thread que está rodando o bloco da global;
        // ela segue pro 6)
        DispatchQueue.main.async {
            print("5) atualizei a UI na main | eh MainThread: \(Thread.isMainThread)")
        }

        print("6) continuei no global | eh MainThread: \(Thread.isMainThread)")
    }

    print("1) fora da fila global - eh MainThread: \(Thread.isMainThread)") // true
}

//loadProfile()

/*
concurrentPerform usa as filas globais (concurrent).
ele usa também a thread que chamou, por isso a main aparece;
ele é síncrono: só retorna quando todas as iterações terminam. Por isso o print do final vê o valor final.

a closure do concurrentPerform roda em qualquer thread, que o compilador chama de nonisolated.

 Aqui é uma fila e várias threads

 a thread A lê 14 e a thread B também lê 14. A grava 15, e B também grava 15. Rodaram 2 incrementos, mas o valor subiu só 1 -> lost update


Passo a passo:
 1) Ler o valor da memória.
 2) Somar 1: isso acontece num registrador da CPU, ainda não está na memória.
 3) Escrever o resultado de volta na memória.

O problema mora entre o passo 1 e o passo 3.

 Nesse intervalo, outra thread pode ler o mesmo valor antigo.

 Por isso se diz que o += 1 não é atômico: são vários passos que podem ser
 interrompidos no meio.

 O nome disso é read-modify-write.
 */

//var counter = 0
//DispatchQueue.concurrentPerform(iterations: 1000) { count in
//    if count < 10 {
//        print("Thread.current: \(Thread.current)")
//    }
//    counter += 1
//}
//
//print("counter: \(counter)")


// E o fix? Nada ainda?

var counterSerial = 0

let minhaFilaSerial = DispatchQueue(label: "fila.serial")

DispatchQueue.concurrentPerform(iterations: 1000) { count in
    if count < 10 {
        print("Thread.current: \(Thread.current)")
    }

    // Escreve na fila - aqui ele "agenda a escrita" e não espera o bloco executar, ele já segue direto - isso é o async trabalhando
    minhaFilaSerial.async {
        counterSerial += 1
    }
}

// Lê da fila - aqui, ele fala "main espera aqui até eu executar"
// a minhaFila espera todos as escritas 'counterSerial += 1' rodarem (que é quando ela tá pronta) e depois chama aqui, por isso aparece os 1000 certinho
minhaFilaSerial.sync {
    print("counterSerial: \(counterSerial)")
}
