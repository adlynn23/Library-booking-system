package controller;

import dao.FacilityDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Facility;

@WebServlet("/AdminFacilityServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AdminFacilityServlet extends HttpServlet {

    private final FacilityDAO facilityDAO = new FacilityDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("status".equals(action)) {
            updateStatus(request);
        } else if ("delete".equals(action)) {
            deleteFacility(request);
        } else if ("add".equals(action)) {
            addFacility(request);
        } else if ("edit".equals(action)) {
            editFacility(request);
        }

        response.sendRedirect("admin_facility.jsp");
    }

    private void updateStatus(HttpServletRequest request) {
        int facilityId = Integer.parseInt(request.getParameter("facilityId"));
        String currentStatus = request.getParameter("currentStatus");
        String newStatus = "AVAILABLE".equalsIgnoreCase(currentStatus)
                ? "NOT AVAILABLE"
                : "AVAILABLE";

        facilityDAO.updateFacilityStatus(facilityId, newStatus);
    }

    private void deleteFacility(HttpServletRequest request) {
        int facilityId = Integer.parseInt(request.getParameter("facilityId"));
        facilityDAO.deleteFacility(facilityId);
    }

    private void addFacility(HttpServletRequest request)
            throws IOException, ServletException {

        Facility facility = readFacilityForm(request);
        String imageUrl = saveImage(request.getPart("imageFile"));

        facility.setImageUrl(imageUrl);
        facilityDAO.addFacility(facility);
    }

    private void editFacility(HttpServletRequest request)
            throws IOException, ServletException {

        Facility facility = readFacilityForm(request);
        facility.setFacilityId(Integer.parseInt(request.getParameter("facilityId")));

        String imageUrl = saveImage(request.getPart("imageFile"));
        boolean updateImage = imageUrl != null && !imageUrl.isEmpty();

        if (updateImage) {
            facility.setImageUrl(imageUrl);
        }

        facilityDAO.updateFacility(facility, updateImage);
    }

    private Facility readFacilityForm(HttpServletRequest request) {
        Facility facility = new Facility();

        facility.setFacilityName(request.getParameter("facilityName"));
        facility.setUnitName(request.getParameter("unitName"));
        facility.setDescription(request.getParameter("description"));
        facility.setCapacity(Integer.parseInt(request.getParameter("capacity")));

        return facility;
    }

    private String saveImage(Part imagePart) throws IOException {
        if (imagePart == null || imagePart.getSize() == 0) {
            return null;
        }

        String submittedFileName = Paths.get(imagePart.getSubmittedFileName())
                .getFileName()
                .toString();

        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
            return null;
        }

        String safeFileName = System.currentTimeMillis()
                + "_"
                + submittedFileName.replaceAll("[^A-Za-z0-9._-]", "_");

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        imagePart.write(uploadPath + File.separator + safeFileName);

        return "uploads/" + safeFileName;
    }
}
