//
//  ViewController.swift
//  Calculator
//
//  Created by Developer on 9/30/15.
//  Copyright © 2015 Developer. All rights reserved.
//

/*  UI - User Interface
    Importamos o UIKit que é um framework
    Temos a classe principal que é a ViewController e herda da UIViewController que corresponde a nossa UI inicial
    Criamos um Outlet para a propriedade display que é do tipo Label, ligada com a User Interface
    Demos uma ação para todos os números do tipo botão na UI
    Para essa ação criamos um método que é um appendDigit que tem como argumento enviar, e pega o que vai dos botões
    Para guardar o valor do botão, criamos uma constante, que tem como valor o título de cada botão
    O acesso é feito da seguinte maneira: quando passamos o parâmetro do método sender, dizemos que vamos enviar algo
    Sendo assim, conseguimos acessar o valor do título do UIButton pressionado e atribuímos a uma constante.
    Imprimimos o valor para ver o dígito clicado.
    Nesse caso que atribuímos o currentTitle para a constante, logo ela assume que o valor será uma String, pois o próprio currentTitle é uma String

*/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle! // Não é mais um optional com o ponto de exclamação
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation {$0 * $1} // O tipo dos operadores não precisa ser especificados, pois eles vao para um metodo que tem o tipo que serao
        case "÷": performOperation {$1 / $0} //não é necessário retornar o método, pois para onde ele vai já retornará um valor
        case "+": performOperation {$0 + $1} // Podemos fazer desse jeito, sem precisar criar uma variável para este caso syntax
        case "-": performOperation {$1 - $0} //syntax não é necessário passar um argumento
        case "√": performOperation { sqrt($0) } //syntax não é necessário passar um argumento
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    @nonobjc
    func performOperation(operation: (Double -> Double)) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue) //Pega o valor do displayValue e adiciona na última posição do array
        print("operandStack = \(operandStack)")
        
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        set {
            display.text! = ("\(newValue)")
            userIsInTheMiddleOfTypingANumber = false
        }
    
    }
}
