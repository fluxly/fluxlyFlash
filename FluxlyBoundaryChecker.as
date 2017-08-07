package {

import Box2D.Dynamics.*;


/// This is called when a body's shape passes outside of the world boundary.
public class FluxlyBoundaryChecker extends b2BoundaryListener
{

	/// This is called for each body that leaves the world boundary.
	/// @warning you can't modify the world inside this callback.
	public virtual function Violation(body:b2Body) : void{
	       body.m_userData.onscreen = false;

        }
	
}

}
