/*
1) Retornar o primeiro elemento de um array
2) Somar todos os elementos de um array
3) Checar se tem duplicado com loop duplo (todo par com todo par)
4) Checar se tem duplicado usando um Set

 Escreve as 4 funções no Playground, sem IA. Pra cada uma, dá o tempo e o espaço, e me manda aqui que eu corrijo.
 */

let numbers = [3, 7, 1, 9, 4]
let withDuplicate = [3, 7, 1, 7, 4]
let noDuplicate = [3, 7, 1, 9, 4]

/*
 1) Retornar o primeiro elemento de um array

Minha resposta:

 Tempo: O(1)

 Porque:
 É só ir no primeiro item do array e pescar ele (não fiz validação de nada, só fui e peguei)

 Resp do claude:
 "Tempo O(1): “pescar o primeiro” tá certo, mas o motivo real é: array é memória contígua, então acessar qualquer índice é direto. Não depende do tamanho n. Se o array tiver 3 ou 1 milhão de itens, é o mesmo custo"

 ---------------------
 Espaço: O(1)

 Porque:
 Mesma explicaçao acima

 Resp do claude:
 Espaço O(1): “mesma explicação” não cola ❌. Espaço é outra pergunta: você cria algo que cresce com n? Não, só guarda 1 variável (first). Por isso O(1)
 */

func returnFirstElementArray(_ arr: [Int]) -> Int {
    return arr[0]
}

print(returnFirstElementArray(numbers))

/*
  2) Somar todos os elementos de um array
 Minha resposta:
  Tempo:
    O(n)

  Porque:
    Tem que pecorrer o array inteiro, como o tamanho é indeterminado, é n

  Resp do claude:
 Explicação boa. Só ajustaria: não é que “o tamanho é indeterminado”, é que o trabalho cresce proporcional ao tamanho. 10 itens = 10 somas, 1000 itens = 1000 somas


 ---------------------
  Espaço:
    O(n)

  Porque:
 "você cria algo que cresce com n?"
 Ao meu ver, sim, o sum vai crescendo

  Resp do claude:
 Espaço O(n) ❌ → é O(1)

 Confusão clássica: o valor do sum cresce, mas a memória não
 sum é sempre 1 Int só, ocupa o mesmo espaço guardando 5 ou 5 bilhões
 Pergunta certa pra se fazer: “quantas caixinhas eu tô criando?” Aqui é 1, sempre
 O(n) seria se você criasse, por exemplo, um array novo que ganha 1 item a cada volta do loop
 */

func sumAllArrayElements(_ arr: [Int]) -> Int {
    var sum = 0
    for item in arr {
        sum += item
    }

    return sum
}

print(sumAllArrayElements(numbers))


/*
  3) Checar se tem duplicado com loop duplo (todo par com todo par)
 Minha resposta:
  Tempo:
  O(n^2)

  Porque:
  Sempre percorre o array duas vezes pra cada iteracao.
  Pega o primeiro item, percorre tudo
  Segundo, percorre tudo

  Resp do claude:
 Explicação: “percorre o array duas vezes” tá errado, duas vezes seria O(2n) = O(n)
 O certo: pra cada item, percorre o resto. É loop dentro de loop, por isso n × n

 ---------------------
  Espaço:
 O(n^2) tambem?

  Porque:
  Nesse caso a gente cria o i e o j, que crescem variando com o N (tamanho do array)?

  Resp do claude:
 Espaço O(n²) ❌ → é O(1)
 Mesmo erro da 2: i e j mudam de valor, mas são sempre 2 variáveis
 Quantas caixinhas você criou? i, j, first, second, jStart. Número fixo, não importa o tamanho do array
 Regra de bolso: só vira O(n) de espaço se você cria uma estrutura (array, set, dict) que cresce com n
 */

func hasDuplicateTwoLoops(_ arr: [Int]) -> Bool {
    for i in 0..<arr.count {
        let first = arr[i]
        let jStart = i + 1
        for j in jStart..<arr.count {
            let second = arr[j]

            if first == second {
                return true
            }
        }
    }

    return false
}

print(hasDuplicateTwoLoops(withDuplicate))
print(hasDuplicateTwoLoops(noDuplicate))


/*
  4) Checar se tem duplicado usando um Set
 Minha resposta:
  Tempo:
  O(n)

  Porque:
 Passa apenas vez pelo array

  Resp do claude:
 Tempo O(n) — falta uma peça na explicação:
 Passar 1 vez no array só dá O(n) se cada insert for O(1)
 E é: Set usa hash, então inserir/buscar é O(1) em média
 Se insert fosse O(n), seria O(n²).


 ---------------------
  Espaço:
  O(n)

  Porque:
 Pra cada elemento do array, adiciona em uma outra estrutura (Set)


  Resp do claude:

 */

func hasDuplicateSet(_ arr: [Int]) -> Bool {
    var set = Set<Int>()
    for item in arr {
        let result = set.insert(item)
        if result.inserted == false {
            return true
        }
    }

    return false
}

print(hasDuplicateSet(withDuplicate))
print(hasDuplicateSet(noDuplicate))
