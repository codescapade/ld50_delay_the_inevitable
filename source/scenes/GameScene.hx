package scenes;

import aeons.graphics.Color;
import aeons.components.CNineSlice;
import systems.BlockCreationSystem;
import systems.BlockFallSystem;
import aeons.math.Vector2;
import components.CFallingBlock;
import aeons.systems.SimplePhysicsSystem;
import aeons.components.CSimpleBody;
import aeons.Aeons;
import aeons.systems.UpdateSystem;
import aeons.systems.DebugRenderSystem;
import aeons.components.CCamera;
import aeons.components.CTransform;
import aeons.core.Entity;
import aeons.core.Scene;
import aeons.systems.RenderSystem;


class GameScene extends Scene {

  private var startX = 40 + Constants.BLOCK_SIZE * 0.5;
  private var startY = Constants.BLOCK_SIZE * 0.5;

  public override function init() {
    addSystem(new UpdateSystem());
    addSystem(new SimplePhysicsSystem({
      worldY: -Aeons.display.viewHeight * 1.5,
      worldWidth: Aeons.display.viewWidth,
      worldHeight: Aeons.display.viewHeight * 3
    }));
    addSystem(new BlockCreationSystem());
    addSystem(new BlockFallSystem());

    addSystem(new RenderSystem());
    // addSystem(new DebugRenderSystem());

    createCamera();
    createFloor();
  }

  function createCamera() {
    final eCamera = addEntity(new Entity());
    eCamera.addComponent(new CTransform());
    eCamera.addComponent(new CCamera({ zoom: 1 }));
  }

  function createFloor() {
    final entity = addEntity(new Entity());
    entity.addComponent(new CTransform({
      x: Aeons.display.viewCenterX,
      y: Aeons.display.viewHeight - 10
    }));

    entity.addComponent(new CSimpleBody({
      width: Aeons.display.viewWidth,
      height: 20,
      type: STATIC,
      tags: [Constants.STATIC_BLOCK_TAG]
    }));

    var atlas = Aeons.assets.getAtlas('atlas');
    entity.addComponent(new CNineSlice({
      insetLeft: 4,
      insetRight: 4,
      insetTop: 4,
      insetBottom: 4,
      atlas: atlas,
      frameName: '9slice',
      width: Aeons.display.viewWidth - 80,
      height: 20,
    }));
  }
}