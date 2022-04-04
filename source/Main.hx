package;

import aeons.core.Game;

import scenes.PreloadScene;

class Main {

  static function main() {
    new Game({ title: 'ld50_delay_the_inevitable', preload: true, startScene: PreloadScene, designWidth: 800, designHeight: 600 });
  }
}