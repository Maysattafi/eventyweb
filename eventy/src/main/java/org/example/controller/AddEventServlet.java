package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.EventDAO;
import org.example.models.Event;
import java.io.*;
import java.util.UUID;

@WebServlet("/AddEventServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,   // 2 MB
        maxFileSize = 1024 * 1024 * 10,        // 10 MB
        maxRequestSize = 1024 * 1024 * 50      // 50 MB
)
public class AddEventServlet extends HttpServlet {

    private final String UPLOAD_DIR = "images/events";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String dateEvent = request.getParameter("date_event");
        String nSale = request.getParameter("n_sale");
        String categorie = request.getParameter("categorie");

        // Handle image upload
        Part filePart = request.getPart("image");
        String imagePath = "";

        if (filePart != null && filePart.getSize() > 0) {
            String originalFileName = extractFileName(filePart);
            String fileExtension = "";

            if (originalFileName.contains(".")) {
                fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            }

            // Generate unique filename to avoid conflicts
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Create upload directory if it doesn't exist
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            String fullPath = uploadPath + File.separator + uniqueFileName;
            filePart.write(fullPath);

            // Store relative path for database and display
            imagePath = UPLOAD_DIR + "/" + uniqueFileName;
        }

        // Create Event object
        Event event = new Event();
        event.setTitre(titre);
        event.setDescription(description);
        event.setDateEvent(dateEvent);
        event.setnSale(nSale);
        event.setImage(imagePath);
        event.setCategory(categorie);

        // Save to database
        EventDAO eventDAO = new EventDAO();
        boolean success = eventDAO.addEvent(event);

        if (success) {
            response.sendRedirect("admin?action=events&success=added");
        } else {
            response.sendRedirect("ajouterEvenement.jsp?error=failed");
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}