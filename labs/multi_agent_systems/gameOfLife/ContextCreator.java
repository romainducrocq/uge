package gameOfLife;

import repast.simphony.context.Context;
import repast.simphony.context.space.grid.GridFactory;
import repast.simphony.context.space.grid.GridFactoryFinder;
import repast.simphony.dataLoader.ContextBuilder;
import repast.simphony.engine.environment.RunEnvironment;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridBuilderParameters;
import repast.simphony.space.grid.SimpleGridAdder;
import repast.simphony.space.grid.WrapAroundBorders;

public class ContextCreator implements ContextBuilder<Agent> {
	
	
	@Override
	public Context<Agent> build(Context<Agent> context) {
		context.setId("GameOfLife");
		
		int width = RunEnvironment.getInstance().getParameters().getInteger("gridWidth");
		int height = RunEnvironment.getInstance().getParameters().getInteger("gridHeight");
		
		GridFactory gridFactory = GridFactoryFinder.createGridFactory(null);
		Grid<Agent> grid = gridFactory.createGrid("grid", context,  // "grid" is the name used in the xml file
				new GridBuilderParameters<Agent>(new WrapAroundBorders(),  // Manage limits of the grid
						new SimpleGridAdder<Agent>(), false, width, height));
		
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
					boolean b = Math.random()>0.5;
					Agent a = b? new AliveAgent(grid): new DeadAgent(grid);
					context.add(a);
					grid.moveTo(a, x, y);
			}
		}
		
		return context;
	}
}
