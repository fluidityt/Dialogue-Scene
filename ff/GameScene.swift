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
    
    var mode: Mode = .advance
    
    
    var buttonCounter = 0

    var dialogues = ["hidt", "there"]

    
    var decisionText = "what is ur name?"
    
    var decisions = ["john", "sally"]
    
    var answerText = ["Hi john", "Hi sally"]
    
    var decision = -2 // -2 is setup, -1 is waiting for user, 0+ is handle input
    
    
    var dlgButton = SKLabelNode(text: "Next..")
    
    var dcsnButton = [SKLabelNode(text: "Choice 1"), SKLabelNode(text: "Choice 2")]
    
    
    var touch = UITouch()
    
    override func didMove(to view: SKView) {
      
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
    
    // Regardless of other actions, we need to reset our touch data:
    defer { touch = UITouch() }
    
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

/*func terribleCode() {
/*
 
  load nodes (hidden)
  manually make first dialogue object:
    dialogues = ["I have a secret...", "I'm in love with myself.."]
    scenetoplay = 1
    currentlyplaying = 0
  manually adjust next:
 
 
 
 
 
 
*/

fileprivate enum dialoguer {
  
  // Basic stuff:
  
  private static var sceneToPlay = 0
  
  private static var currentlyPlaying = 0
  
  private static var dialogues = ["Hey"]
  
  private static func reset() {
    sceneToPlay = 0
    currentlyPlaying = 0
    dialogues = []
  }
  
  // String:
  
  private static func parseDialogue(unparsed: String) -> [String] {
    // FIXME: Lookup string splitters
    let splitSources = "splitSourceIntoPieces()"
    return [splitSources]
  }
  private static func setDialogues(source: String) {
    dialogues = parseDialogue(unparsed: source)
  }
  
  // String2:
  private static func playDialogue() {
    print(dialogues[sceneToPlay])
  }
  private static func playNextAvailableDialogue() {
    currentlyPlaying = sceneToPlay
    playDialogue()
  }
  
  // Side-effects:
  private static func resetDlgCounter() {
    nexT.reset()
  }
  
  // Outside-access:
  static func viewPresentation(result: Int) {
    sceneToPlay = result
  }
  
  // Update:
  static func update() {
    
    // Logic:
    func advanceGame() {
      resetDlgCounter()
      reset()
      
    }
    
    allNonDialogueCommands: do {
      // See if we can play dialoge:
      if sceneToPlay == 0 {
        // Internally set.. wait for next cycle
      }
      
      if sceneToPlay > dialogues.count {
        // User clicked next, but there is no dialogue. We must load new one
        advanceGame() // <- Could be to anotherscene, or just a new dialogue series
      }
      
      if currentlyPlaying == sceneToPlay {
        // No new commands--wait for next cycle
      }
      
      if currentlyPlaying > sceneToPlay {
        // Some kind of fatal error?
      }
    }
    
    playADialogue: do {
      // Once we know that we need to play a dialogue already stored:
      if currentlyPlaying < sceneToPlay {
        playNextAvailableDialogue()
      }
    }
    
    
    // Try to load new dialogue:
    // Reset dlgCounter if needed:
    
  }
}


fileprivate enum nexT {
  
  // Number:
  private static var dlgCounter = 1 // <- Dialogue counter.. minimally shows 1 as it will always present the first value.
  
  private static func increment() {
    dlgCounter += 1
  }
  
  // Side effects:
  private static func present(counter: Int = dlgCounter) {
    dialoguer.viewPresentation(result: counter)
  }
  
  // Outside-access:
  static func reset() { dlgCounter = 1 }
  
  // Label:
  static var lab    = SKLabelNode()
  
  static func didLoad(scene: SKScene) {
    lab.text = "Next.."
    lab.position = CGPoint(x: scene.frame.midX,
                           y: scene.frame.midY)
    lab.setScale(5)
    lab.color = SKColor.darkGray
    scene.addChild(lab)
  }
  
  // Update: (called in didClick)
  static func update() {
    
    // Present current counter:
    
    // Increase or reset counter:
    
    
    
  }
}
}
*/

