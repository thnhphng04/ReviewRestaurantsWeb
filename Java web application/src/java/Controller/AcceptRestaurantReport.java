/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Lenono
 */
@WebServlet(name = "AcceptRestaurantReport", urlPatterns = {"/AcceptRestaurantReport"})
public class AcceptRestaurantReport extends HttpServlet {

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
            out.println("<title>Servlet AcceptRestaurantReport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AcceptRestaurantReport at " + request.getContextPath() + "</h1>");
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
        int restaurantReportId = Integer.parseInt(request.getParameter("reportId"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));

        ReportDAO report = new ReportDAO();
        report.updateRestaurantReport(restaurantReportId, restaurantId, false, "");
        response.sendRedirect("ReportedRestaurant");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int restaurantReportId = Integer.parseInt(request.getParameter("reportId"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurant-id"));

        String msg = request.getParameter("deny-reason");

        ReportDAO report = new ReportDAO();
        report.updateRestaurantReport(restaurantReportId, restaurantId, true, msg);
        response.sendRedirect("ReportedRestaurant");
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
