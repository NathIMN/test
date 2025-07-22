package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.InquiryModel;
import service.InquiryController;

@WebServlet("/InquiryUpdateSrv")
public class InquiryUpdateSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("user");

        // Only supporters can update
        if (role == null || !"agent".equals(role)) {
            response.sendRedirect("login.jsp?role=agent");
            return;
        }

        try {
            int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
            String status = request.getParameter("status");
            String responseText = request.getParameter("response");

            boolean isTrue = InquiryController.updateStatusAndResponse(inquiryId, status, responseText);

            if (isTrue) {
                List<InquiryModel> inquirydetails = InquiryController.getById(String.valueOf(inquiryId));
                request.setAttribute("inquirydetails", inquirydetails);

                response.getWriter().println("<script> alert('Inquiry updated successfully.'); window.location.href='" + request.getContextPath() + "/InquiryDisplaySrv';</script>");
            } else {
                RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
                dis2.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            RequestDispatcher dis2 = request.getRequestDispatcher("wrong.jsp");
            dis2.forward(request, response);
        }
    }
}
