package scenes;

import aeons.components.CCamera;
import aeons.components.CTransform;
import aeons.core.Entity;
import aeons.core.Scene;
import aeons.systems.RenderSystem;


class GameScene extends Scene {

  public override function init() {
    addSystem(new RenderSystem());

    createCamera();

  }

  function createCamera() {
    final eCamera = addEntity(new Entity());
    eCamera.addComponent(new CTransform());
    eCamera.addComponent(new CCamera());
  }
}