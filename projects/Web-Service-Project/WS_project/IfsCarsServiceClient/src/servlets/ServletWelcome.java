package servlets;

	import java.io.IOException;

	import javax.servlet.RequestDispatcher;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
	import javax.xml.rpc.ServiceException;
	
	import ifscarsservice.IfsCarService;
	import ifscarsservice.IfsCarServiceServiceLocator;
	import ifscarsservice.IfsCarServiceSoapBindingStub;
	
@WebServlet("/index")
public class ServletWelcome extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IfsCarService ifc = null; 
	
    public ServletWelcome() {
    	super();
	    	try {
				this.ifc = new IfsCarServiceServiceLocator().getIfsCarService();
				((IfsCarServiceSoapBindingStub) this.ifc).setMaintainSession(true);
			} catch (ServiceException e) {
				e.printStackTrace();
			}		
        }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher;		
		dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher;
		
		request.setAttribute("vehicles", this.ifc.getAllVehicleObj());
		dispatcher = request.getRequestDispatcher("/WEB-INF/shop.jsp");
		dispatcher.forward(request, response);
	}

}