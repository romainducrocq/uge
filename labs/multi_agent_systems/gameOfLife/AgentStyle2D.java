package gameOfLife;

import java.awt.Color;

import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.visualizationOGL2D.DefaultStyleOGL2D;

public class AgentStyle2D extends DefaultStyleOGL2D {
	
	@Override
	public Color getColor(Object o) {
			if(RunEnvironment.getInstance().getCurrentSchedule().getTickCount()%2==0)
				return Color.RED;
			else
				return Color.BLUE;
	}
}