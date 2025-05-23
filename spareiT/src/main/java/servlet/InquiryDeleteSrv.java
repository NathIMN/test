package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.InquiryModel;
import service.InquiryController;

@WebServlet("/InquiryDeleteSrv")
public class InquiryDeleteSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int inquiryId = Integer.parseInt(request.getParameter("inquiryId")); 

        boolean isTrue = InquiryController.deletedata(String.valueOf(inquiryId));

        if (isTrue) {
            String alertMessage = "Data Delete Successful";
            response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='" + request.getContextPath() + "/InquiryDisplaySrv';</script>");
        } else {
            List<InquiryModel> inquirydetails = InquiryController.getById(String.valueOf(inquiryId)); 
            request.setAttribute("inquirydetails", inquirydetails);
            RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
            dispatcher.forward(request, response);
        }
    }
}
