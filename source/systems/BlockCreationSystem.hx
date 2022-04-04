package systems;

import components.CBlockSprite;
import blocks.BlockData;
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

  var delay = 1.0;

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
    var block = BlockData.getRandomBlock();

    var rays: Array<Vector2> = [];
    for (ray in block.rays) {
      rays.push(createRay(ray.xi, ray.yi));
    }

    var x = Aeons.random.int(0, Constants.FIELD_WIDTH - block.width);
    var speed = Aeons.random.int(80, 120);
    var entity = Aeons.entities.addEntity(new Entity());
    entity.addComponent(new CTransform({
      x: minX + blockSize * x,
      y: minY - block.height * blockSize
    }));

    var collider = block.colliders[0];
    entity.addComponent(new CSimpleBody({
      width: blockSize * collider.width,
      height: blockSize * collider.height,
      type: KINEMATIC,
      tags: [Constants.FALLING_BLOCK_TAG],
      velocity: { x: 0, y: speed },
      offset: {
        x: collider.x * blockSize + ((collider.width - 1) * blockSize * 0.5),
        y: collider.y * blockSize + ((collider.height - 1) * blockSize * 0.5)
      }
    }));

    var falling = entity.addComponent(new CFallingBlock({rayPositions: rays }));
    entity.addComponent(new CBlockSprite({ block: block }));

    if (block.colliders.length > 1) {
      for (i in 1...block.colliders.length) {
        var collider = block.colliders[i];
        var e = Aeons.entities.addEntity(new Entity());
        e.addComponent(new CTransform({
          x: minX + blockSize * x,
          y: minY - block.height * blockSize
        }));

        var body = e.addComponent(new CSimpleBody({
          width: blockSize * collider.width,
          height: blockSize * collider.height,
          type: KINEMATIC,
          tags: [Constants.FALLING_BLOCK_TAG],
          velocity: { x: 0, y: speed },
          offset: {
            x: collider.x * blockSize + ((collider.width - 1) * blockSize * 0.5),
            y: collider.y * blockSize + ((collider.height - 1) * blockSize * 0.5)
          }
        }));
        falling.extraBodies.push(body);

      }
    }
  }
  function createRay(x: Int, y: Int): Vector2 {
    return Vector2.get(x * blockSize, y * blockSize);
  }
}