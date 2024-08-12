/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAL.AccountDao;
import DAL.PostDAO;
import DAL.ReportDAO;
import DAL.RestaurantDAO;
import Model.AccountDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashSet;

/**
 *
 * @author Lenono
 */
@WebServlet(name="DashBoard", urlPatterns={"/DashBoard"})
public class DashBoard extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet DashBoard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashBoard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AccountDao dao =new AccountDao();
        AccountDetail acc = new AccountDetail();
        RestaurantDAO res = new RestaurantDAO();
        PostDAO post = new PostDAO();      
        ReportDAO report = new ReportDAO();
        int accCount=dao.getTotalAcc();
        int resCount=res.getTotalRetaurants();
        int postRequestCount = post.getTotalPostRequest();
        int restaurantResquestCount = res.getTotalRestaurantRequests();
        int postReportRequestCount = report.getTotalReportPost();
        int restaurantReportRequestCount = report.getTotalReportRestaurant();
        int editPostCount= post.getTotalEditPostRequest();
        int editResCount = res.getTotalEditRestaurantRequest();
        request.setAttribute("totalRestaurantEdit", editResCount);
        request.setAttribute("totalPostEdit", editPostCount);
        request.setAttribute("reportPost", postReportRequestCount);
        request.setAttribute("reportRestaurant", restaurantReportRequestCount);
        request.setAttribute("postCount", postRequestCount);
        request.setAttribute("accCount", accCount);
        request.setAttribute("resCount", resCount);
        request.setAttribute("resRequestCount", restaurantResquestCount);
        request.getRequestDispatcher("DashBoard.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
