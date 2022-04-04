package components;

import aeons.Aeons;
import aeons.graphics.atlas.Frame;
import aeons.graphics.atlas.Atlas;
import blocks.Block;
import aeons.math.Rect;
import aeons.graphics.RenderTarget;
import aeons.core.Renderable;
import aeons.core.Component;

class CBlockSprite extends Component implements Renderable {

  public var anchorX = 0.0;

  public var anchorY = 0.0;

  var block: Block;

  var frame: Frame;

  var atlas: Atlas;

  var blockSize: Float;

  var startX: Float;
  var startY: Float;

  public function new (options: CBlockSpriteOptions) {
    super();

    block = options.block;
    atlas = Aeons.assets.getAtlas('atlas');
    frame = atlas.getFrame(block.frameName);
    blockSize = Constants.BLOCK_SIZE;
    startX = startY = -blockSize * 0.5;
  }

  public function render(target: RenderTarget, cameraBounds: Rect) {
    for (y in 0...block.tileData.length) {
      for (x in 0...block.tileData[0].length) {
        if (block.tileData[y][x] == 1) {
          target.drawImageSection(startX + x * blockSize, startY + y * blockSize, frame.frame.x, frame.frame.y,
            frame.frame.width, frame.frame.height, atlas.image, block.color);
        }
      }
    }
  }
}

typedef CBlockSpriteOptions = {
  var block: Block;
}