package scenes;

import aeons.events.SceneEvent;
import aeons.Aeons;
import aeons.core.Scene;

import blocks.BlockData;

class PreloadScene extends Scene {

  public override function init() {
    BlockData.init();

    Aeons.assets.loadAtlas('atlas', (_) -> {
      Aeons.events.emit(SceneEvent.get(SceneEvent.REPLACE, GameScene, null, false));
    });
  }
}