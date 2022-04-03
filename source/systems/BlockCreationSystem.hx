package systems;

import components.CFallingBlock;
import aeons.components.CSimpleBody;
import aeons.components.CTransform;
import aeons.core.Entity;
import aeons.Aeons;
import aeons.math.Vector2;
import aeons.core.Updatable;
import aeons.core.System;

class BlockCreationSystem extends System implements Updatable {

  final blockSize = Constants.BLOCK_SIZE;

  var minX: Float;

  var minY: Float; 

  var delay = 2.0;

  var timer = 0.0;

  public function new() {
    super();

    minX = 40 + blockSize * 0.5;
    minY = 0;
  }

  public function update(dt: Float) {
    timer += dt;
    if (timer > delay) {
      createBlock();
      timer = 0;
    }
  }

  public function updateYSpawn(y: Float) {
    final newY = y - Aeons.display.viewHeight;
    if (newY < minY) {
      minY = newY;
    }
  }

  function createBlock() {
    var width = Aeons.random.int(1, 3);
    var height = Aeons.random.int(1, 3);

    var rays: Array<Vector2> = [];
    for (i in 0...width) {
      rays.push(createRay(i, height - 1));
    }

    var x = Aeons.random.int(0, Constants.FIELD_WIDTH - width);
    var speed = Aeons.random.int(40, 80);
    var entity = Aeons.entities.addEntity(new Entity());
    entity.addComponent(new CTransform({
      x: minX + blockSize * x,
      y: minY - height * blockSize
    }));

    entity.addComponent(new CSimpleBody({
      width: blockSize * width,
      height: blockSize * height,
      type: KINEMATIC,
      tags: [Constants.FALLING_BLOCK_TAG],
      velocity: { x: 0, y: speed },
      offset: { x: (width - 1) * blockSize * 0.5, y: (height - 1) * blockSize * 0.5 }
    }));

    entity.addComponent(new CFallingBlock({rayPositions: rays }));
  }

  function createRay(x: Int, y: Int): Vector2 {
    return Vector2.get(x * blockSize, y * blockSize);
  }
}