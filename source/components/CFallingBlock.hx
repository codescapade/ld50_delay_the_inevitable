package components;

import aeons.math.Vector2;
import aeons.core.Component;

class CFallingBlock extends Component {
  public var rayPositions: Array<Vector2>;

  public function new(options: CFallingBlockOptions) {
    super();
    rayPositions = options.rayPositions;
  }
}

typedef CFallingBlockOptions = {
  var rayPositions: Array<Vector2>;
}