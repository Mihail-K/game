module game.components.sprite_component;

import game_engine.ecs.component;
import game_engine.utils.vector;

class SpriteComponent : Component
{
    enum ID = typeof(this).stringof;

    string resourceID;
    float  rotation  = 0.0;
    Vec3   colorMask = Vec3(1.0);

    this(string resourceID)
    {
        this.resourceID = resourceID;
    }

    override string componentID() const
    {
        return ID;
    }
}
