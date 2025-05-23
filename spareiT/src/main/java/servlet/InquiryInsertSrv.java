package servlet;

import java.io.IOException;


import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.InquiryController;

@WebServlet("/InquiryInsertSrv")
public class InquiryInsertSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); 
        if (session == null || session.getAttribute("user") == null || !"customer".equals(session.getAttribute("user"))) {
            // Not logged in as customer
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=customer");
            return;
        }
        

        try {
            int cusId = (int)session.getAttribute("userId");

            // Get form parameters (only the ones filled by user)
            String vehicleMake = request.getParameter("vehicleMake");
            String vehicleModel = request.getParameter("vehicleModel");
            int yearOfManufacture = Integer.parseInt(request.getParameter("yearOfManufacture"));
            String partName = request.getParameter("partName");
            String description = request.getParameter("description");
            int quantityRequired = Integer.parseInt(request.getParameter("quantityRequired"));
            String urgencyLevel = request.getParameter("urgencyLevel");
            String inquiryType = request.getParameter("inquiryType");

            // System-generated fields
            Timestamp inquiryDate = new Timestamp(System.currentTimeMillis());
            String status = "Pending";
            String responseText = null;
            Integer supportAgentId = null;

            boolean isTrue = InquiryController.insertdata(cusId, vehicleMake, vehicleModel, yearOfManufacture,
                    partName, inquiryDate, description, quantityRequired, urgencyLevel,
                    inquiryType, status, responseText, supportAgentId);

            if (isTrue) { 
                String alertMessage = "Inquiry submitted successfully!";
                response.getWriter().println(
                    "<script>alert('" + alertMessage + "'); window.location.href='" + request.getContextPath() + "/InquiryDisplaySrv';</script>");
            } else {
                RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
                dis2.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
