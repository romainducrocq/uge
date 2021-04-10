package gameOfLife;

import repast.simphony.context.Context;
import repast.simphony.query.space.grid.MooreQuery;
import repast.simphony.space.grid.Grid;
import repast.simphony.space.grid.GridPoint;
import repast.simphony.util.ContextUtils;

public class AliveAgent extends Agent {


	public AliveAgent(Grid<Agent> grid) {
		super(grid);
		alive = true;}
	
	public void compute() {
		MooreQuery<Agent> query = new MooreQuery<Agent>(grid, this);
		int neighbours = 0;
		for (Agent o : query.query())
			if (o instanceof AliveAgent)
				neighbours++;
		if (neighbours != 2 && neighbours != 3)
			alive = false;
	}
	
	public void implement() {
		if (!alive) {
			GridPoint gpt = grid.getLocation(this);
			Context<Object> context = ContextUtils.getContext(this);
			context.remove(this);
			DeadAgent a = new DeadAgent(grid);
			context.add(a);
			grid.moveTo(a, gpt.getX(), gpt.getY());
		}
	}
}
