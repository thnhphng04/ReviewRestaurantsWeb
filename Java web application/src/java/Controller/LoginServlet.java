/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Model.AccountDetail;
import java.io.PrintWriter;
import utils.Encoding;

/**
 *
 * @author admin
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
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
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String remember = request.getParameter("remember");
        
        //tao 3 cookie: username, password, remember
        Cookie cu = new Cookie("email", email);
        Cookie cp = new Cookie("pass", pass);
        Cookie cr = new Cookie("crem", remember);
        
        pass = Encoding.toSHA1(pass);

        
        if (remember != null) {
            //co chon
            cu.setMaxAge(60 * 60 * 24 * 7);// 7 ngay
            cp.setMaxAge(60 * 60 * 24 * 7);// 7 ngay
            cr.setMaxAge(60 * 60 * 24 * 7);// 7 ngay
        } else {
            //khong chon
            cu.setMaxAge(0);
            cp.setMaxAge(0);
            cr.setMaxAge(0);
        }
        response.addCookie(cu);
        response.addCookie(cp);
        response.addCookie(cr);
        String returnUrl = request.getHeader("referer"); // Lấy địa chỉ URL trước đó
        
        
        
        try {
            AccountDao acc = new AccountDao();
            AccountDetail a = acc.login(email, pass,getServletContext());
            if (a == null) {
                request.setAttribute("ms", "message");
                request.setAttribute("message", "Thông tin đăng nhập không chính xác");
                request.getRequestDispatcher("login1.jsp").forward(request, response);

            } else {
                HttpSession session = request.getSession();

                session.setAttribute("AccDetail", a);
                session.setMaxInactiveInterval(4000); // set time active of account (seconds)
                if (returnUrl != null && returnUrl.contains("login")) {
                    if(a.getRole()==2){
                        response.sendRedirect("DashBoard");
                    }else
                    response.sendRedirect("Feed");
                } else {
                    response.sendRedirect(returnUrl);
                }
            }

//            DAO dao = new DAO();
//            Account a = dao.login(name, pass);
//            if (a == null) {
//                request.setAttribute("ms", "message");
//                request.setAttribute("message", "Thông tin đăng nhập không chính xác");
//                request.getRequestDispatcher("login.jsp").forward(request, response);
//            }else{
//                request.getRequestDispatcher("home").forward(request, response);
//            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

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
        request.getRequestDispatcher("login1.jsp").forward(request, response);

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
