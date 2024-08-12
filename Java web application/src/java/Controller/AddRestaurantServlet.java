/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.ImageDAO;
import DAL.RestaurantDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.sql.Time;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author cuanl
 */
@MultipartConfig
@WebServlet(name = "AddRestaurantServlet", urlPatterns = {"/addRestaurant"})
public class AddRestaurantServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddRestaurantServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRestaurantServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountId = request.getParameter("accountId");
        String name = request.getParameter("name");
        String address = request.getParameter("address") + " ," + request.getParameter("phuong") + " ," + request.getParameter("quan") + " ," + request.getParameter("tinh");
        String phoneNumber = request.getParameter("phone_number");
        String lowestPrice = request.getParameter("lowest_price");
        String highestPrice = request.getParameter("highest_price");

        String openingHours = request.getParameter("opening_hours");
        String closingHours = request.getParameter("closing_hours");
        // Convert the time strings to java.sql.Time
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        Time openTime = null;
        Time closeTime = null;
        try {
            openTime = new Time(sdf.parse(openingHours).getTime());
            closeTime = new Time(sdf.parse(closingHours).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //xử lí ảnh
        String realPath = request.getServletContext().getRealPath("/images");
        // Ensure the directory exists
        Path uploadPath = Path.of(realPath);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        // Processuploaded file
        Part partAva = request.getPart("fileAva");
        String filenameAva = Path.of(partAva.getSubmittedFileName()).getFileName().toString();
        partAva.write(uploadPath.resolve(filenameAva).toString());

        String filePathAva = uploadPath + "\\" + filenameAva;

        RestaurantDAO rd = new RestaurantDAO();
        rd.insertRestaurant(name, address, phoneNumber, lowestPrice, highestPrice, openTime, closeTime, accountId, filePathAva);

        //process proof images
        ImageDAO imd = new ImageDAO();
        String restaurantId = String.valueOf(rd.getRestaurantId());
        for (Part part : request.getParts()) {
            if (part.getName().equals("files2") && part.getSize() > 0) {
                String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
                if (filename != null && !filename.isEmpty()) {
                    part.write(uploadPath.resolve(filename).toString());

                    String filePath = uploadPath + "/" + filename;

                    imd.insertRestaurantProofImage(restaurantId, filePath);
                }
            }
        }

        response.sendRedirect("Profile?accountId=" + accountId + "&page=3");

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
