/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.PostDAO;
import DAL.RestaurantDAO;
import Model.AccountDetail;
import Model.Post;
import Model.Restaurant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
@WebServlet(name = "RestaurantServlet", urlPatterns = {"/RestaurantPage"})
public class RestaurantPageServlet extends HttpServlet {

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
            out.println("<title>Servlet RestaurantServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RestaurantServlet at " + request.getContextPath() + "</h1>");
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
        
        String message = request.getParameter("message");
        request.setAttribute("message", message);

        String restaurantId = request.getParameter("restaurantId");

        RestaurantDAO rd = new RestaurantDAO();
        Restaurant r = rd.getRestaurantById(Integer.parseInt(restaurantId), getServletContext());
        request.setAttribute("restaurant", r);

        PostDAO pd = new PostDAO();
        List<Post> posts = pd.getPostsByRestaurantId(restaurantId, getServletContext());
        Map<AccountDetail, Post> map = new LinkedHashMap<>();
        AccountDao ad = new AccountDao();
        for (Post p : posts) {
            map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
        }
        request.setAttribute("postMap", map);

        float averageRate = 0;
        float sum = 0;
        for (Post p : posts) {
            sum += p.getRating();
        }
        if (posts.size() > 0) {
            averageRate = sum / posts.size();
        }
        DecimalFormat df = new DecimalFormat("#.#"); // Định dạng để chỉ có một chữ số sau dấu chấm
        
        String averageRateString = df.format(averageRate);

        request.setAttribute("averageRate", averageRateString);
        request.setAttribute("numberOfPost", posts.size());

        request.getRequestDispatcher("restaurantPage.jsp").forward(request, response);
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
        processRequest(request, response);
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
