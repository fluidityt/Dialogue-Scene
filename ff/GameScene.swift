//
//  GameScene.swift
//  Dialogue Scene
//
//  Created by Dude Guy  on 11/29/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//
func iha(_ int: Int) -> Int { return (int - 1) }

import SpriteKit

// MARK: - Setup:

  // MARK: - Properties and dmv
  
class GameScene: SKScene {

	enum Mode { case advance, decision, exit }

	/* Fields: */var mode: Mode = .advance,
	buttonCounter = 0,
	dialogues = ["hidt", "there"],
	decisionText = "what is ur name?",
	decisions = ["john", "sally"],
	answerText = ["Hi john", "Hi sally"],
	decision = -2, // -2 is setup, -1 is waiting for user, 0+ is handle input

	dlgButton = SKLabelNode(text: "Next.."),
	dcsnButton = [SKLabelNode(text: "Choice 1"), SKLabelNode(text: "Choice 2")],
	touch = UITouch()

	override func didMove(to view: SKView) {
		print("hi")
		backgroundColor = .gray

		dlgButton.position = CGPoint(x: frame.midX,
		                             y: frame.midY)
		dcsnButton[0].position = CGPoint(x: frame.minX + dcsnButton[0].frame.width,
		                                 y: frame.midY)
		dcsnButton[1].position = CGPoint(x: frame.maxX - dcsnButton[1].frame.width,
		                                 y: frame.midY)

		dlgButton.setScale(3)
		dcsnButton[0].setScale(3)
		dcsnButton[1].setScale(3)

		dcsnButton[0].alpha = 0
		dcsnButton[1].alpha = 0

		addChild(dlgButton)
		addChild(dcsnButton[0])
		addChild(dcsnButton[1])

		print(dialogues[buttonCounter])
	}
}


  // MARK: - Game Logic:

extension GameScene {

  private func didClick(_ node: SKNode) -> Bool {
    return Bool(nodes(at: touch.location(in: self)).contains(node))
  }
  
  private func advanceMode () {
    
      guard buttonCounter < iha(dialogues.count) else { // <- We have no more dialogues, so we go to the next mode
        dlgButton.alpha = 0
        mode = .decision
        return
      }
      
      if didClick(dlgButton) {
        buttonCounter += 1
        print(dialogues[buttonCounter])
      }
    }
  private func decisionMode() {
    func setUp() {
      print(decisionText)                                                               // <- Print our initial question to the player
      var i = 0
      let stop = decisions.count
      while i != stop {                                                                 // <- Load our buttons
        dcsnButton[i].text  = decisions[i]
        dcsnButton[i].alpha = 1
        i += 1
      }
      decision = -1                                                                     // <- Put us into wait mode.
    }
    
    func checkClicks() {
      var i = 0
      let stop = decisions.count
      while i != stop {
        if didClick(dcsnButton[i]) {
          decision = i                                                                  // <- Matches our decision to the desired array.
        }
        i += 1
      }
    }
    
    func userHasValidInput() {
      
      clearScreen: do {
        var i = 0
        let stop = decisions.count
        while i != stop {
          dcsnButton[i].text  = ""
          dcsnButton[i].alpha = 0
          i += 1
        }
        decisions = []
      }
      
      handleAnswer: do {
        print(answerText[decision])
      }
      
      // Change mode:
      mode = .exit
    }
    
    
    // Check setup, because nothing else will work if it isn't done
    if decision == -2 {
      setUp()
    }
    
    // Check if we have clicked anything, which will update our decision,
    // because nothing will happen if we don't update this.
    checkClicks()
    
    // Do nothing if we have no clicks:
    if decision == -1 { return }
    
    // User has entered a valid input:
    userHasValidInput()
  }
  
  override func update(_ currentTime: TimeInterval) {

		return

    // Regardless of other actions, we need to reset our touch data:
    defer { touch = UITouch() }
    print("hi")

    // Handle our available game modes
    switch mode {
    case .advance:
      advanceMode()
    case .decision:
      decisionMode()
    case .exit:
      print ( "Goodbye." )
    }
  }
}


  // MARK: - Touches

  extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      touch = touches.first!
    }
    
}
