package blocks;

import aeons.Aeons;
import aeons.graphics.Color;
import aeons.math.Vector2;
import aeons.math.Rect;

class BlockData {

  static var single: Block;

  static var twoH: Block;
  static var twoV: Block;

  static var threeH: Block;
  static var threeV: Block;

  static var fourH: Block;
  static var fourV: Block;

  static var teeU: Block;
  static var teeR: Block;
  static var teeD: Block;
  static var teeL: Block;

  static var elU: Block;
  static var elR: Block;
  static var elD: Block;
  static var elL: Block;

  static var blockTypes: Array<BlockType> = [
    SINGLE,
    TWO,
    THREE,
    FOUR,
    TEE,
    EL
  ];

  public static function init() {
    createSingle();

    createTwoH();
    createTwoV();

    createThreeH();
    createThreeV();

    createFourH();
    createFourV();

    createTU();
    createTR();
    createTD();
    createTL();

    createLU();
    createLR();
    createLD();
    createLL();
  }

  public static function getRandomBlock(): Block {
    var blockType = blockTypes[Aeons.random.int(0, blockTypes.length - 1)];

    switch (blockType) {
      case SINGLE:
        return single;

      case TWO:
        var nr = Aeons.random.int(0, 1);
        if (nr == 0) {
          return twoH;
        } else {
          return twoV;
        }

      case THREE:
        var nr = Aeons.random.int(0, 1);
        if (nr == 0) {
          return threeH;
        } else {
          return threeV;
        }

      case FOUR:
        var nr = Aeons.random.int(0, 1);
        if (nr == 0) {
          return fourH;
        } else {
          return fourV;
        }

      case TEE:
        var nr = Aeons.random.int(0, 3);
        if (nr == 0) {
          return teeU;
        } else if (nr == 1) {
          return teeR;
        } else if (nr == 2) {
          return teeD;
        } else {
          return teeL;
        }

      case EL:
        var nr = Aeons.random.int(0, 3);
        if (nr == 0) {
          return elU;
        } else if (nr == 1) {
          return elR;
        } else if (nr == 2) {
          return elD;
        } else {
          return elL;
        }
    }
  }

  static function createSingle() {
    single = new Block(
      [
        [1, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 1)
      ],
      [
        new Vector2(0, 0)
      ],
      Color.fromBytes(80, 200, 80),
      'block'
    );
  }

  static function createTwoH() {
    twoH = new Block(
      [
        [1, 1, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 2, 1)
      ],
      [
        new Vector2(0, 0),
        new Vector2(1, 0)
      ],
      Color.fromBytes(80, 80, 200),
      'block'
    );
  }

  static function createTwoV() {
    twoV = new Block(
      [
        [1, 0, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 2)
      ],
      [
        new Vector2(0, 1)
      ],
      Color.fromBytes(80, 80, 200),
      'block'
    );
  }

  static function createThreeH() {
    threeH = new Block(
      [
        [1, 1, 1, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 3, 1)
      ],
      [
        new Vector2(0, 0),
        new Vector2(1, 0),
        new Vector2(2, 0),
      ],
      Color.fromBytes(200, 80, 200),
      'block'
    );
  }

  static function createThreeV() {
    threeV = new Block(
      [
        [1, 0, 0, 0],
        [1, 0, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 3)
      ],
      [
        new Vector2(0, 2)
      ],
      Color.fromBytes(200, 80, 200),
      'block'
    );
  }

  static function createFourH() {
    fourH = new Block(
      [
        [1, 1, 1, 1],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 4, 1)
      ],
      [
        new Vector2(0, 0),
        new Vector2(1, 0),
        new Vector2(2, 0),
        new Vector2(3, 0)
      ],
      Color.fromBytes(200, 200, 80),
      'block'
    );
  }

  static function createFourV() {
    fourV = new Block(
      [
        [1, 0, 0, 0],
        [1, 0, 0, 0],
        [1, 0, 0, 0],
        [1, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 4)
      ],
      [
        new Vector2(0, 3)
      ],
      Color.fromBytes(200, 200, 80),
      'block'
    );
  }

  static function createTU() {
    teeU = new Block(
      [
        [0, 1, 0, 0],
        [1, 1, 1, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(1, 0, 1, 1),
        new Rect(0, 1, 3, 1)
      ],
      [
        new Vector2(0, 1),
        new Vector2(1, 1),
        new Vector2(2, 1)
      ],
      Color.fromBytes(200, 80, 80),
      'block'
    );
  }

  static function createTR() {
    teeR = new Block(
      [
        [1, 0, 0, 0],
        [1, 1, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 3),
        new Rect(1, 1, 1, 1)
      ],
      [
        new Vector2(0, 2),
        new Vector2(1, 1)
      ],
      Color.fromBytes(200, 80, 80),
      'block'
    );
  }

  static function createTD() {
    teeD = new Block(
      [
        [1, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 3, 1),
        new Rect(1, 1, 1, 1)
      ],
      [
        new Vector2(0, 0),
        new Vector2(1, 1),
        new Vector2(2, 0)
      ],
      Color.fromBytes(200, 80, 80),
      'block'
    );
  }
  
  static function createTL() {
    teeL = new Block(
      [
        [0, 1, 0, 0],
        [1, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 1, 1, 1),
        new Rect(1, 0, 1, 3)
      ],
      [
        new Vector2(0, 1),
        new Vector2(1, 2)
      ],
      Color.fromBytes(200, 80, 80),
      'block'
    );
  }

  static function createLU() {
    elU = new Block(
      [
        [1, 0, 0, 0],
        [1, 0, 0, 0],
        [1, 1, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 3),
        new Rect(1, 2, 1, 1)
      ],
      [
        new Vector2(0, 2),
        new Vector2(1, 2)
      ],
      Color.fromBytes(80, 200, 200),
      'block'
    );
  }

  static function createLR() {
    elR = new Block(
      [
        [1, 1, 1, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 3, 1),
        new Rect(0, 1, 1, 1)
      ],
      [
        new Vector2(0, 1),
        new Vector2(1, 0),
        new Vector2(2, 0),
      ],
      Color.fromBytes(80, 200, 200),
      'block'
    );
  }
  
  static function createLD() {
    elD = new Block(
      [
        [1, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(0, 0, 1, 0),
        new Rect(1, 0, 1, 3)
      ],
      [
        new Vector2(0, 0),
        new Vector2(1, 2),
      ],
      Color.fromBytes(80, 200, 200),
      'block'
    );
  }
  
  static function createLL() {
    elL = new Block(
      [
        [0, 0, 1, 0],
        [1, 1, 1, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      [
        new Rect(2, 0, 1, 0),
        new Rect(0, 1, 3, 1)
      ],
      [
        new Vector2(0, 1),
        new Vector2(1, 1),
        new Vector2(2, 1)
      ],
      Color.fromBytes(80, 200, 200),
      'block'
    );
  }
  
}

enum BlockType {
  SINGLE;
  TWO;
  THREE;
  FOUR;
  TEE;
  EL;
}