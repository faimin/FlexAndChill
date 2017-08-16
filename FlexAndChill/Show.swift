/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

struct Show {
  let title: String
  let length: String
  let detail: String
  let image: String
}

// MARK: - Support for loading data from plist

extension Show {
  static func loadShows() -> [Show] {
    return loadMixersFrom("Shows")
  }
  
  fileprivate static func loadMixersFrom(_ plistName: String) -> [Show] {
    guard
      let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
      let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
      else {
        fatalError("An error occurred while reading \(plistName).plist")
    }
    
    var shows = [Show]()
    
    for dict in dictArray {
      guard
        let title = dict["title"] as? String,
        let length = dict["length"] as? String,
        let detail = dict["detail"] as? String,
        let image = dict["image"] as? String
        else {
          fatalError("Error parsing dict \(dict)")
      }
      
      let show = Show(
        title: title,
        length: length,
        detail: detail,
        image: image
      )
      
      shows.append(show)
    }
    
    return shows
  }
}
