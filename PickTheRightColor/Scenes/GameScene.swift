//
//  GameScene.swift
//  PickTheRightColor
//
//  Created by Yauheni Bunas on 7/7/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit
import GameplayKit

var square0: SKSpriteNode?
var square1: SKSpriteNode?
var square2: SKSpriteNode?
var square3: SKSpriteNode?

let squareSize = CGSize(width: 250, height: 250)

var mainLabel: SKLabelNode?
var scoreLabel: SKLabelNode?
var timerLabel: SKLabelNode?

let squarePositionOffset = CGFloat(150)
let labelOffsetY = CGFloat(400)
let offBlackColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
let offWhiteColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)

let color0 = UIColor.orange
let color1 = UIColor.green
let color2 = UIColor.blue
let color3 = UIColor.purple

let incorrectColor0 = UIColor.yellow
let incorrectColor1 = UIColor.red
let incorrectColor2 = UIColor.lightGray

let colorArrayString = ["Orange", "Green", "Blue", "Purple"]
var colorArrayChoice = 0
var correctSquare = 0
var colorChoice = 0

var touchLocation: CGPoint?
var touchedNodes: [SKNode?] = []

var score = 0
var isAlive = true
var countDownVar = 13

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = offBlackColor
        
        spawnMainLabel()
        spawnTimerLabel()
        spawnScoreLabel()
        
        spawnSquare0()
        spawnSquare1()
        spawnSquare2()
        spawnSquare3()
        
        randomizeColors()
        countDownTimer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchLocation = t.location(in: self)
            touchedNodes = nodes(at: touchLocation!)
            
            touchedNodeLogic()
        }
    }
    
    func touchedNodeLogic() {
        if touchedNodes.isEmpty == false {
            if touchedNodes[0]?.name != "correct" {
                gameOverLogic()
                isAlive = false
            } else if touchedNodes[0]?.name == "correct" {
                addToScore()
                randomizeColors()
            }
        }
    }
    
    func spawnSquare0() {
        square0 = SKSpriteNode(color: offWhiteColor, size: squareSize)
        square0?.position = CGPoint(x: -squarePositionOffset, y: squarePositionOffset)
        
        self.addChild(square0!)
    }
    
    func spawnSquare1() {
        square1 = SKSpriteNode(color: offWhiteColor, size: squareSize)
        square1?.position = CGPoint(x: squarePositionOffset, y: squarePositionOffset)
        
        self.addChild(square1!)
    }
    
    func spawnSquare2() {
        square2 = SKSpriteNode(color: offWhiteColor, size: squareSize)
        square2?.position = CGPoint(x: -squarePositionOffset, y: -squarePositionOffset)
        
        self.addChild(square2!)
    }
    
    func spawnSquare3() {
        square3 = SKSpriteNode(color: offWhiteColor, size: squareSize)
        square3?.position = CGPoint(x: squarePositionOffset, y: -squarePositionOffset)
        
        self.addChild(square3!)
    }
    
    func spawnMainLabel() {
        mainLabel = SKLabelNode(fontNamed: "Futura")
        
        mainLabel?.fontSize = 80
        mainLabel?.fontColor = offWhiteColor
        mainLabel?.position = CGPoint(x: 0, y: labelOffsetY)
        mainLabel?.text = "Start!"
        
        self.addChild(mainLabel!)
    }
    
    func spawnScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        
        scoreLabel?.fontSize = 40
        scoreLabel?.fontColor = offWhiteColor
        scoreLabel?.position = CGPoint(x: 0, y: -labelOffsetY - 80)
        scoreLabel?.text = "Score: \(score)"
        
        self.addChild(scoreLabel!)
    }
    
    func spawnTimerLabel() {
        timerLabel = SKLabelNode(fontNamed: "Futura")
        
        timerLabel?.fontSize = 100
        timerLabel?.fontColor = offWhiteColor
        timerLabel?.position = CGPoint(x: 0, y: -labelOffsetY)
        timerLabel?.text = "10"
        
        self.addChild(timerLabel!)
    }
    
    func randomizeColors() {
        colorArrayChoice = Int.random(in: 0..<4)
        colorChoice = Int.random(in: 0..<4)
        correctSquare = Int.random(in: 0..<4)
        
        printColors()
        printColorCorrectSquare()
    }
    
    func printColors() {
        if colorChoice == 0 {
            mainLabel?.fontColor = color0
        } else if colorChoice == 1{
            mainLabel?.fontColor = color1
        } else if colorChoice == 2 {
            mainLabel?.fontColor = color2
        } else if colorChoice == 3 {
            mainLabel?.fontColor = color3
        }
        
        mainLabel?.text = "\(colorArrayString[colorArrayChoice])"
    }
    
    func printColorCorrectSquare() {
        let tempColor = [color0, color1, color2, color3]
        
        if colorChoice == 0 {
            square0?.color = tempColor[colorChoice]
            square1?.color = incorrectColor0
            square2?.color = incorrectColor1
            square3?.color = incorrectColor2
            
            square0?.name = "correct"
            square1?.name = "incorrect0"
            square2?.name = "incorrect1"
            square3?.name = "incorrect2"
        }
        
        if colorChoice == 1 {
            square0?.color = incorrectColor2
            square1?.color = tempColor[colorChoice]
            square2?.color = incorrectColor0
            square3?.color = incorrectColor1
            
            square0?.name = "incorrect0"
            square1?.name = "correct"
            square2?.name = "incorrect1"
            square3?.name = "incorrect2"
        }
        
        if colorChoice == 2 {
            square0?.color = incorrectColor1
            square1?.color = incorrectColor2
            square2?.color = tempColor[colorChoice]
            square3?.color = incorrectColor0
            
            square0?.name = "incorrect0"
            square1?.name = "incorrect1"
            square2?.name = "correct"
            square3?.name = "incorrect2"
        }
        
        if colorChoice == 3 {
            square0?.color = incorrectColor2
            square1?.color = incorrectColor1
            square2?.color = incorrectColor0
            square3?.color = tempColor[colorChoice]
            
            square0?.name = "incorrect0"
            square1?.name = "incorrect1"
            square2?.name = "incorrect2"
            square3?.name = "correct"
        }
    }
    
    func addToScore() {
        score += 1
        scoreLabel?.text = "Score: \(score)"
    }
    
    func gameOverLogic() {
        mainLabel?.fontColor = offWhiteColor
        mainLabel?.text = "Game Over"

        timerLabel?.text = "Try Again!"

        square0?.removeFromParent()
        square1?.removeFromParent()
        square2?.removeFromParent()
        square3?.removeFromParent()
        
        resetTheGame()
    }
    
    func resetTheGame() {
        let wait = SKAction.wait(forDuration: 3)
        
        let theGameScene = GameScene(size: self.size)
        let theTransition = SKTransition.crossFade(withDuration: 0.5)

        theGameScene.scaleMode = SKSceneScaleMode.aspectFill

        let sceneChange = SKAction.run {
           self.scene?.view?.presentScene(theGameScene, transition : theTransition)
        }

        let sequence = SKAction.sequence([wait, sceneChange])
        self.run(SKAction.repeat(sequence, count: 1))
    }
    
    func countDownTimer() {
        let wait = SKAction.wait(forDuration: 1.0)
        
        let countDown = SKAction.run {
            if isAlive == true {
                countDownVar -= 1
            }
            
            if countDownVar <= 10 && isAlive == true {
                timerLabel?.text = "\(countDownVar)"
            }
            
            if countDownVar <= 0 {
                self.gameOverLogic()
            }
        }
        
        let sequence = SKAction.sequence([wait, countDown])
        self.run(SKAction.repeat(sequence, count: countDownVar))
    }
    
    func resetGameVariablesOnStart() {
        spawnSquare0()
        spawnSquare1()
        spawnSquare2()
        spawnSquare3()
        
        score = 0
        countDownVar = 13
        isAlive = true
    }
}
