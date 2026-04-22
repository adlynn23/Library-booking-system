/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

/**
 *
 * @author DELL
 */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Maintenance;
import dao.MaintenanceDAO;
import javax.servlet.annotation.WebServlet;

@WebServlet("/AddMaintenanceServlet")
public class AddMaintenanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        int facilityId = Integer.parseInt(request.getParameter("facility_id"));
        String start = request.getParameter("start_date");
        String end = request.getParameter("end_date");

        Maintenance m = new Maintenance();
        m.setFacilityId(facilityId);
        m.setStartDate(start);
        m.setEndDate(end);
        m.setStatus("In Progress");

        MaintenanceDAO.addMaintenance(m);

        response.sendRedirect("viewMaintenance.jsp");
    }
}