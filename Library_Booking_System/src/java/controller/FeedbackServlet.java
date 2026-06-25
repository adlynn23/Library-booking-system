package controller;

import dao.FeedbackDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Feedback;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("adminReply".equalsIgnoreCase(action)) {
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
            String status = request.getParameter("status");
            String adminReply = request.getParameter("adminReply");
            String priority = request.getParameter("priority");
            String category = request.getParameter("category");
            String expectedCompletion = request.getParameter("expectedCompletion");

            int result = FeedbackDAO.updateAdminReply(feedbackId, status, adminReply,
                    priority, category, expectedCompletion);

            if (result > 0) {
                response.sendRedirect("viewMaintenance.jsp?replySuccess=true");
            } else {
                response.sendRedirect("viewMaintenance.jsp?replyError=true");
            }
            return;
        }

        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        String matric_no = (String) request.getSession().getAttribute("matricNo");

        Feedback f = new Feedback();
        f.setMatric_no(matric_no);
        f.setSubject(subject);
        f.setMessage(message);

        int result = FeedbackDAO.insertFeedback(f);

        if (result > 0) {
            response.sendRedirect("custCare.jsp?success=true");
        } else {
            response.sendRedirect("custCare.jsp?error=true");
        }
    }
}
