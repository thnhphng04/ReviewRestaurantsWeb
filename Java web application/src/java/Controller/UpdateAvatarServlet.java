/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.ImageDAO;
import Model.AccountDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 *
 * @author cuanl
 */
@MultipartConfig
@WebServlet(name = "UpdateAvatarServlet", urlPatterns = {"/updateAvatar"})
public class UpdateAvatarServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateAvatarServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAvatarServlet at " + request.getContextPath() + "</h1>");
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

        String realPath = request.getServletContext().getRealPath("/images");

        // Ensure the directory exists
        Path uploadPath = Path.of(realPath);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Process each uploaded file
        AccountDao ad = new AccountDao();
        Part part = request.getPart("file");

        String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
        part.write(uploadPath.resolve(filename).toString());

        String filePath = uploadPath + "\\" + filename;
        ad.updateAvatar(accountId, filePath);

        //tao session moi
        HttpSession session = request.getSession();
        AccountDetail a = (AccountDetail) session.getAttribute("AccDetail");
        AccountDetail b = ad.getAccountById(a.getAccountId(), getServletContext());
        session.setAttribute("AccDetail", b);
        session.setMaxInactiveInterval(4000);

        String message = "Bạn đã cập nhật avatar thành công!";

        response.sendRedirect("Profile?accountId="+ a.getAccountId() +"&page=1&message=" + URLEncoder.encode(message, "UTF-8"));

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
