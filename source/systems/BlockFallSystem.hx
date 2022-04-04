package systems;

import aeons.components.CNineSlice;
import aeons.core.Entity;
import aeons.tween.easing.Easing;
import aeons.Aeons;
import aeons.components.CCamera;
import aeons.math.Vector2;
import aeons.systems.SimplePhysicsSystem;
import aeons.core.Updatable;
import aeons.components.CSimpleBody;
import components.CFallingBlock;
import aeons.components.CTransform;
import aeons.core.Bundle;
import aeons.core.System;

class BlockFallSystem extends System implements Updatable {

  @:bundle
  var blockBundles: Bundle<CTransform, CFallingBlock, CSimpleBody>;

  @:bundle
  var cameraBundles: Bundle<CTransform, CCamera>;

  var physics: SimplePhysicsSystem;

  var blockCreateSys: BlockCreationSystem;

  var tempStart = new Vector2();
  var tempEnd = new Vector2();

  var staticHitTags = [Constants.STATIC_BLOCK_TAG];

  var fallingHitTags = [Constants.FALLING_BLOCK_TAG];

  var leftWall: CTransform;
  var rightWall: CTransform;

  public function new() {
    super();
  }

  public override function init() {
    super.init();
    physics = getSystem(SimplePhysicsSystem);
    blockCreateSys = getSystem(BlockCreationSystem);
    createWalls();
  }

  public function createWalls() {
    var atlas = Aeons.assets.getAtlas('atlas');
    var eLeft = Aeons.entities.addEntity(new Entity());
    leftWall = eLeft.addComponent(new CTransform({ x: 20, y: Aeons.display.viewCenterY }));
    eLeft.addComponent(new CSimpleBody({ width: 40, height: Aeons.display.viewHeight * 2, type: STATIC }));
    eLeft.addComponent(new CNineSlice({
      insetLeft: 4,
      insetRight: 4,
      insetTop: 4,
      insetBottom: 4,
      atlas: atlas,
      frameName: '9slice',
      width: 40,
      height: Aeons.display.viewHeight * 2
    }));

    var eRight = Aeons.entities.addEntity(new Entity());
    rightWall = eRight.addComponent(new CTransform({ x: Aeons.display.viewWidth - 20, y: Aeons.display.viewCenterY }));
    eRight.addComponent(new CSimpleBody({ width: 40, height: Aeons.display.viewHeight * 2, type: STATIC }));
    eRight.addComponent(new CNineSlice({
      insetLeft: 4,
      insetRight: 4,
      insetTop: 4,
      insetBottom: 4,
      atlas: atlas,
      frameName: '9slice',
      width: 40,
      height: Aeons.display.viewHeight * 2
    }));
  }

  public function update(dt: Float) {
    for (bundle in blockBundles) {
      if (bundle.c_simple_body.type == STATIC) {
        continue;
      }

      for (rayPos in bundle.c_falling_block.rayPositions) {
        bundle.c_transform.getWorldPosition(tempStart);
        var x = tempStart.x;
        var y = tempStart.y;
        tempStart.x += rayPos.x;
        tempStart.y += rayPos.y;
        tempEnd.set(tempStart.x, tempStart.y + Constants.BLOCK_SIZE * 0.5);
        var hits = physics.raycast(tempStart, tempEnd, staticHitTags); 
        if (hits.count > 0) {
          final body = bundle.c_simple_body;
          body.velocity.y = 0;
          body.type = STATIC;
          body.tags.push(Constants.STATIC_BLOCK_TAG);
          body.tags.remove(Constants.FALLING_BLOCK_TAG);
          var hit = hits.first();
          var dist = tempEnd.y - tempStart.y - hit.distance;
          var newPos = Vector2.get(x, y - dist);
          bundle.c_transform.setWorldPosition(newPos);
          blockCreateSys.updateYSpawn(newPos.y);
          for (b in bundle.c_falling_block.extraBodies) {
            b.getComponent(CTransform).setWorldPosition(newPos);
            b.velocity.y = 0;
            b.type = STATIC;
            b.tags.push(Constants.STATIC_BLOCK_TAG);
            b.tags.remove(Constants.FALLING_BLOCK_TAG);
          }

          var cam = cameraBundles.get(0);
          if (cam.c_transform.y > newPos.y) {
            Aeons.tweens.removeAllFrom(cam.c_transform);
            Aeons.tweens.create(cam.c_transform, 1.0, { y: newPos.y }).setEase(Easing.easeOutCubic);
            var change = newPos.y - leftWall.y;
            leftWall.y = rightWall.y = newPos.y;
            physics.worldY += change;
          }
        } else {
          hits = physics.raycast(tempStart, tempEnd, fallingHitTags);
          if (hits.count > 1) {
            for (hit in hits) {
              if (hit.body.velocity.y != bundle.c_simple_body.velocity.y) {
                bundle.c_simple_body.velocity.y = hit.body.velocity.y;
                var dist = tempEnd.y - tempStart.y - hit.distance;
                var newPos = Vector2.get(x, y - dist);
                bundle.c_transform.setWorldPosition(newPos);
                for (b in bundle.c_falling_block.extraBodies) {
                  b.getComponent(CTransform).setWorldPosition(newPos);
                  b.velocity.y = hit.body.velocity.y;
                }
              }
            }
          }
        }
      }
    }
  }
}