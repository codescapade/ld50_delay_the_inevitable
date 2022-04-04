package blocks;

import aeons.Aeons;
import aeons.math.Vector2;
import aeons.graphics.Color;
import aeons.math.Rect;

class Block {
  public var tileData(default, null): Array<Array<Int>>;

  public var colliders(default, null): Array<Rect>;

  public var rays(default, null): Array<Vector2>;

  public var color(default, null): Color;

  public var frameName(default, null): String;

  public var width(default, null): Int;
  
  public var height(default, null): Int;

  public function new(tileData: Array<Array<Int>>, colliders: Array<Rect>, rays: Array<Vector2>, color: Color,
      frameName: String) {
    this.tileData = tileData;
    this.colliders = colliders;
    this.rays = rays;
    this.color = color;
    this.frameName = frameName;
    
    for (y in 0...tileData.length) {
      for (x in 0...tileData[0].length) {
        if (tileData[y][x] == 1) {
          if (x + 1 > width) {
            width = x + 1;
          }
          if (y + 1 > height) {
            height = y + 1;
          }
        }
      }
    }
  }
}