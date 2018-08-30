// Copyright (c) 2017 Lighthouse Labs. All rights reserved.
// 
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

class Vampire {
  
  var name: String
  var yearConverted: Int
  var offspring: [Vampire] = []
  var creator: Vampire?
  
  init(name: String, yearConverted: Int) {
    self.name = name
    self.yearConverted = yearConverted
  }
  
  // MARK: Simple tree methods
  
  /// Adds the vampire as an offspring of this vampire
  func add(offspring: Vampire) {
    let newVampire = offspring
    newVampire.creator = self
  self.offspring.append(newVampire)
  }
  
  /// The total number of vampires created by that vampire
  var numberOfOffspring: Int {
    return self.offspring.count
  }
  
  /// Returns the number of vampires away from the original vampire this vampire is
  var numberOfVampiresFromOriginal: Int {
    var numberFromOriginal = 0
    if let isNotRoot = self.creator {
      numberFromOriginal += 1
      numberFromOriginal += isNotRoot.numberOfVampiresFromOriginal
    }
      return numberFromOriginal
  }
  
  /// Returns true if this vampire is more senior than the other vampire. (Who is closer to the original vampire)
  func isMoreSenior(than vampire: Vampire) -> Bool {
    if (self.numberOfVampiresFromOriginal < vampire.numberOfVampiresFromOriginal) {
      return true
    }
    else {
      return false
  }
}
  
  // MARK: Stretch 
  
  /**
    Returns the closest common ancestor of two vampires.
    The closest common anscestor should be the more senior vampire if a direct ancestor is used.
 
    - Example:
      * when comparing Ansel and Sarah, Ansel is the closest common anscestor.
      * when comparing Ansel and Andrew, Ansel is the closest common anscestor.
   */
  func closestCommonAncestor(vampire: Vampire) -> Vampire {
    var vampA = self
    var vampB = vampire
    if vampA === vampB {
      return vampA 
    }
    if vampA === vampB.creator {
      return vampA
    }
    if vampB === vampA.creator {
      return vampB
    }
    if vampA.creator === vampB.creator {
      return vampA.creator!
    }
      guard vampA.numberOfVampiresFromOriginal == vampB.numberOfVampiresFromOriginal else {
        if vampA.numberOfVampiresFromOriginal > vampB.numberOfVampiresFromOriginal {
        vampA = vampA.creator!
          return vampA.closestCommonAncestor(vampire: vampB)
      }
        else {
          vampB = vampB.creator!
          return vampA.closestCommonAncestor(vampire:vampB)
        }
    }
    vampA = vampA.creator!
    vampB = vampB.creator!
    return vampA.closestCommonAncestor(vampire:vampB)
    
    
  }
}

