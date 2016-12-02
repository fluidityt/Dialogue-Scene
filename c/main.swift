//
//  main.swift
//  c
//
//  Created by Dude Guy on 12/2/16.
//  Copyright © 2016 Dude Guy . All rights reserved.
//

import Foundation

extension Array {
	func countIHA() -> Int {
		if self.count > 0 { return (self.count - 1) }
		else { fatalError("array is empty. Didn't you check before calling this?"); return -5 }
	}
}

print("Hello, World!")

// Only works once we know that we have a valid option

func readInt(onRepeat message: String, countIHA validMax : Int) -> Int {
	if validMax < 0 { fatalError("less than 0") }
	// print(message)
	while 0 == 0 {
		if let input = readLine() {
			if let i = Int(input) {
				switch i {
				case 0...validMax: return i
				default: ()
				}
			}
		}
		print(message)
	}
}

let x: [Int] = [1,3]

let z = readInt(onRepeat: "press 0", countIHA: x.countIHA())
print(z)
