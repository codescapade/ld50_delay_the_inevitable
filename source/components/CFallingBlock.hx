package components;

import aeons.components.CSimpleBody;
import aeons.math.Vector2;
import aeons.core.Component;

class CFallingBlock extends Component {
  public var rayPositions: Array<Vector2>;
  public var extraBodies: Array<CSimpleBody> = [];

  public function new(options: CFallingBlockOptions) {
    super();
    rayPositions = options.rayPositions;
  }
}

typedef CFallingBlockOptions = {
  var rayPositions: Array<Vector2>;
}