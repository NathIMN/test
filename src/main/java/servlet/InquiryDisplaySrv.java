package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.InquiryModel;
import service.InquiryController; 

@WebServlet("/InquiryDisplaySrv")
public class InquiryDisplaySrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the role from the session
        String role = (String) request.getSession().getAttribute("user");
        int userId = (int) request.getSession().getAttribute("userId");
        List<InquiryModel> allInquiries;
        
        System.out.println("Role: " + role);
        System.out.println("UserId: " + userId);

        // Check if the role is "Customer" or "Agent"
        if ("customer".equals(role)) {
            // Customer only sees their own inquiries
            if (userId != 0) {
                allInquiries = InquiryController.getInquiriesByCustomerId(userId);
            } else {
                allInquiries = null; 
            }

            // Forward to the customer inquiry display page
            System.out.println(allInquiries);
            request.setAttribute("allInquiries", allInquiries);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Inquiry/inquiryDisplay.jsp");
            dispatcher.forward(request, response);
            
        } else if ("agent".equals(role)) {
            // Supporter (Agent) sees all inquiries
            allInquiries = InquiryController.getAllInquiry();
            // Forward to the supporter inquiry display page
            request.setAttribute("allInquiries", allInquiries);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Inquiry/agentDisplay.jsp");
            dispatcher.forward(request, response);
        } else {
            // If the user is not logged in or invalid role, redirect to login page
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
